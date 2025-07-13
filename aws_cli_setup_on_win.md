# AWS CLI (on Windows)
How to setup the AWS CLI on Windows

## Setup
* Download and Install the [AWS CLI MSI Installer](https://awscli.amazonaws.com/AWSCLIV2.msi)
* Confirm installation:
    ```powershell
    aws --version
    ```
* (optional) Enable auto-prompt
    ```powershell
    $Env:AWS_CLI_AUTO_PROMPT="on-partial"
    ```
*  Set AWS Credentials as environment variables
    ```powershell
    $Env:AWS_ACCESS_KEY_ID="EXAMPLE"
    $Env:AWS_SECRET_ACCESS_KEY="EXAMPLE"
    $Env:AWS_DEFAULT_REGION="ap-south-1"
    ```
* Precedence of AWS Credentials
    - Environment Variables
    - Named profile via CLI flag --profile
    - AWS Credentials/Config files (set by aws configure)