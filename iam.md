# IAM : Identity and Access Management
Global service to manage AWS accounts and access

## Users and Groups
* Root acoount created by default, should not be used or shared
* Users are people within your ogranization and can be grouped into Groups
* A User can belong to multiple Groups, or no Group at all
* A Group can only contain Users, not other Groups 

## IAM Permissions
* IAM Permissions are JSON documents that define what Users and Groups can do/not do
* Least Privilege Principle is recommended

## IAM Policy 
IAM Policy inheritance
* group policies are inherited by all Users within the Group
* A User can also have inline policy 
* Always , most "restrictive" effective permission wins
* Structure
    * Version: policy language version, always include "2012-10-17" (required)
    * Id: identifier of the policy (optional)
    * Statements[]: one or more individual policy statements (required)
        * Sid: identifier for the Statement (optional)
        * Effect: Allow/Deny (required)
        * Principal: account/user/role to which to apply the policy to
        * Action[]: list of actions this policy allows or denies (required)
        * Resource: list of resources to which the actions applied to (optional)

## IAM - Protecting Users and Groups
### Password Policy
* minimum password length
* require specific character types (uppercase, numbers, non-apjhanum)
* Allow/Deny IAM users to change their own password
* Require User to change password after expiration
* Prevent password re-use

## Multi Factor Authentication - MFA
* MFA - A password you know + a security device you have
* recommended to use MFA for root account and IAM users
* Virtual MFA Devices - Google Authenticatior, Authy
* U2F Security Key - Yubikey
* Hardware Key Fob - Gemalto or SurePassID

## IAM Roles for Services
* enable AWS Services to perform actions on your behalf
* Common Roles:
    * EC2 Instance Roles
    * Lamda Function Roles
    * Roles for CloudFormation

## Access Types Summary
- Management Console : passwords + MFA
- CLI: protected via access keys
- SDK- for code;protected by access keys

## IAM Security Tools
### IAM Credentials Report (account-level)
* lists all your IAM users in this account and the status of their various credentials. 
* stored for up to four hours.

### IAM Access Advisor (user-level)
* shows service permissions granted to a user and when these services were last accesed. 
* This allows you to tailor access permissions based on access paterns.

## IAM Guidelines & Best-practices
* Don't use root account for anything other than initial AWS account setup
*








