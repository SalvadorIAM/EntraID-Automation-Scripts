<# 
.SYNOPSIS
Exports enabled Microsoft Entra ID users missing the Department attribute to a CSV report.

.DESCRIPTION
Uses Azure CLI to obtain a Microsoft Graph token, then queries /users and filters enabled users
where Department is null/empty. Exports results to Reports\users-missing-department.csv.

PREREQUISITES
- Azure CLI installed
- Logged in with: az login --tenant <TENANT_ID> --allow-no-subscriptions --use-device-code
- Microsoft Graph permission: User.Read.All (delegated)
#>

$TenantId = "15317c95-ea49-4a72-91f5-18ea3b564912"

$token = (az account get-access-token --tenant $TenantId --resource-type ms-graph --query accessToken -o tsv)

if ([string]::IsNullOrWhiteSpace($token)) {
    throw "Failed to obtain Microsoft Graph token. Run: az login --tenant $TenantId --allow-no-subscriptions --use-device-code"
}

$headers = @{ Authorization = "Bearer $token" }

$uri = "https://graph.microsoft.com/v1.0/users?`$select=displayName,userPrincipalName,department,accountEnabled&`$top=999"
$users = Invoke-RestMethod -Headers $headers -Uri $uri -Method Get

$missing = $users.value | Where-Object { $_.accountEnabled -eq $true -and [string]::IsNullOrWhiteSpace($_.department) }

$reportPath = ".\Reports\users-missing-department.csv"

$missing | Select-Object displayName,userPrincipalName,department | Export-Csv $reportPath -NoTypeInformation

Write-Host "Users missing Department (enabled only): $($missing.Count)"
Write-Host "Report saved to: $reportPath"
