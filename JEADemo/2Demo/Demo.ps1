<#
Disclaimer

This example code is provided without copyright and “AS IS”.  It is free for you to use and modify.
Note: These demos should not be run as a script. These are the commands that I use in the 
demonstrations and would need to be modified for your environment.

#>
Break # To prevent accidental execution as a script - Do not remove

# Create a deployment folder and copy deployment files (Module and Session Configuration)
New-Item c:\JeaDeploy -ItemType Directory

# Copy the Session config to the Share
Copy-Item -Path 'C:\ProgramData\JEAConfiguration\JEAPrintOperators.pssc' -Destination 'c:\JeaDeploy'
# Copy the Module and Role Capabilities to the Share
Copy-Item -Path 'C:\Program Files\WindowsPowerShell\Modules\JEAPrintOperators' -Recurse -Destination 'c:\JEADeploy\JEAPrintOperators'

Get-Childitem -path c:\JEADeploy

# Create an installation script
New-Item -Path c:\JeaDeploy\JeaDeploy.ps1 -ItemType File
Code C:\JeaDeploy\JeaDeploy.ps1

# Deploy files
# Run the script on the remote computers
Invoke-Command -ComputerName dc -FilePath C:\JeaDeploy\JeaDeploy.ps1

# Test/Troubleshoot
Get-Childitem -path '\\s1\c$\ProgramData\JEAConfiguration'
Get-Childitem -path '\\s1\c$\Program Files\WindowsPowerShell\Modules\JEAPrintOperators'

Enter-PSSession -ComputerName s1
Get-PSSessionConfiguration 
Exit-PSSession

# Test
Enter-PSSession -ComputerName s1 -ConfigurationName PrintOperators -Credential Company\JimJea
Get-Childitem -path '\\s1\c$\ProgramData\JEAConfiguration\Transcripts'
ISE '\\s1\c$\programdata\JEAConfiguration\Transcripts\'

# If you get a module loading error -- such as on core
Invoke-Command -ComputerNAme s1 {Install-WindowsFeature -name Internet-Print-Client -IncludeManagementTools}

# End Demo