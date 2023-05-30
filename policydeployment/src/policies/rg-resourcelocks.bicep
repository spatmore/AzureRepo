targetScope = 'subscription'

param config object
param policyName string

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  