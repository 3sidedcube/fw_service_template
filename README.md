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
You should all be setup, happy hacking 💚
