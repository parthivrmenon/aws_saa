# Setting up the AWS CLI
## Install the AWS CLI on Linux/Mac
```bash
# install AWS CLI from source
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# (optional) Remove the installed zip file
rm awscliv2.zip
```

Confirm installation:
```bash
aws --version
```

## Install the AWS CLI on Windows
Download and Install the [AWS CLI MSI Installer](https://awscli.amazonaws.com/AWSCLIV2.msi)

Confirm installation:
```powershell
aws --version
```

## Configure auto-prompt
### Linux/Mac
```bash
export AWS_CLI_AUTO_PROMPT="on-partial"
```

### Windows
```powershell
$Env:AWS_CLI_AUTO_PROMPT="on-partial"
```

## Setup AWS Credentials
### Linux/Mac
```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="us-east-1"
```

### Windows
```powershell
$Env:AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY_ID"
$Env:AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
$Env:AWS_DEFAULT_REGION="us-east-1"
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



