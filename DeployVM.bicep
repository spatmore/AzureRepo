@description('Username for the Virtual Machine.')
param adminUsername string

@description('Password for the Virtual Machine.')
@secure()
param adminPassword string

@description('The name of the resource in Azure. Should be in the format vm-cust-workload')
param vmName string
 
@allowed([       
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
])
param vmSize string = 'standard_d2s_v5'

@description('Name of the virtual machine within Windows')
param osName string

@description('The Windows version for the VM. This will pick a fully patched image of this given Windows version.')
@allowed([
  '2016-datacenter'
  '2019-datacenter'
  '2022-datacenter'
])
param OSVersion string = '2022-datacenter'

param vnetName string

param snetName string

resource nic 'Microsoft.Network/networkInterfaces@2022-09-01' = {
  name: '${vmName}-nic'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, snetName)
          }
        }
      }
    ]
  }
}


resource windowsVM 'Microsoft.Compute/virtualMachines@2022-11-01' = {
  name: vmName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: osName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: OSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk:{
          storageAccountType: 'Premium_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
