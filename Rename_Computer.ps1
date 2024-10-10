#Get the current computer name
$CurrentDeviceHostname = $env:COMPUTERNAME

#Prompt the user to enter the 4 character code
$CharCode = Read-Host -Prompt "`nEnter the 4 character code"

#Validate the input
If ($CharCode.Length -ne 4) {
    Write-Host "`nInvalid input. The code should be exactly 4 characters long." -ForegroundColor DarkRed
    Exit
}

#Generate the new hostname
$NewDeviceHostname = $CharCode + $CurrentDeviceHostname.Substring(4)

#Rename the computer
Rename-Computer -NewName $NewDeviceHostname -Force

#Create Function
Function TimeToRestart() {
    Write-Host "`nDevice will restart in 5 seconds." -ForegroundColor DarkGreen
    Start-Sleep -Seconds 5
    Restart-Computer -Force
}

#Prompt for a restart
$DeviceRestart = Read-Host -Prompt "`nDevice renamed successfully. Do you want to restart now? (Y/N)"

Switch ($DeviceRestart) {
    Y {TimeToRestart}
    N {Write-Host "`nPlease restart your device for the name change to propagate`n." -ForegroundColor DarkCyan}

    Default {Write-Host "`nPlease enter a valid response" -ForegroundColor DarkRed}
}
