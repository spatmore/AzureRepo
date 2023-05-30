targetScope = 'subscription'

param config object
param initiativeName string

module policy1 '../policies/rsv-auditimmutability.bicep' = {
  name: 'policy_rsv-auditimmutability_deployment'
  params: {
    config: config
    policyName: 'AuditImmunRSV'
  }
}

module policy2 '../policies/vm-audituseofahub.bicep' = {
  name: 'policy_vm-audituseofahub_deployment'
  params: {
    config: config
    policyName: 'AuditUseOfAHUB'
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
    parameters: {}
    policyDefinitions: [
  {
    policyDefinitionReferenceId: 'Accounts with read permissions on Azure resources should be MFA enabled_1'
    policyDefinitionId: '81b3ccb4-e6e8-4e4a-8d05-5df25cd29fd4'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Accounts with write permissions on Azure resources should be MFA enabled_1'
    policyDefinitionId: '931e118d-50a1-4457-a5e4-78550e086c52'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Accounts with owner permissions on Azure resources should be MFA enabled_1'
    policyDefinitionId: 'e3e008c3-56b9-4133-8fd7-d3347377402a'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Azure Backup should be enabled for Virtual Machines_1'
    policyDefinitionId: '013e242c-8828-4970-87b3-ab247555486d'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: '[Preview]: Immutability must be enabled for backup vaults_1'
    policyDefinitionId: '2514263b-bc0d-4b06-ac3e-f262c0979018'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: '[Preview]: Soft delete should be enabled for Backup Vaults_1'
    policyDefinitionId: '9798d31d-6028-4dee-8643-46102185c016'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Key vaults should have soft delete enabled_1'
    policyDefinitionId: '1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Audit VMs that do not use managed disks_1'
    policyDefinitionId: '06a78e20-9358-41c9-923c-fb736d382a4d'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Storage accounts should restrict network access_1'
    policyDefinitionId: '34c877ad-507e-4c82-993e-3452a6e0ad3c'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: '[Preview]: Storage account public access should be disallowed_1'
    policyDefinitionId: '4fa4b6c0-31ca-4c0d-b10d-24b96f62a751'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Storage accounts should be limited by allowed SKUs_1'
    policyDefinitionId: '7433c107-6db4-4ad1-b57a-a76dce0154a1'
    parameters: {
      listOfAllowedSKUs: {
        value: [
          'standard_grs'
          'standard_lrs'
          'standard_zrs'
        ]
      }
    }
  }
  {
    policyDefinitionReferenceId: 'Allowed virtual machine size SKUs_1'
    policyDefinitionId: 'cccc23c7-8427-4f53-ad12-b6a63eb452b3'
    parameters: {
      listOfAllowedSKUs: {
        value: [
          'standard_b2ms'
          'standard_b4ms'
          'standard_b2s'
          'standard_d2s_v5'
          'standard_d2ds_v5'
          'standard_d4ds_v5'
          'standard_d4s_v5'
          'standard_d8ds_v5'
          'standard_d8s_v5'
          'standard_d16s_v5'
          'standard_d16ds_v5'
          'standard_e2ds_v5'
          'standard_e2s_v5'
          'standard_e4ds_v5'
          'standard_e4s_v5'
          'standard_e8ds_v5'
          'standard_e8s_v5'
        ]
      }
    }
  }
  {
    policyDefinitionReferenceId: 'A maximum of 3 owners should be designated for your subscription_1'
    policyDefinitionId: '4f11b553-d42e-4e3a-89be-32ca364cad4c'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'There should be more than one owner assigned to your subscription_1'
    policyDefinitionId: '09024ccc-0c5f-475e-9457-b7c0d9ed487b'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Blocked accounts with owner permissions on Azure resources should be removed_1'
    policyDefinitionId: '0cfea604-3201-4e14-88fc-fae4c427a6c5'
    parameters: {}
  }
  {
    policyDefinitionReferenceId: 'Allowed locations for resource groups_1'
    policyDefinitionId: 'e765b5de-1225-4ba3-bd56-1ac6695af988'
    parameters: {
      listOfAllowedLocations: {
        value: [
          'australiaeast'
        ]
      }
    }
  }
  {
    policyDefinitionReferenceId: 'Allowed locations_1'
    policyDefinitionId: 'e56962a6-4747-49cd-b67b-bf8b01975c4c'
    parameters: {
      listOfAllowedLocations: {
        value: [
          'australiaeast'
        ]
      }
    }
  }
  {
    policyDefinitionReferenceId: 'Require a tag on resources_1'
    policyDefinitionId: '871b6d14-10aa-478d-b590-94f262ecfa99'
    parameters: {
      tagName: {
        value: 'workload'
      }
    }
  }
  {
    policyDefinitionReferenceId: 'Require a tag on resource groups_1'
    policyDefinitionId: '96670d01-0a4d-4649-9c89-2d3abc0a5025'
    parameters: {
      tagName: {
        value: 'workload'
      }
    }
  }
  {
    policyDefinitionReferenceId: 'Inherit a tag from the resource group if missing_1'
    policyDefinitionId: 'ea3f2387-9b95-492a-a190-fcdc54f7b070'
    parameters: {
      tagName: {
        value: 'workload'
      }
    }
  }
  {
    policyDefinitionReferenceId: 'Enable Microsoft Defender for Cloud on your subscription_1'
    policyDefinitionId: 'ac076320-ddcf-4066-b451-6154267e8ad2'
    parameters: {}
    groupNames: []
  }
  {
    policyDefinitionReferenceId: 'Configure Microsoft Defender CSPM to be enabled_1'
    policyDefinitionId: '689f7782-ef2c-4270-a6d0-7664869076bd'
    parameters: {}
    groupNames: []
  }
  {
    policyDefinitionId: policy1.outputs.definitionId
    parameters: {}
  }
  {
    policyDefinitionId: policy2.outputs.definitionId
    parameters: {}
  }
]
  }
}

output definitionId string = policySet.id
