# azure-policydeployment

```bash
az deployment sub create --name baseline_policy_deployment --location australiaeast --template-file src/main.bicep --subscription <subscriptionId>
```

```PS
New-AzDeployment -Name PolicyDeployment -Location "Australia East" -TemplateFile ".\src\main.bicep"
```