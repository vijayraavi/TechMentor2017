<#
Disclaimer

This example code is provided without copyright and “AS IS”.  It is free for you to use and modify.
Note: These demos should not be run as a script. These are the commands that I use in the 
demonstrations and would need to be modified for your environment.

#>
Break # To prevent accidental execution as a script - Do not remove


# JEADeploy.ps1

# Create directory for session configuration if it doesn't exist
If ((Test-Path -path 'c:\ProgramData\JEAConfiguration') -eq $False) {
    Write-Output "Creating JEAConfiguration directory"
    New-Item -Path 'c:\ProgramData\JEAConfiguration' -ItemType Directory
}

# Copy Session and Modules
Write-Output "Copying Modules and Session Configuration"
Copy-Item -Path 'c:\JEADeploy\JEAPrintOperators.pssc' -Destination 'c:\ProgramData\JEAConfiguration'
Copy-Item -Path 'c:\JEADeploy\JEAPrintOperators' -Recurse -Destination 'c:\Program Files\WindowsPowerShell\Modules' 

# Register the endpoint

Write-Output " Registering Endpoint"

    if (Get-PSSessionConfiguration -Name PrintOperators -ErrorAction SilentlyContinue)
    {
        Unregister-PSSessionConfiguration -Name PrintOperators -ErrorAction Stop
        
    }

Register-PSSessionConfiguration -Name PrintOperators -Path 'c:\ProgramData\JEAConfiguration\JEAPrintOperators.pssc'

# End

