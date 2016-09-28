# Nclouds Terraform AWS ECS

This repo contains a [Terraform](https://www.terraform.io) plan to run up an [Amazon ECS](http://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html) cluster of node application with redis backend. The nodejs docker image used is built from [Dockerfile](https://github.com/rgupta993/nclouds-docker-compose/blob/master/docker-compose-app/nclouds-app/Dockerfile) and pushed to my own docker repo(rishabhg3) for it to be accessed by ECS.

Includes -

  * ECS cluster, launch configuration and autoscaling group
  * Task definition for deploying NodeJS app with redis as backend, API's of which can be found [here](https://github.com/rgupta993/nclouds-app#apis).

### Prerequisites

* Terraform installed, recommended (>= 0.6.3). Head on over to [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html) to grab the latest version.
* An AWS account [http://aws.amazon.com/](http://aws.amazon.com/)

### Usage

1. Clone the repo
2. Generate ssh-key and add pub key to file at path `ssh/nclouds.pub`. Commands for the same are:
```
ssh-keygen
ssh-add ~/.ssh/id_rsa
cp -rf ~/.ssh/id_rsa.pub ssh/nclouds.pub
```
Set some required variables -

```
$ export AWS_ACCESS_KEY_ID=<aws_access_key>
$ export AWS_SECRET_ACCESS_KEY=<aws_secret_key>
$ export AWS_DEFAULT_REGION=<aws_region>
```
Get terraform modules used -

```
terraform get
```

Get the final state of AWS after the deployment without actually applying it -

```
terraform plan
```

Run the plan -
```
terraform apply
```

