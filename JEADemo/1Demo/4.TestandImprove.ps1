﻿<#
Disclaimer

This example code is provided without copyright and “AS IS”.  It is free for you to use and modify.
Note: These demos should not be run as a script. These are the commands that I use in the 
demonstrations and would need to be modified for your environment.

#>
Break # To prevent accidental execution as a script - Do not remove

# I'm signing in as a regular user!!!!!! with no admin privledges
Enter-PSSession -ComputerName Client -ConfigurationName PrintOperators -Credential Company\JimJea

Get-UserInfo  # Note connected user and RunAsUser
Get-Command # Not the commands plus restart-service

# Use the language 
Function Get-Foo {} #will fail

Restart-computer #NO FEAR!

Restart-service -name spooler -verbose
Restart-Service -name bits -verbose # Darn ---

#################################
# TIME to improve

# PrintManagmenet Module
Get-Command -Module PrintManagement

Get-Command *-Printer*
# So need to add VisibleFunctions

# Cleaning up my splatting

$MaintenanceRoleCapabilityCreationParams = @{
    Path = "$env:ProgramFiles\WindowsPowerShell\Modules\JEAPrintOperators\RoleCapabilities\PrintOperator.psrc"
    Author = 'Company Admin'
    CompanyName = 'Company'
    ModulesToImport = 'PrintManagement'
    VisibleCmdlets = 'Get-Service', @{ Name = 'Restart-Service'; Parameters = @{ Name = 'Name'; ValidateSet = 'Spooler'}},'NetTCPIP\Get-*'
    VisibleFunctions = '*-printer*'
    VisibleExternalCommands = 'C:\Windows\System32\ipconfig.exe'
    FunctionDefinitions = @{ Name = 'Get-UserInfo'; ScriptBlock = { $PSSenderInfo } }
}

New-PSRoleCapabilityFile @MaintenanceRoleCapabilityCreationParams 

Code "$env:ProgramFiles\WindowsPowerShell\Modules\JEAPrintOperators\RoleCapabilities\PrintOperator.psrc"

Enter-PSSession -ComputerName Client -ConfigurationName PrintOperators -Credential Company\JimJea
Get-Command -Module NetTCPIP
Ipconfig
Exit-PSSession
###########################
#DONE

