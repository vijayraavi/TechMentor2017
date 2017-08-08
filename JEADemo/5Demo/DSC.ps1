<#
Disclaimer

This example code is provided without copyright and “AS IS”.  It is free for you to use and modify.
Note: These demos should not be run as a script. These are the commands that I use in the 
demonstrations and would need to be modified for your environment.

#>
Break # To prevent accidental execution as a script - Do not remove


# Download from Github -- or the PSGallery in the future

Copy-Item -Path 'C:\JEADownload\JustEnoughAdministration' -Recurse  -Destination 'C:\Program Files\WindowsPowerShell\Modules' -force
Get-DscResource
Get-DscResource -Module JustEnoughAdministration -Syntax
# Open new file a copy the syntax
# Switch to preloaded DSCConfig

# Additional help
ISE C:\JEADownload\JustEnoughAdministration\JustEnoughAdministration.psm1
### BREAK GLASS  line 119

# COPY Modules
ISE C:\JeaDeployDSC\JEAPrintOperators\RoleCapabilities\PrintOperator.psrc

Copy-Item -Path 'C:\JeaDeployDSC\JEAPrintOperators' -Recurse -Destination '\\s2\c$\Program Files\WindowsPowerShell\Modules\JEAPrintOperators' -Force
# The SessionType is default when using DSC - not restrictedRemoteserver
Copy-Item -Path 'C:\JEADownload\JustEnoughAdministration' -Recurse  -Destination '\\s2\c$\Program Files\WindowsPowerShell\Modules' 

# RUN!!!  DSCConfig to make mof

Start-DscConfiguration -ComputerName s2 -Path c:\mof -Wait -Verbose


Enter-PSSession -ComputerName s2 -ConfigurationName PrintOperators -Credential Company\JimJea
Restart-SErvice -name bits
Exit-PSSession

#Show path to .pssc
Enter-PSSession -computername s2
Get-PSSessionConfiguration -name PrintOperators | format-List -Property *

# End