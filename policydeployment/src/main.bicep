targetScope = 'subscription'

var config = loadJsonContent('main.json') 

module policySet_baseline 'initiatives/baseline.bicep' = {
  name: 'moduleName'
  params: {
    config: config
    initiativeName: 'policySet'
  }
}

resource assignment_baseline 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'australiaBaseline'
  properties: {
    policyDefinitionId: policySet_baseline.outputs.definitionId
    enforcementMode: 'DoNotEnforce'
    parameters: {
      allowedLocations: {
        value: [
          'australiaeast'
          'australiasoutheast'
        ]
      }
    }
  }
}
 