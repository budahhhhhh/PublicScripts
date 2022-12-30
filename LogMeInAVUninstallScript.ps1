#regex for matching the folder name
$RegMatch = '^\{\w{8}-\w{4}-\w{4}-\w{4}-\w{12}\}$'
#LMI AV Root Folder
$UninstallFolder = Get-ChildItem -Path "C:\Program Files\LogMeIn\EndpointSetupInformation" -ErrorAction SilentlyContinue
#Script Timeout
$Timeout = (Get-Date).Add((New-TimeSpan -Seconds 1800))

if ($UninstallFolder) {
    foreach ($Folder in $UninstallFolder) {

        $InstallPath = "$($Folder.FullName)\installer.exe"
        $TestPath = Test-Path -Path $InstallPath
        
        if (($Folder.Name -match $RegMatch) -and ($TestPath)) {
            Write-Host "LMI AV Uninstall started on: $(Get-Date)"
            Start-Process -FilePath "$($Folder.FullName)\installer.exe" -ArgumentList '/Uninstall'
            do {
                start-sleep -Seconds 15
                $UninstallCheck = Get-ChildItem -Path "$($Folder.FullName)" -ErrorAction SilentlyContinue
            } while ($UninstallCheck -or (Get-Date) -gt $Timeout)
            
            if (!$UninstallCheck) {
                Write-Host "LMI AV Uninstalled From path: ""$($Folder.FullName)"""
                Write-Host "Uninstall completed on: $(Get-Date)"
            }
            else {
                Write-Host "LMI AV uninstall timed out. Manual uninstall may be necessary. LMI AV Location: ""$($Folder.FullName)"""
            }
        }
    }
}
else {
    Write-Host 'LMI AV is not installed on this computer...'
}

