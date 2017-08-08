

# 1.Writing a DSC Configuration
ise C:\Scripts\DSCCamp\1.PushDeploy\2.Config.ps1

# 2.Configuring the LCM
Get-Help *-DSC*
Get-Help *localConfig*
Get-DscLocalConfigurationManager -CimSession s1

# Describe basic settings - not too much right now
#Script to change LCM to AutoCorrect - leave at Push LCM_Push.Ps1


# Set the LCM on two remote targets
Set-DSCLocalConfigurationManager -ComputerName S1 -Path c:\DSC\LCM –Verbose
Set-DSCLocalConfigurationManager -ComputerName S2 -Path c:\DSC\LCM –Verbose
#Show change
Get-DscLocalConfigurationManager -CimSession s1,s2

#Show configuration file location on S1
Explorer \\s1\c$\windows\system32\Configuration

# 3. Performing the Push deployment 

# Locate Resources - brief
Get-DscResource
Get-DscResource -Name WindowsFeature | Select-Object -ExpandProperty properties
Get-DscResource -name Windowsfeature -Syntax # Show in ISE

# Create the configuration
ise C:\Scripts\DSCCamp\1.PushDeploy\2.Config.ps1 #Run
explorer C:\dsc\Config

# Stop Service

Invoke-Command -ComputerName s1,s2 {Stop-service -Name bits}
Invoke-Command -ComputerName s1,s2 {get-service -name bits | Select-Object -Property Name,Status}

# Send configuration to target S1
Start-DscConfiguration -Path C:\DSC\Config -ComputerName s1 -Verbose -Wait
Get-DscConfiguration -CimSession s1,s2

# Test on S1 and S2 -- S2 should fail - no config
Invoke-Command -ComputerName s1,s2 {get-service -name bits | Select-Object -Property Name,Status}
Invoke-Command -ComputerName s1 {Stop-service -name bits}
Invoke-Command -ComputerName s1,s2 {get-service -name bits | Select-Object -Property Name,Status}

Update-DscConfiguration -ComputerName s1 -Wait -Verbose
# Update-DscConfiguration Deosn't work in PUSH mode
Start-DscConfiguration -ComputerName s1 -UseExisting -Wait -Verbose

Invoke-Command -ComputerName s1,s2 {get-service -name bits | Select-Object -Property Name,Status}

# Remove configuration from S1

Remove-DscConfigurationDocument -CimSession s1 -Stage Current #Current, Pending, Previous
Get-DscConfiguration -CimSession s1,s2


