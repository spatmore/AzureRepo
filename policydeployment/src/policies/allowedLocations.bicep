targetScope = 'subscription'

param config object
param policyName string

// https://learn.microsoft.com/en-us/azure/templates/microsoft.authorization/policydefinitions?pivots=deployment-language-bicep
resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    metadata: {
      category: config.policy.metadata.category
    }
    displayName: policyName
    mode: 'All'
    parameters: {
      allowedLocations: {
        type: 'Array'
        metadata: {
          displayName: 'Allowed locations'
          description: 'The list of allowed locations for resources.'
          strongType: 'location'
        }
      }
    }
    policyRule: {
      if: {
        not: {
          field: 'location'
          in: '[parameters(\'allowedLocations\')]'
        }
      }
      then: {
        effect: 'audit'
      }
    }
  }
}

output definitionId string = policy.id
