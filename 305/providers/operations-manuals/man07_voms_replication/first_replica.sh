#!/bin/sh
#
# Default prefix
VOMS_LOCATION=${VOMS_LOCATION:-NONE}

if test -z "$VOMS_LOCATION_VAR" ; then
    VOMS_LOCATION_VAR=$VOMS_LOCATION/var
fi

CERTDIR=${CERTDIR:-/etc/grid-security/certificates} #CERTDIR
voms_database=""                                    # VOMS database
master_host=""                                      # Master
master_mysql_user=""                                # Master MySQL admin user
master_mysql_pwd=""                                 # Master MySQL admin pass
master_log_file=""                                  # Master LOG file
master_log_pos=""                                   # Master LOG file
mysql_username_admin="root"                         # MySQL admin username
mysql_password_admin=""                             # MySQL admin pass
verbose=""

TEMP=$(getopt -o hv --long \
    mysql-home:,db:,mysql-admin:,mysql-pwd:,master-host:,master-mysql-user:,master-mysql-pwd:,master-log-file:,master-db:,master-log-pos: \
    -n 'voms_install_replica' -- "$@")

if [ $? != 0 ] ; then
    echo "Terminating..." >&2
    exit 1
fi

eval set -- "$TEMP"

while true ; do
    case "$1" in
        --db)                     voms_database=$2           ; shift 2 ;;
        --mysql-admin)            mysql_username_admin=$2    ; shift 2 ;;
        --mysql-pwd)              mysql_password_admin=$2    ; shift 2 ;;
        --master-host)            master_host=$2             ; shift 2 ;;
        --master-mysql-user)      master_mysql_user=$2       ; shift 2 ;;
        --master-mysql-pwd)       master_mysql_pwd=$2        ; shift 2 ;;
        --master-db)              master_db=$2               ; shift 2 ;;
        --master-log-file)        master_log_file=$2         ; shift 2 ;;
        --master-log-pos)         master_log_pos=$2          ; shift 2 ;;
        -v)                       verbose="1"                ; shift   ;;
        -h)                       echo "This is the help"    ; exit 1  ;;
        --)                       shift                      ; break   ;;
        *)                        echo "Internal Error!" >&2 ; exit 1  ;;
    esac
done

###############################################################################
#STOP ACTIVITY

MYSQL=mysql
if ! test -z $verbose ; then
    echo "VOMS_INSTALL_REPLICA: LOCK MASTER TABLES.."
fi
$MYSQL -h "$master_host" -u "$master_mysql_user" \
    -p"$master_mysql_pwd" -e "FLUSH TABLES WITH READ LOCK" #  STOP MASTER

MYSQL="mysql -u$mysql_username_admin -p$mysql_password_admin"
if ! test -z $verbose ; then
    echo "VOMS_INSTALL_REPLICA: STOP SLAVE.."
fi
#$MYSQL                -e "RESET SLAVE"                  # May help..
$MYSQL                 -e "STOP SLAVE"                   # STOP SLAVE

#DUPLICATE DATABASE
if ! test -z $verbose ; then
    echo "VOMS_INSTALL_REPLICA: DUPLICATE DB (MYSQLDUMP).."
fi
$MYSQL -e "DROP DATABASE IF EXISTS $voms_database; CREATE DATABASE $voms_database;"
mysqldump --host "$master_host" -u "$master_mysql_user" \
    -p"$master_mysql_pwd" --opt "$master_db" \
    | $MYSQL -C "$voms_database;"
$MYSQL -D "$voms_database" -e "update seqnumber set seq=00"

#GET MASTER STATUS
if test -z "$master_log_file"; then
if ! test -z $verbose ; then
    echo "VOMS_INSTALL_REPLICA: GET MASTER LOG FILE AND POS.."
fi
master_log_file=$(mysql -h "$master_host" -u "$master_mysql_user" \
    -p"$master_mysql_pwd" -e "show master status" | awk 'NR==2 {print $1}')
master_log_pos=$(mysql -h "$master_host" -u "$master_mysql_user" \
    -p"$master_mysql_pwd" -e "show master status" | awk 'NR==2 {print $2}')
fi

#WRITE MASTER INFO
$MYSQL <<EOF
CHANGE MASTER TO MASTER_HOST='$master_host',MASTER_USER='$master_mysql_user',MASTER_PASSWORD='$master_mysql_pwd',MASTER_LOG_FILE='$master_log_file',MASTER_LOG_POS=$master_log_pos;
EOF

cat <<EOF
CHANGE MASTER TO MASTER_HOST='$master_host',MASTER_USER='$master_mysql_user',MASTER_PASSWORD='$master_mysql_pwd',MASTER_LOG_FILE='$master_log_file',MASTER_LOG_POS=$master_log_pos;
EOF

cat > /etc/my.cnf <<EOF

[mysqld]
server-id=2
master-host=$master_host
master-user=$master_mysql_user
master-password=$master_mysql_pwd
replicate-do-db=$master_db
replicate-ignore-table=$master_db.seqnumber
replicate-ignore-table=$master_db.realtime
replicate-ignore-table=$master_db.transactions
replicate-ignore-table=$voms_database.seqnumber
replicate-ignore-table=$voms_database.realtime
replicate-ignore-table=$voms_database.transactions
EOF

if ! test -z $verbose ; then echo "VOMS_INSTALL_REPLICA: MYSQL RESTART.." ; fi
/etc/init.d/mysqld restart
#service mysql restart
sleep 1

$MYSQL                 -e "START SLAVE"                   # START SLAVE

MYSQL=mysql
if ! test -z $verbose ; then
    echo "VOMS_INSTALL_REPLICA: UNLOCK MASTER TABLES.."
fi
$MYSQL -h "$master_host" -u "$master_mysql_user" \
    -p"$master_mysql_pwd" -e "UNLOCK TABLES"
