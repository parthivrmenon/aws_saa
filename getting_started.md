# Getting started
## Install the AWS CLI
```bash
# install AWS CLI from source
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# (optional) Remove the installed zip file
rm awscliv2.zip
```

## Configure auto-prompt
```bash
export AWS_CLI_AUTO_PROMPT="on-partial"
```


## Setup AWS Credentials
```bash
export AWS_ACCESS_KEY_ID="EXAMPLE"
export AWS_SECRET_ACCESS_KEY="EXAMPLE"
export AWS_DEFAULT_REGION="us-east-1"
```
```powershell
$Env:AWS_ACCESS_KEY_ID="EXAMPLE"
$Env:AWS_SECRET_ACCESS_KEY="EXAMPLE"
$Env:AWS_DEFAULT_REGION="us-east-1"
```

## Turn on Auto-Complete
```bash
export AWS_CLI_AUTO_PROMPT="on-partial"
```

## Verify everything has been setup correctly
```bash
aws sts get-caller-identity
{
    "UserId": "Example",
    "Account": "4XXXXXX",
    "Arn": "arn:aws:iam::4XXXXX:user/youruser"
}
```

## Run bootstrap
```powershell
cd .\bootstrap\
terraform init
terraform plan
terraform apply
```

## Cleanup
```powershell
cd .\bootstrap\
terraform init
terraform plan
terraform destroy
```

