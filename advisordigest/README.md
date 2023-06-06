# advisordigest

```bash
az deployment sub create --name advisor_digest_deployment --location australiaeast --template-file src/main.bicep --subscription <subscriptionId>
```

```PS
New-AzDeployment -Name AdvisorDigestDeployment -Location "Australia East" -TemplateFile ".\src\main.bicep" -digestName digest-<cust>
```