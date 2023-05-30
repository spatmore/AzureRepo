targetScope = 'subscription'

param config object
param policyName string

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    metadata: {
      category: config.policy.metadata.category
    }
    displayName: 'Require a Tag on resource groups and only allow certain values'
    description: 'Enforces existence of a tag on resource groups and only allows certain values.'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions/resourceGroups'
          }
          {
            not: {
              field: 'tags[${tagName}]'
              in: '[parameters(\'listofallowedtagValues\')]'
            }
          }
        ]
      }
      then: {
        effect: effect
      }
    }
    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the audit policy'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Deny'
      }
      tagName: {
        type: 'String'
        metadata: {
          displayName: 'Tag Name'
          description: 'Name of the tag, such as \'environment\''
        }
      }
      listofallowedtagValues: {
        type: 'Array'
        metadata: {
          displayName: 'Tag Values'
          description: 'Value of the tag, such as \'production\''
        }
      }
    }
  }
}

output definitionId string = policy.id
