# Brought to you by 24oz cans of delicious union made beverages
#todo: Present output in a more usable fashion

<# 
 .Synopsis
  Checks on the update status

 .Description
  Returns an array composed of Zeros and/or Ones to determine if the server needs to be rebooted or if there are updates available.
  {0,0} = Everythng's fine
  {1,0} = Reboot needed
  {0,1} = Updates needed
  {1,1} = Reboot and Updates needed

 .Parameter Server
  Server to check on Update Status.

 .Example
   # Get Update Status
   $status = echo $server | Check-Updates
#>

Function Get-UpdateStatus{
    [cmdletbinding()]
    Param([Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    [string]$server
    )
    process{ 
        $out = @()
                
        $remotereg = reg query "\\$server\HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" | Where-Object {$_ -like "HKEY_LOCAL*"}
        if($remotereg -like "*\RebootRequired"){
            $out += 1
        }else{
            $out += 0
        }

        $updates = Get-Content \\$server\c$\Windows\WindowsUpdate.log | Where-Object {$_ -like "* updates detected"}

        if($updates[-1].Split("`t")[5].Split(" ")[3] -ne 0){
            $out += 1
        }else{
            $out += 0
        }
        write-host "$server - $out `r`n"
    }
}

Export-ModuleMember -Function Get-UpdateStatus