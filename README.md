# Forest Watcher Service Template

This repository can be used as code template for new forest watcher microservices.

Please read more about what's included in the template [here](https://github.com/3sidedcube/fw_service_readme_template).

While following the installation steps below [degit](https://github.com/Rich-Harris/degit) will **replace** this README file with the README file [here](https://github.com/3sidedcube/fw_service_readme_template), to learn more about this step [click here](https://github.com/Rich-Harris/degit#actions).

## Installation

Use [degit](https://github.com/Rich-Harris/degit) to scaffold a new repository, first install `degit` globally
```shell
npm install -g degit
```
Then scaffold a new repository using the template
```shell
degit git@github.com:3sidedcube/fw_service_template my-new-fw-service
```
Initialise git
```shell
cd my-new-fw-service
git init
```
Rename `docs/fw_service_template.yaml` to the name of the new service, for example `fw_user.yaml`

Rename the master branch to `production`
```shell
git branch -m production
```
Create an initial commit to production
```shell
git add .
git commit -m "Init"
```
Create two new branches
```shell
git branch staging production
git branch dev production
```
Push the local repository to WRI's remote repository, you will need to get them to set a blank one up
```shell
git remote add origin git@github.com:wri/<...>.git
git push -u origin production
git push -u origin staging
git push -u origin dev
```

You should all be setup, read the new README file to understand the next steps!

### GitHub pages docs
If you wish to host the OpenAPI docs using GitHub pages follow the steps below:

Create a blank branch called `gh_pages_docs`
```shell
git checkout --orphan gh_pages_docs
git rm -rf .
```
Copy the docs template into the empty branch
```shell
degit --force git@github.com:3sidedcube/fw_service_template#gh_pages_docs
```
Update the constants in `js/changeEnvironment.js` replacing `<...>` with the name of the remote repository and the name of the yaml doc file you renamed earlier
```javascript
const ENV = [
    {
        selector: "#switch-prod",
        docsURL: "https://raw.githubusercontent.com/wri/<...>/production/docs/<...>.yaml"
    },
    {
        selector: "#switch-staging",
        docsURL: "https://raw.githubusercontent.com/wri/<...>/staging/docs/<...>.yaml"
    },
    {
        selector: "#switch-dev",
        docsURL: "https://raw.githubusercontent.com/wri/<...>/dev/docs/<...>.yaml"
    }
]
```
Create an initial commit to the `gh_pages_docs` branch
```shell
git add .
git commit -m "Init"
```
And push to WRI's remote repository
```shell
git push -u origin gh_pages_docs
```
In the repository on GitHub go to
> Settings > Pages

Select `gh_pages_docs` as the source branch, leave the folder as `/(root)` and press save.\
Once the GitHub page is published it should be available at the URL displayed in the settings.

Made with 💚 at 3 Sided Cube
