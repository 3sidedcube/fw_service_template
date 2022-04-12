# Forest Watcher Service Template

This repository can be used as code template for new forest watcher microservices.
It will deploy a dockerized application on AWS fargate and expose endpoints under the public URL

- fw-api.globalforestwatch.org
- staging-fw-api.globalforestwatch.org
- dev-fw-api.globalforestwatch.org

for production, staging and dev environments correspondingly.

The application itself is written in [Nodejs](https://nodejs.org/). Application code must be located in the `app/src` folder. The Dockerfile should always be place at the root of the repository.

The app is a [Koa v2](https://koajs.com/) application with TypeScript support. Which is structured like so:
```markdown
- app/src               # Source code for the service
    - /models           # Database ORM/ODM models
    - /routes           # Routers for the service
    - /serializers      # Serialisers for response object
    - /services         # Reusable services
    - /validators       # Validators for request objects
    app.ts              # Root for the app
```

## Terraform

The provided terraform template will
- build a docker image based on the Dockerfile
- upload the docker image to AWS ECR
- create a new Fargate service in the Forest Watcher AWS ECS cluster using the docker image
- create a new target group for the Fargate service and link it to the Forest Watcher Application Load balancer

The Fargate service will have access to
- Document DB cluster
- Redis Cluster
- S3 Bucket

Relevant endpoints and secrets to access those services are available as environment variables inside the container.

The Forest Watcher Application Load Balancer can be linked to multiple services.
Each service must have a unique path pattern. Path patterns for a given service must be specified in the 
lb_listener_rule module inside the terraform template

An example for a path patterns is

`path_pattern = ["/v1/forms*", "/v1/questionnaire*]`

This will route all requests which start with `/v1/forms` or `/v1/questionnaire` to the current service.

The Fargate service is currently configure to run with 0.25 cVPU and 512 MB of RAM. Autoscaling is enabled.
To change configurations, you can update default values for all environments in `/terraform/variables.tf`.0
To change configurations for different environments separately, override default values in `/terraform/vars/terraform-{env}.tfvars`.

## Databases

The services currently have access to a AWS DocumentDB cluster (MongoDB 3.6) and a AWS ElasticCache Cluster (Redis 6).
Both database clusters are managed via the GFW core infrastructure repository. 
For the case that is become necessary to scale out one of the clusters, please contact the GFW engineering team.

To directly connect to the databases you can create a tunnel via a bastion host using SSH.
You will need to add your public SSH key to the bastion host and add your IP address to the security group to have access.
Please provide this information to the GFW engineering team for setup.

Example:

```bash
# ADD keyfile to chain
ssh-add ~/.ssh/private_key.pem >/dev/null 2>&1

# Create a tunnel to document DB
ssh -N -L 27017:<documentdb cluster dns>:27017 ec2-user@<bastion host ip>
```
You will now be able to connect to the document db cluster via `localhost:27017`

## Git branch naming convention and CI/CD

The branches

- production
- staging
- dev

represent infrastructure deployment in the according environment accounts on AWS. 
Github actions workflows will apply infrastructure changes to these environments automatically, 
when ever a commit is pushed to one of the branches.

Pull requests against the branches will trigger a terraform plan action, and the planned infrastructure changes will be displayed first.
It is highly recommended to always work in a feature branch and to make a pull request again the `dev` branch first.

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
