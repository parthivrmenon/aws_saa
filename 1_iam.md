# IAM : Identity and Access Management
Global service to manage AWS accounts and access

* root acoount created by default, should not be used or shared
* Users are people within your ogranization and can be grouped
* user can belong to multiple groups, or no group at all 
* inline policy
* users/groups can be assigned JSON policies to define user permissions
* apply least-privilege principle


## IAM Policy inheritance
* group policies are inherited 
* users can also have inline policy
* most restrictive effective permission wins
* Structure
    * Version: policy language version, always include "2012-10-17" (required)
    * Id: identifier of the policy (optional)
    * Statements[]: one or more individual policy statements (required)
        * Sid: identifier for the Statement (optional)
        * Effect: Allow/Deny (required)
        * Principal: account/user/role to which to apply the policy to
        * Action[]: list of actions this policy allows or denies (required)
        * Resource: list of resources to which the actions applied to (optional)

## Password Policy
* min password length
* require specific character types (uppercase, numbers, non-apjhanum)
* Allo IAM users t o change their own password
* change after expiration
* prevent password re-use

## MFA
* recommended to use MFA for root account and IAM users
* Google Authenticatior, Authy, 

## Access Types
- Management Console : passwords + MFA
- CLI: protected via access keys
- SDK- for code;protected by access keys

## IAM Role
enable services to perform actions on your behalf
Common Roles
* EC2 Instance Roles
* Lamda Function Roles
* ROles for CloudFormation

## IAM Security Tools
### IAM Credentials Report (account-level)
report lists all your IAM users in this account and the status of their various credentials. After a report is created, it is stored for up to four hours.

### IAM Access Advisor (user-level)
shows service permissions granted to a user and when these services were last accesed. This allows you to tailor access permissions based on access paterns.

## IAM Guidelines & Best-practices
* Don't use root account for anything other than initial AWS account setup
*

