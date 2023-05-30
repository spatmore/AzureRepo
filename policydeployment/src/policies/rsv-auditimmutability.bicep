targetScope = 'subscription'

param config object
param policyName string

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    metadata: {
      category: config.policy.metadata.category
    }
    displayName: 'Immutability must be enabled for Recovery Services Vaults'
    mode: 'All'
    description: 'Audit Recovery Services Vaults to check if Immutability is enabled'
    parameters: {}
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            in: [
              'Microsoft.RecoveryServices/vaults'
            ]
          }
          {
            field: 'Microsoft.RecoveryServices/vaults/securitySettings.immutabilitySettings.state'
            notEquals: 'Locked'
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
