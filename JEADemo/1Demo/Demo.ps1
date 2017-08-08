<#
Disclaimer

This example code is provided without copyright and “AS IS”.  It is free for you to use and modify.
Note: These demos should not be run as a script. These are the commands that I use in the 
demonstrations and would need to be modified for your environment.

#>
Break # To prevent accidental execution as a script - Do not remove

# Set-AdUserJitAdmin
# Note -- Save .ps1 as a .psm1 adn make into module

# Test Remoting with user account, display group membership

Enter-PSSession -ComputerName S1 -Credential Company\JustAUser #Will fail

Get-Aduser -Identity 'cn=JustAUser,ou=IT,dc=Company,DC=pri' -Properties MemberOf | 
    Select-Object -ExpandProperty MemberOf

# View the help file
Get-Help Set-AdUserJitAdmin 

# Set the admin group schedule
Set-ADUserJitAdmin -UserDN 'CN=JustAUser1,OU=IT,DC=Company,DC=Pri' -Domain 'Company.Pri' -PrivGroup 'Domain Admins' -TtlHours 1 -Verbose

# Test -- this will work
Enter-PSSession -ComputerName S1 -Credential Company\JustAUser

# End


