<#
Disclaimer

This example code is provided without copyright and “AS IS”.  It is free for you to use and modify.
Note: These demos should not be run as a script. These are the commands that I use in the 
demonstrations and would need to be modified for your environment.

#>
Break # To prevent accidental execution as a script - Do not remove

#Turn on detail logging
# 1.	Navigate to "Computer Configuration\Policies\Administrative Templates\Windows Components\Windows PowerShell"
# 1.	Double Click on "Turn on Module Logging"
# 2.	Click "Enabled"
# 3.	In the Options section, click on "Show" next to Module Names
# 4.	Type "*" in the pop up window. This means PowerShell will log commands from all modules.



######

Enter-PSSession -ComputerName Client -ConfigurationName PrintOperators -Credential Company\JimJea
Get-Command
Ipconfig
Restart-service bits
Exit-PSSession


#Windows Remote Management Operational Log..

Get-Winevent -ListLog *winrm*


Enter-PSSession -ComputerName Client -ConfigurationName PrintOperators -Credential Company\JimJea
Restart-Service -name bits
Exit-PsSession

Get-Winevent -ListLog *winrm*

Get-Winevent -LogName Microsoft-Windows-WinRM/Operational | Select-Object -First 20 

$Events=Get-Winevent -LogName Microsoft-Windows-WinRM/Operational | 
    Where-Object {$_.ID -eq 193} | Select-Object -first 10 



$events2=Get-Winevent -LogName Microsoft-Windows-PowerShell/Operational | Where-Object {$_.UserID -eq 'S-1-5-94-1468353315' }


############################################################

# Over-the-Shoulder 

Get-PSSessionConfiguration -name PrintOperators
Unregister-PSSessionConfiguration -Name PrintOperators
Restart-Service -name winrm


# Add transcript setting
$JEAConfigParams = @{
    SessionType = 'RestrictedRemoteServer'
    RunAsVirtualAccount = $true
    RoleDefinitions = @{'Company\JEA Print Operators' = @{ RoleCapabilities = 'PrintOperator' }}
    TranscriptDirectory = "$env:ProgramData\JEAConfiguration\Transcripts"
}

New-PSSessionConfigurationFile -Path "$env:ProgramData\JEAConfiguration\JEAPrintOperators.pssc" @JEAConfigParams

Register-PSSessionConfiguration -Name PrintOperators -Path "$env:ProgramData\JEAConfiguration\JEAPrintOperators.pssc"
Restart-Service -name winrm


####
# Test

Enter-PSSession -ComputerName Client -ConfigurationName PrintOperators -Credential Company\JimJea

Get-Command
Ipconfig
Restart-service bits
Restart-service spooler
Exit-PSSession

get-childitem -Path C:\ProgramData\JEAConfiguration\Transcripts
ISE C:\ProgramData\JEAConfiguration\Transcripts\PowerShell_transcript.CLIENT.y5CHvSWe.20160707115645.txt

###########################################

# Last thing -- Quickly finding out what a user has access too

Get-PSSessionCapability -Username Company\JimJea -ConfigurationName PrintOperators

###########END
