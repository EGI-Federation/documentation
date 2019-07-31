# EGI documentation

Sources to build EGI documentation static pages.

* [Hugo](https://gohugo.io/) is used to build a static website.
* The theme [docdock](https://docdock.netlify.com/) is used.
* The static site is [deployed on GitHub](https://gohugo.io/hosting-and-deployment/hosting-on-github/) using a dedicated [GitHub repository](https://github.com/EGI-Foundation/EGI-Foundation.github.io)

## Usage

### Testing locally

```console
hugo server -D
```

Now open http://localhost:1313/

### Deploying to the EGI organisation pages

```console
./deploy.sh
```
