targetScope = 'subscription'

var config = loadJsonContent('main.json')

var assignmentlocation = 'australiaeast'

module policySet_baseline 'initiatives/baseline.bicep' = {
  name: 'DITPolicyInitiative'
  params: {
    config: config
    initiativeName: 'DITPolicyInitiative'
  }
}

resource assignment_baseline 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
 name: 'DITPolicyInitiativeAssignment'
 location: assignmentlocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    policyDefinitionId: policySet_baseline.outputs.definitionId
    enforcementMode: 'DoNotEnforce'
    parameters: {}
  }
}
