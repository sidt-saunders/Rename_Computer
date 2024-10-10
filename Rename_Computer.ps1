#----------
#Variables
#----------

$FailCounter = 0

#----------
#Functions
#----------

Function NotValidCharlength() {
    While ($FailCounter -ne 2) {
        Write-Host ""
        Write-Warning "Code should be exactly 4 characters long. "
        $FailCounter++
        CharCodePrompt
    }
    Write-Host ""
    Write-Error "Too many failed attempts. Script will exit in 5 seconds."
    Start-Sleep -Seconds 5
    $FailCounter = 0
    Exit
}

Function NotValidCharType() {
    While ($FailCounter -ne 2) {
        Write-Host ""
        Write-Warning "Code should be characters only. "
        $FailCounter++
        CharCodePrompt
    }
    Write-Host ""
    Write-Error "Too many failed attempts. Script will exit in 5 seconds."
    Start-Sleep -Seconds 5
    $FailCounter = 0
    Exit
}

Function CharCodePrompt() {
    $CharCode = Read-Host -Prompt "Enter the 4 character code (USAL, USHO, USGR, etc.)"
    #Validate input
    If ($CharCode.Length -ne 4) {NotValidCharlength}
    If ($CharCode -notmatch "[a-zA-Z]") {NotValidCharType}
    Else {GenerateAndRename}
}

Function GenerateAndRename() {
    #Generate new hostname
    $NewDeviceHostname = $CharCode.ToUpper() + $CurrentDeviceHostname.Substring(4)
    #Rename device
    Rename-Computer -NewName $NewDeviceHostname -Force
    PromptToRestart
}

Function PromptToRestart() {
    $DeviceRestart = Read-Host -Prompt "`nDevice renamed successfully. Do you want to restart now? (Y/N) "

    Switch ($DeviceRestart) {
        Y {TimeToRestart}
        N {
            Write-Host "`nPlease restart as soon as possible for the name change to propagate.`nScript will exit in 5 seconds.`n"
            Start-Sleep -Seconds 5
            Exit
        }

        Default {NotValidRestart}
    }
}

Function TimeToRestart() {
    Write-Host "`nDevice will restart in 5 seconds." -ForegroundColor DarkGreen
    Start-Sleep -Seconds 5
    Restart-Computer -Force
}

Function NotValidRestart() {
    While ($FailCounter -ne 2) {
        Write-Host ""
        Write-Warning "Please enter a valid response. "
        $FailCounter++
        PromptToRestart
    }
    Write-Host ""
    Write-Error "Too many failed attempts. Script will exit in 5 seconds."
    Start-Sleep -Seconds 5
    $FailCounter = 0
    Exit
}

#----------
#Script
#----------

#Get the current computer name
$CurrentDeviceHostname = $Env:COMPUTERNAME

Write-Host "`nThis script will allow you to update the 4 letter character in the hostname.`n" -BackgroundColor Black -ForegroundColor White
Write-Host "NOTE: Device needs to restart for changes to take effect.`nPress CTRL +C at any time to interrupt the script.`n`n------------------------------`n`n"

CharCodePrompt