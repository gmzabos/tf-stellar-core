# tf-stellar-core

### What is this repository for? ###
* Install Stellar Core infrastructure using terraform

## Terraform version
* Terraform version: 0.14.7
* Check [terraform installation documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Setting up AWS credentials
* This setup relies on the AWS credentials being available as a separate, non-default profile, which can be created in the AWS cli via `aws configure --profile tf-stellar-core`
* To install the AWS cli, please refer to the [official documentation](https://aws.amazon.com/cli/)

### Layout
* Folder structure:

- `main`: the main deployment scripts
    - `bootstrap`: the bootstrapping scripts to create .tfstate and lock file on an AWS S3 bucket & in a AWS DynamoDB table
- `modules/bootstrap`: the bootstrapping module

### Bootstrapping the terraform backend on AWS S3
* Bootstrapping only needs to be done once and should never be done during normal operations
* Before Terraform can keep the infrastructure state in a remote backend, a few things will need to be created manually. That's what the script in the `bootstrap` folder is for. They create an S3 bucket and a DynamoDB table to use for terraform
* Using one state file per environment in a common S3 bucket so that errors are isolated, e.g. a terraform failure in develop won't kill the production environment with it.

```bash
$ cd main/bootstrap
$ terraform init
$ terraform plan -out=terraform.bootstrap.plan
$ terraform apply terraform.bootstrap.plan
```

### Build the main infrastructure
* As soon as the intial bootstrapping of the terraform S3 backend has been configured, the main initial build of the infrastructure can be done.

```bash
$ cd main
$ terraform init
$ terraform validate 	# check for errors
$ terraform plan 		# plan for initial infrastructure deplyoment
$ terraform apply		# commit initial deployment
```

### Modify the main infrastructure
* As you modify the infrastructure via the code based in the git repository, you need to modify the deployment of the main infrastructure from time to time.

```bash
$ cd main
$ terraform validate    # Check for errors
$ terraform plan        # plan for infrastructure modifications
$ terraform apply       # commit modifications
```