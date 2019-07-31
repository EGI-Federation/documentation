# EGI documentation

Sources to build EGI documentation static pages.

* [Hugo](https://gohugo.io/) is used to build a static website.
* The theme [docdock](https://docdock.netlify.com/) is used.
* The static site is [deployed on GitHub](https://gohugo.io/hosting-and-deployment/hosting-on-github/) using a dedicated [GitHub repository](https://github.com/EGI-Foundation/EGI-Foundation.github.io) linked as a submodule under `public/`.

## Usage

### Cloning the submodule to publish changes

Contributors allowed to push to the
https://github.com/EGI-Foundation/EGI-Foundation.github.io repository can
download the submodule.

```console
# Enter repository clone
cd documentation
# Clone submodules
git submodule update --init --recursive
```

### Updating the theme

To keep complete over the [docdock](https://docdock.netlify.com/) theme it was
decided to use a snapshot of its master branch, thus allowing to keep complete
control over the updates.

### Testing locally

```console
hugo server -D
```

Now open http://localhost:1313/

### Deploying to the EGI organisation pages

```console
./deploy.sh
```
