# secrets_management

A Centralized and Dynamic secrets management system that seeks to replace the manual process of creating and managing sensitive credentials by developers on their local computers, also to avoid the common issue of committing hard-coded credentials to public spaces which can have a tremendous impact on the security of the organization. AWS secrets engine and identity authentication to provide role-based access with granular permission to generate new resource on the cloud to developers in an organization.

## Getting Started

There are 2 different personnel involved in this guide, the "Administrator" and the "Developer".

**Administrator**

The "Administrator" is the operator responsible for launching, configuring, and managing Vault using Terraform and CLI. They configure [AWS Secrets Engine](https://www.vaultproject.io/docs/secrets/aws/index.html) in Vault and defining the policy scope for the AWS credentials dynamically generated. They generate new user in system with their varying capacity of usage.

The "Administrator" is generally concerned about managing the static and long lived AWS IAM credentials with varying scope required for developers, database clients and other applications to safely interact with AWS.

Things to follow as administrator:

- Vault_cluster folder - for deployment of cluster and managing it. (Follow Readme under the folder)
- admin_workspace - for managing the admin workspace. (Follow Readme under the folder)

## Built With

- Terraform - Used to provision the infrastructure
- Vault - Secrets & identity management

## Author

Managed by [Estelle Bikibili](https://github.com/estellabella)
