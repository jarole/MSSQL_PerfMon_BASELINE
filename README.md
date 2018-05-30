# MSSQL_PerfMon_BASELINE
PerfMon deployment PowerShell script for MS SQL Server BASELINE

# Usage/Target
Create perfMon user defined data collector set with most common MS SQL Server related performance counters.

# Installation
There are 2 files needed. Script and XML template. Copy both files together in any folder and run the PS script.
A simple Powershell script just reads instance name, does a check of the template and replace destination path.
Then create template for all SQL instances and execute them all.
As a result you should have user defined DC set for each SQL instance.

# Default parameters
- You can create your own PerfMon template with custom counters
- schedule in the template is configured to run every minute on daily basis.
- file format of PerfMon is excel style .tsv
- used counters in default template:

		\Paging File(_Total)\% Usage
		\Paging File(_Total)\% Usage Peak
		\PhysicalDisk(*)\Current Disk Queue Length
		\Processor(_Total)\% Privileged Time
		\Processor(_Total)\% Processor Time
		\SQLServer:Buffer Manager\Buffer cache hit ratio
		\SQLServer:Buffer Manager\Page life expectancy
		\SQLServer:General Statistics\User Connections
		\SQLServer:Locks(_Total)\Lock Wait Time (ms)
		\SQLServer:Locks(_Total)\Lock Waits/sec
		\SQLServer:Locks(_Total)\Number of Deadlocks/sec
		\SQLServer:SQL Statistics\Batch Requests/sec
		\SQLServer:SQL Statistics\SQL Compilations/sec
		\SQLServer:SQL Statistics\SQL Re-Compilations/sec
