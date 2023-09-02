#OBSOLETO---------------------------
# Obtenha informações sobre o grupo de recursos que deseja usar
$rg = Get-AzResourceGroup -Name "dev-geral"

# Obtenha informações sobre a rede virtual que deseja usar
$vnet = Get-AzVirtualNetwork -ResourceGroupName $rg.ResourceGroupName -Name "vscodenet1"

$subnet = Get-AzVirtualNetworkSubnetConfig -Name "subvscode" -VirtualNetwork $vnet

# Crie um endereço IPv6 público
$PublicIP_v6 = New-AzPublicIpAddress `
    -Name "PublicIP_v6" `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -Sku Standard `
    -AllocationMethod Static `
    -IpAddressVersion IPv6
    -Subnet $subnet

# Crie uma NIC com o endereço IPv6 público
$nic = New-AzNetworkInterface `
    -Name "NIC_v6" `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location $rg.Location `
    -IpConfigurationName "IpConfig_v6" `
    -PublicIpAddress $PublicIP_v6

# Obtenha informações sobre a máquina virtual que deseja usar
$vm = Get-AzVM -ResourceGroupName $rg.ResourceGroupName -Name "vscode"

# Anexe a NIC à máquina virtual
Add-AzVMNetworkInterface -VM $vm -Id $nic.Id

# Atualize a máquina virtual para aplicar as alterações
Update-AzVM -ResourceGroupName $rg.ResourceGroupName -VM $vm
