targetScope = 'subscription'

param config object
param initiativeName string

module policy1 '../policies/allowedLocations.bicep' = {
  name: 'policy1_mod_deployment'
  params: {
    config: config
    policyName: 'customPolicy1'
  }
}

module policy2 '../policies/allowedLocations.bicep' = {
  name: 'policy2_mod_deployment'
  params: {
    config: config
    policyName: 'customPolicy2'
  }
}

// https://learn.microsoft.com/en-us/azure/templates/microsoft.authorization/policysetdefinitions?pivots=deployment-language-bicep
resource policySet 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: initiativeName
  properties: {
    metadata: {
      category: config.policy.metadata.category
    }
    displayName: initiativeName
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
    policyDefinitions: [
      {
        policyDefinitionId: policy1.outputs.definitionId
        parameters: {
          allowedLocations: {
            value: '[parameters(\'allowedLocations\')]'
          }
        }
      }
      {
        policyDefinitionId: policy2.outputs.definitionId
        parameters: {
          allowedLocations: {
            value: '[parameters(\'allowedLocations\')]'
          }
        }
      }
    ]
  }
}

output definitionId string = policySet.id
