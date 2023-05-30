targetScope = 'subscription'

param config object
param policyName string

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    metadata: {
      category: config.policy.metadata.category
    }
    displayName: 'Audit the use of AHUB'
    mode: 'All'
    description: 'Audit Windows Virtual Machine and Virtual Machine Scale sets that are not using Azure Hybrid Benefit Licencing'
    parameters: {}
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            in: [
              'Microsoft.Compute/virtualMachines'
              'Microsoft.Compute/virtualMachineScaleSets'
            ]
          }
          {
            field: 'Microsoft.Compute/licenseType'
            notEquals: 'Windows_Server'
          }
          {
            field: 'Microsoft.Compute/virtualMachines/hardwareProfile.VmSize'
            notin: [
              'Standard_B2ms'
              'Standard_B2s'
            ]
          }
        ]
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}

output definitionId string = policy.id
