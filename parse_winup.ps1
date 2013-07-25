# Brought to you by 24oz cans of delicious union made beverages
#todo: Remote machines (kind of the point)
#todo: Present output in a more usable fashion
wuauclt /DetectNow
$hostname = hostname
if(Test-Path -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"){Write-Output "Reboot required on $hostname!"}
$updates = Get-Content C:\Windows\WindowsUpdate.log | Where-Object {$_ -like "* updates detected"}
if($updates[-1].Split("`t")[5].Split(" ")[3] -ne 0){Write-Host "Updates needed on $hostname!"}
