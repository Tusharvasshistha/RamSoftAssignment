function Update-VMState{
 param(
        [string]$SubscriptionID,

        [string]$VMName,

        [string]$VMResourceGroupName

    )



begin {
    Write-Output "VM RG received is $VMResourceGroupName"
    Write-Output "VM Name received is $VMName"
}

process
{

try{
##az login  - will be executed via command line or spn can also be used - here mentioning just to make flow more logical
#az login

##select subscription
az account set --subscription $SubscriptionID

##Restart the VM
az vm restart --resource-group $VMResourceGroupName --name $VMName

}
Catch{
 Write-Output "Error while restaring the VM: $VMName, $_. "
}

}

end {
Write-Output "VM has been started"
#Addiontionally we can check state of VM just to make a validation
}

}


##RUn function
Update-VMState -SubscriptionID "abcd-efgh-ijkl" -VMName "myvm" -VMResourceGroupName "myrg"