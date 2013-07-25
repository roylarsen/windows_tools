# Brought to you by 24oz cans of delicious union made beverages
#todo: Remote machines (kind of the point)
#todo: Present output in a more usable fashion
wuauclt /DetectNow
if(Test-Path -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"){Write-Output "reboot required!"}
$updates = Get-Content C:\Windows\WindowsUpdate.log | Where-Object {$_ -like "* updates detected"}
$hostname = hostname
if($updates[-1].Split("`t")[5].Split(" ")[3] -ne 0){Write-Host "Updates needed on " $hostname"!"}
