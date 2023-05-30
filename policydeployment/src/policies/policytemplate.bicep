targetScope = 'subscription'

param config object
param policyName string

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    metadata: {
      category: config.policy.metadata.category
    }
    displayName: ''
    mode: 'All'
    description: ''
    parameters: {}
    policyRule: {}
  }
}

output definitionId string = policy.id
