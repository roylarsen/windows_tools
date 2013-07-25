# Copy one user's security groups to another user
# Makes this request a lot easier

param(
    [string] $new,
    [string] $existing
)

Import-Module ActiveDirectory

$usage = "Usage: ./copyusergroups.ps1 -new <first.last> -Existing <first.last>"

$copygroups = @()

if(-not $new -or -not $existing){ # Doing some checks for the correct parameters
    if(-not $new){
       Write-Output "You need the new user's Username"
       Write-Output $usage 
    }else{
        Write-Output "You need the existing user's Username"
        Write-Output $usage
    }
}else{ # This happens if both parameters are right 
    
    $exgroups = (Get-ADUser -Identity $existing -Properties *).MemberOf
    $negroups = (Get-ADUser -Identity $new -Properties *).MemberOf

    Foreach($group in $exgroups){
        $ndx = [array]::IndexOf($negroups, $group)
        if($ndx -eq -1){
            # Don't ask. It's two string splits and indexing to known elements in each resulting array
            $copygroups += ((($group.split(","))[0]).split("="))[1]
        }
    }
    # Just learned that % is shorthand for foreach. Wanted to try it here.
    $copygroups | % {Add-ADGroupMember $_ $new} 
    
    $negroups
}