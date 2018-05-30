### PerfMon module to PS_deployment of MS SQL databases ###
## 25-MAY-2018 = initial version, should create PerfMon DC for each SQL instance
$BaselineLocation = "D:\MSSQL_Baseline"
	
# check for instance name used
$InstanceList = Get-Service | Where-Object {$_.Name -like 'MSSQL$*'} | select Name

if ($InstanceList)
{
	foreach ($Instance in $InstanceList)
	{
	$original_file = "MSSQL_template.xml"
	$destination_file =  $Instance.Name+'_template.xml'
	$DC_Name = $Instance.Name+'_BASELINE'
	$newstring = $Instance.Name
	Write-Host "generating new config file... $destination_file"
	# replace string from original file to destination files for each instance	
	(Get-Content $original_file) | Foreach-Object {
		$_  -replace 'SQLServer', "$newstring" `
			-replace 'MSSQL_perf', "$newstring" `
			-replace "D:\\MSSQL_Baseline", "$BaselineLocation"
		} | Set-Content -encoding Unicode $destination_file -Force
	
	# import PerfMon from templates
	Write-Host "executing command.. " -NoNewline
	Write-Host "logman.exe import -name $DC_Name -xml $destination_file" -ForegroundColor DarkGreen
	logman.exe import -name $DC_Name -xml $destination_file	
	}
}
else {Write-Host "No named instance found for PerfMon installation.." -ForegroundColor Red}

# check for default instance
$DefaultInstanceInstalled = Get-Service | Where-Object {$_.Name -like 'MSSQLSERVER'} | select Name
$DefaultInstanceRunnning = Get-Service | Where-Object {$_.Name -like 'MSSQLSERVER'} | select status

if ($DefaultInstanceInstalled) 
	{ 
	Write-Host "Default instance is installed... checking status"
	if  ($DefaultInstanceRunnning.Status -eq "Running") 
		{
		Write-Host "Installing PerfMon for default instance.." -ForegroundColor Magenta
		logman.exe import -name "SQL_BASELINE" -xml "MSSQL_template.xml" 
		}
	else {Write-Host "default instance is NOT running.. NO PerfMon DC installed for default instance" -ForegroundColor Yellow}
	}
else {Write-Host "NO default instance installed.." -ForegroundColor Yellow}

# storage performance monitoring
#Write-Host "Installing STORAGE performance DC set.." -ForegroundColor Green
#logman.exe import -name "STORAGE_perf" -xml "STORAGE_perf_template.xml"
