targetScope = 'subscription'

param actionGroup string

// https://learn.microsoft.com/en-us/azure/templates/microsoft.advisor/configurations?pivots=deployment-language-bicep
resource symbolicname 'Microsoft.Advisor/configurations@2022-10-01' = {
  name: 'digest-cw'
  properties: {
    digests: [
      {
        actionGroupResourceId: actionGroup
        frequency: 7
        name: 'digest-cw'
        state: 'Active'
      }
    ]
  }
}
