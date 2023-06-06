targetScope = 'subscription'

param digestName string
param actionGroup string

// https://learn.microsoft.com/en-us/azure/templates/microsoft.advisor/configurations?pivots=deployment-language-bicep
resource symbolicname 'Microsoft.Advisor/configurations@2022-10-01' = {
  name: digestName
  properties: {
    digests: [
      {
        actionGroupResourceId: actionGroup
        frequency: 7
        name: digestName
        state: 'Active'
      }
    ]
  }
}
