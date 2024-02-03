#Requires -RunAsAdministrator

Write-Host "|) [- /= [- |\| |) [- /?   ]3 |_ [- |\| |) [- /?" -ForegroundColor Red
Write-Host "|) [- /= [- |\| |) [- /?   ]3 |_ [- |\| |) [- /?" -ForegroundColor Green
Write-Host "|) [- /= [- |\| |) [- /?   ]3 |_ [- |\| |) [- /?" -ForegroundColor Yellow
Write-Host "|) [- /= [- |\| |) [- /?   ]3 |_ [- |\| |) [- /?" -ForegroundColor Blue
Write-Host "|) [- /= [- |\| |) [- /?   ]3 |_ [- |\| |) [- /?" -ForegroundColor Magenta
Write-Host "|) [- /= [- |\| |) [- /?   ]3 |_ [- |\| |) [- /?" -ForegroundColor Cyan
Write-Host "|) [- /= [- |\| |) [- /?   ]3 |_ [- |\| |) [- /?" -ForegroundColor White


if ($PSVersionTable.PSVersion.Major -lt 4) {
    Write-Host "You are PowerShell with $PSVersionTable.PSVersion.Major - that is probably not a good idea"
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "Running as Administrator"
    } else {
        Write-Host "Not running as Administrator $PSVersionTable.PSVersion.Major - please try harder to escalate please"
        exit
    }
    
}

$userInput = Read-Host -Prompt 'Enter enable or disable'
if ($userInput -eq "enable") {
    $defendBool = $true
} elseif ($userInput -eq "disable") {
    $defendBool = $false
} else {
    Write-Host "Invalid input. Please enter either 'enable' or 'disable'."
    exit
}

if ($defendBool) {
    Write-Host "Windows Defender being is fully enabled."
    Set-MpPreference -DisableRealtimeMonitoring $false
    Set-MpPreference -DisableBehaviorMonitoring $false
    Set-MpPreference -DisableScriptScanning $false
    Set-MpPreference -DisableEmailScanning $false
    Set-MpPreference -MAPSReporting Advanced
    Set-MpPreference -SubmitSamplesConsent AlwaysPrompt
} else {
    Write-Host "Windows Defender being is fully disabled"
    Set-MpPreference -DisableRealtimeMonitoring $true
    Set-MpPreference -DisableBehaviorMonitoring $true
    Set-MpPreference -DisableScriptScanning $true
    Set-MpPreference -DisableEmailScanning $true
    Set-MpPreference -MAPSReporting Disabled
    Set-MpPreference -SubmitSamplesConsent NeverSend
}
Get-MpPreference 
exit
