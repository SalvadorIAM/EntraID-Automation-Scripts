# EntraID Automation Scripts

PowerShell automation scripts for auditing Microsoft Entra ID using Microsoft Graph and Azure CLI authentication.

These scripts are designed to support identity governance and administrative auditing tasks in Microsoft Entra environments.

## Script: Entra ID Missing Department Audit

### Overview

This script identifies enabled Microsoft Entra ID users who do not have the **Department** attribute populated.
Missing department values can create issues for identity governance, access policies, and organisational reporting.

The script authenticates using Azure CLI, queries Microsoft Graph, filters enabled users with empty department attributes, and exports the results to a CSV report.

## What the Script Does

1. Authenticates to Microsoft Graph using an Azure CLI access token
2. Queries Microsoft Entra ID users via Microsoft Graph API
3. Filters users where:

   * `accountEnabled = true`
   * `department` attribute is empty or null
4. Exports the results to a CSV report

Output file:

Reports/users-missing-department.csv

## Prerequisites

Before running the script ensure the following are installed and configured.

### Azure CLI

Install Azure CLI:

https://learn.microsoft.com/cli/azure/install-azure-cli

### Login to Microsoft Entra Tenant

Run:

az login --tenant <TENANT_ID> --allow-no-subscriptions --use-device-code

### Required Permission

The account running the script must have delegated Microsoft Graph permission:

User.Read.All

## How to Run the Script

1. Open PowerShell
2. Navigate to the Scripts directory

Example:

cd Scripts

3. Run the script

.\users-missing-department.ps1

## Output

The script generates a CSV report containing:

* Display Name
* User Principal Name
* Department

File location:

Reports/users-missing-department.csv

## Use Case

This script can help identity administrators identify missing directory attributes that may affect:

* Access policies
* Dynamic group membership
* Identity governance processes
* HR data synchronization

## Future Improvements

* Add pagination support for tenants with more than 999 users
* Add additional attribute audits (Job Title, Manager, Office Location)
* Export results to additional formats
* Integrate with automated reporting workflows
