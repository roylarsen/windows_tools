param(
    [string] $dept
)
Import-Module ActiveDirectory

$out = "$dept users.txt"
$users = Get-ADUser -Filter "*" -searchBase <path to OU of users> -Properties *

foreach($user in $users){
    $user.samaccountname | Out-File $out -append
    foreach($groups in $user.MemberOf){
        foreach($group in $groups){
            ((($group.split(","))[0]).split("="))[1] | Out-File $out -Append
        }
    }
    "`r`n" | Out-File $out -append
}