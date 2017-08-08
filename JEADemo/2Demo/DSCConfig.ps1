<#
Disclaimer

This example code is provided without copyright and “AS IS”.  It is free for you to use and modify.
Note: These demos should not be run as a script. These are the commands that I use in the 
demonstrations and would need to be modified for your environment.

#>


Configuration JEAEndPoint {

    Param (
        [Parameter(Mandatory=$true)]
        [string[]]$ComputerName
    )

    
    
    Import-DscResource -ModuleName JustEnoughAdministration 

    Node $ComputerName {
        JeaEndpoint PrintOperators #ResourceName
        {
            EndpointName = 'PrintOperators'
            RoleDefinitions = "@{'Company\JEA Print Operators' = @{ RoleCapabilities = 'PrintOperator' }}"
            #[DependsOn = [string[]]]
            #[GroupManagedServiceAccount = [string]]
            #[MountUserDrive = [bool]]
            #[PsDscRunAsCredential = [PSCredential]]
            #[RequiredGroups = [string]]
            #[RunAsVirtualAccountGroups = [string[]]]
            #[ScriptsToProcess = [string[]]]
            TranscriptDirectory = 'c:\ProgramData\JEAConfiguration\Transcripts'
            #[UserDriveMaximumSize = [Int64]]
        }
    }
}

JEAEndPoint -ComputerName s2 -OutputPath c:\MOF


