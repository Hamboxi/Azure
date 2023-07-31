param([string]$resourceGroup)

$adminCred = Get-Credential -Message "Entre com um usuário e senha para o Admin da VM"

For ($i = 1; $i -le 3; $i++)
{
    $vmName = "ConferenceDemo" + $i
    Write-Host "Creating VM: " $vmName
    New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCred -image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest
}