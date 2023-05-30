targetScope = 'subscription'

var config = loadJsonContent('main.json')

module policySet_baseline 'initiatives/baseline.bicep' = {
  name: 'DITPolicyInitiative'
  params: {
    config: config
    initiativeName: 'DITPolicyInitiative'
  }
}

resource assignment_baseline 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: 'DITPolicyInitiativeAssignment'
  properties: {
    policyDefinitionId: policySet_baseline.outputs.definitionId
    enforcementMode: 'DoNotEnforce'
    parameters: {}
  }
}
