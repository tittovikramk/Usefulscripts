#Script To Restart The Wildfly Services On A Remote System.

$MyDomain=’biintegration’ 
$MyClearTextUsername=’biadmin’ 
$MyClearTextPassword=’password_123’
$MyUsernameDomain=$MyDomain+’\’+$MyClearTextUsername
$SecurePassword=Convertto-SecureString –String $MyClearTextPassword –AsPlainText –force
$computer="10.1.2.133"
$MyCredentials=New-object System.Management.Automation.PSCredential $MyUsernameDomain,$SecurePassword 

if ((get-wmiobject win32_service -computer $computer -credential $MyCredentials -filter "name='WILDFLY-RMM'").state -eq "Running")
{
(get-wmiobject win32_service -computer $computer -credential $MyCredentials -filter "name='WILDFLY-RMM'").stopService()
 }
else 
{
((get-wmiobject win32_service -computer $computer -credential $MyCredentials -filter "name='WILDFLY-RMM'").state -eq "stopped")
}
(get-wmiobject win32_service -computer $computer -credential $MyCredentials -filter "name='WILDFLY-RMM'").startService()

Write-host "WILDFLY Service Has Been Restarted Successfully"
