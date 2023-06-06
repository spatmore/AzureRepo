targetScope = 'subscription'

module advisordigest 'configurations/advisordigest.bicep' = {
  name: 'digest-'
  params: {
    digestName: 'digest-'
    actionGroup: '/subscriptions/9B8F23EA-3440-4464-9EF4-BF8AECF53C2E/resourceGroups/rg-dcloud-shared/providers/microsoft.insights/actionGroups/ag-dcloud-email'
  }
}
