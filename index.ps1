############################################################
# (c) Daniel Petrescu
############################################################
# The software is provided "as is", without warranty of any kind, express or implied, including but
# not limited to the warranty of fitness for a particular purpose. In no event shall the authors or
# copyright holders be liable for any claim, damages or other liability, whether in an action of
# contract or otherwise, arising from, out of, or in connection with the software or the use or
# other dealings in the software.
############################################################


### Get variables
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path $scriptpath
Push-Location $scriptDir
. '.\variables.ps1'


############################################################


#region Script Init

### Copy the output to a log file
$ScriptName = ([io.fileinfo]$MyInvocation.MyCommand.Name).basename
$OutputFileLocation = "$($PSScriptRoot)\logs\$($ScriptName)_output_$($TheDateOutput).txt"
''
Start-Transcript -path $OutputFileLocation -append
''

### Print headers
$scriptLogo = @"
____ ____ _  _    ___ ____    ___  ____ _ _ _ _  _ _    ____ ____ ___     _  _ ___  ___  ____ ___ ____ ____ 
|__| [__  |_/      |  |  |    |  \ |  | | | | |\ | |    |  | |__| |  \    |  | |__] |  \ |__|  |  |___ [__  
|  | ___] | \_     |  |__|    |__/ |__| |_|_| | \| |___ |__| |  | |__/    |__| |    |__/ |  |  |  |___ ___] 
   
"@
Print-Headers "$scriptLogo"

#endregion


##############################


#region Start Script

Write-Host "`r`n===== START =====" -ForegroundColor "Black" -BackgroundColor "yellow"

### Make sure the Execution Policy is 'Unrestricted'
$currentExecutionPolicy = Get-ExecutionPolicy
$resetExecutionPolicy = 0
Write-Host "`r`n$myOSstring"
Write-Host "`r`nThe current Execution Policy is: $currentExecutionPolicy" -ForegroundColor "Gray"
if ($currentExecutionPolicy -ne "Unrestricted") {
    $resetExecutionPolicy = 1
    Write-Host 'Setting Execution Policy to: Unrestricted. This will be changed back at the end of the script.' -ForegroundColor "Gray"
    Set-ExecutionPolicy -ExecutionPolicy Unrestricted
}

#endregion


############################################################


#region Settings: Updates
Write-Host "`r`n`r`nCHANGING UPDATE SETTINGS" -ForegroundColor "Green"

If ($myOS.Caption -notlike '*Home') {    # This does not work on Home editions
'    Update & Security -> Windows Update -> Advanced options -> Choose how updates are installed: "Notify for download and notify for install"'
'        └-> Local Computer Policy -> Computer Configuration -> Administrative Templates -> Windows Components -> Windows Update -> Configure Automatic Updates'
    $AutoUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU\"

    Set-RegistryValue -Path $AutoUpdatePath `
                      -Name 'NoAutoUpdate' `
                      -Value 0 `
                      -Type 'DWord'
                      # OPTIONS:
                      # 0 - Change setting in Windows Update app (default)
                      # 1 - Never check for updates (not recommended)
    Set-RegistryValue -Path $AutoUpdatePath `
                      -Name 'AUOptions' `
                      -Value 2 `
                      -Type 'DWord'
                         # OPTIONS:
                         # 2 - Notify for download and notify for install
                         # 3 - Auto download and notify for install (default)
                         # 4 - Auto download and schedule the install
                         # 5 - Allow local admin to choose setting - does not work for stand-alone computers

    Set-RegistryValue -Path $AutoUpdatePath `
                      -Name 'ScheduledInstallDay' `
                      -Value 0 `
                      -Type 'DWord'
    Set-RegistryValue -Path $AutoUpdatePath `
                      -Name 'ScheduledInstallTime' `
                      -Value 3 `
                      -Type 'DWord'

    Set-RegistryValue -Path $AutoUpdatePath `
                      -Name 'NoAutoRebootWithLoggedOnUsers' `
                      -Value 1 `
                      -Type 'DWord'
} else {
    '    Update & Security -> Windows Update -> Advanced options -> Choose how updates are installed: "Notify to schedule restart"'
    Set-RegistryValue -Path 'HKLM:SOFTWARE\Microsoft\WindowsUpdate\UX\Settings\' `
                      -Name 'UxOption' `
                      -Value 1 `
                      -Type 'DWord'
}

#endregion


############################################################


Write-Host ""
Reset-Execution-Policy
Stop-Transcript
Pop-Location
