<#

.Requires -version 2 - Connect-MicrosoftTeams and then Run the script in Powershell
Updated on 28 Feb 2021

.SYNOPSIS
.\TeamsChannelMemberReport.ps1 - It Can Display all the Teams and its Channels and its members on a List

Or It can Export to a CSV file
With Export of Specific teams 


Example 1

PS C:\Scripts> .\TeamsChannelMemberReportv1.0.ps1


Teams Channel Member Report
----------------------------

1.Display in Microsoft Teams Shell

2.Export to CSV File

3.Display Specific Microsoft Team in Shell

4.Export Specific Microsoft Team to CSV File

Choose The Task: 1

User SMTP Address         Role   Channel DisplayName Team DisplayName
-----------------         ----   ------------------- ----------------
sathesh@azure365pro.com   Owner  General             Teams_Azure365pro
brindha@azure365pro.com   Member General             Teams_Azure365pro
wordpress@azure365pro.com Member General             Teams_Azure365pro
sathesh@azure365pro.com   Owner  General             Teams_Azure365pro
brindha@azure365pro.com   Member General             Teams_Azure365pro
wordpress@azure365pro.com Member General             Teams_Azure365pro
sathesh@azure365pro.com   Owner  General             InformationTec...
wordpress@azure365pro.com Member General             InformationTec...
sathesh@azure365pro.com   Owner  ServiceDesk Team    InformationTec...
sathesh@azure365pro.com   Owner  Infrastructure Team InformationTec...

Example 2

PS C:\Scripts> .\TeamsChannelMemberReportv1.0.ps1


Teams Channel Member Report
----------------------------

1.Display in Microsoft Teams Shell

2.Export to CSV File

3.Display Specific Microsoft Team in Shell

4.Export Specific Microsoft Team to CSV File

Choose The Task: 2
Enter the Path of CSV file (Eg. C:\Teams.csv): c:\teams.csv

.Author
Written By: Satheshwaran Manoharan

Change Log
V1.0, 13/05/2020 - Initial version
#>

Write-host "

Teams Channel Member Report
----------------------------

1.Display in Microsoft Teams Shell

2.Export to CSV File

3.Display Specific Microsoft Team in Shell

4.Export Specific Microsoft Team to CSV File"-ForeGround "Cyan"

#----------------
# Script
#----------------

Write-Host "               "

$number = Read-Host "Choose The Task"
$output = @()
switch ($number) 
{

1 {
$i = 0 
$AllTeams = Get-Team 
Foreach ($Team in $AllTeams)
{
$AllChannels = Get-TeamChannel -GroupID $Team.GroupID
Foreach ($Channel in $AllChannels)
{
$AllMembers = Get-TeamChannelUser -GroupId $Team.GroupID -DisplayName $channel.DisplayName
Foreach ($member in $AllMembers)
{
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "User SMTP Address" -Value $member.User
$userObj | Add-Member NoteProperty -Name "Role" -Value $member.role
$userObj | Add-Member NoteProperty -Name "Channel DisplayName" -Value $Channel.DisplayName
$userObj | Add-Member NoteProperty -Name "Team DisplayName" -Value $Team.DisplayName

$output += $UserObj  

}
}
# update counters and write progress
$i++
Write-Progress -activity "Scanning Teams . . .Channels . . . Members" -status "Scanned: $i of $($AllTeams.Count)" -percentComplete (($i / $AllTeams.Count)  * 100)
Write-Output $Output
}
;Break}

2 {
$i = 0 
$CSVfile = Read-Host "Enter the Path of CSV file (Eg. C:\Teams.csv)" 
$AllTeams = Get-Team 
Foreach ($Team in $AllTeams)
{
$AllChannels = Get-TeamChannel -GroupID $Team.GroupID
Foreach ($Channel in $AllChannels)
{
$AllMembers = Get-TeamChannelUser -GroupId $Team.GroupID -DisplayName $channel.DisplayName
Foreach ($member in $AllMembers)
{
$userObj = New-Object PSObject
$userObj | Add-Member NoteProperty -Name "DisplayName" -Value $member.Name
$userObj | Add-Member NoteProperty -Name "UserId" -Value $member.UserId
$userObj | Add-Member NoteProperty -Name "User SMTP Address" -Value $member.User
$userObj | Add-Member NoteProperty -Name "Role" -Value $member.role
$userObj | Add-Member NoteProperty -Name "Channel DisplayName" -Value $Channel.DisplayName
$userObj | Add-Member NoteProperty -Name "Channel Description" -Value $Channel.Description
$userObj | Add-Member NoteProperty -Name "Channel MembershipType" -Value $Channel.MembershipType
$userObj | Add-Member NoteProperty -Name "Team GroupID" -Value $Team.GroupId
$userObj | Add-Member NoteProperty -Name "Team DisplayName" -Value $Team.DisplayName
$userObj | Add-Member NoteProperty -Name "Team Description" -Value $Team.Description
$userObj | Add-Member NoteProperty -Name "Team Visibility" -Value $Team.Visibility
$userObj | Add-Member NoteProperty -Name "Team MailNickName" -Value $Team.MailNickName
$userObj | Add-Member NoteProperty -Name "Team Classification" -Value $Team.Classification
$userObj | Add-Member NoteProperty -Name "Team Archived" -Value $Team.Archived
$userObj | Add-Member NoteProperty -Name "Team AllowGiphy" -Value $Team.AllowGiphy
$userObj | Add-Member NoteProperty -Name "Team GiphyContentRating" -Value $Team.GiphyContentRating 
$userObj | Add-Member NoteProperty -Name "Team AllowStickersAndMemes" -Value $Team.AllowStickersAndMemes
$userObj | Add-Member NoteProperty -Name "Team AllowGuestCreateUpdateChannels" -Value $Team.AllowGuestCreateUpdateChannels
$userObj | Add-Member NoteProperty -Name "Team AllowGuestDeleteChannels" -Value $Team.AllowGuestDeleteChannels
$userObj | Add-Member NoteProperty -Name "Team AllowCreateUpdateChannels" -Value $Team.AllowCreateUpdateChannels
$userObj | Add-Member NoteProperty -Name "Team AllowCreatePrivateChannels" -Value $Team.AllowCreatePrivateChannels
$userObj | Add-Member NoteProperty -Name "Team AllowDeleteChannels" -Value $Team.AllowDeleteChannels
$userObj | Add-Member NoteProperty -Name "Team AllowAddRemoveApps" -Value $Team.AllowAddRemoveApps
$userObj | Add-Member NoteProperty -Name "Team AllowCreateUpdateRemoveTabs" -Value $Team.AllowCreateUpdateRemoveTabs
$userObj | Add-Member NoteProperty -Name "Team AllowCreateUpdateRemoveConnectors" -Value $Team.AllowCreateUpdateRemoveConnectors
$userObj | Add-Member NoteProperty -Name "Team AllowUserEditMessages" -Value $Team.AllowUserEditMessages
$userObj | Add-Member NoteProperty -Name "Team AllowUserDeleteMessages " -Value $Team.AllowUserDeleteMessages 
$userObj | Add-Member NoteProperty -Name "Team AllowOwnerDeleteMessages" -Value $Team.AllowOwnerDeleteMessages
$userObj | Add-Member NoteProperty -Name "Team AllowTeamMentions" -Value $Team.AllowTeamMentions
$userObj | Add-Member NoteProperty -Name "Team AllowChannelMentions" -Value $Team.AllowChannelMentions
$userObj | Add-Member NoteProperty -Name "Team ShowInTeamsSearchAndSuggestions" -Value $Team.ShowInTeamsSearchAndSuggestions

$output += $UserObj  

}
}
# update counters and write progress
$i++
Write-Progress -activity "Scanning Teams . . .Channels . . . Members" -status "Scanned: $i of $($AllTeams.Count)" -percentComplete (($i / $AllTeams.Count)  * 100)
$output | Export-csv -Path $CSVfile -NoTypeInformation -Encoding UTF8

}
;Break}

3 {
    $i = 0 
    $Teamname = Read-Host "Enter the Team Display name or Range (Eg. Teamname , Team*,*Team)"
    $AllTeams = Get-Team | Where-object {$_.DisplayName -like $Teamname}
    Foreach ($Team in $AllTeams)
    {
    $AllChannels = Get-TeamChannel -GroupID $Team.GroupID
    Foreach ($Channel in $AllChannels)
    {
    $AllMembers = Get-TeamChannelUser -GroupId $Team.GroupID -DisplayName $channel.DisplayName
    Foreach ($member in $AllMembers)
    {
    $userObj = New-Object PSObject
    $userObj | Add-Member NoteProperty -Name "User SMTP Address" -Value $member.User
    $userObj | Add-Member NoteProperty -Name "Role" -Value $member.role
    $userObj | Add-Member NoteProperty -Name "Channel DisplayName" -Value $Channel.DisplayName
    $userObj | Add-Member NoteProperty -Name "Team DisplayName" -Value $Team.DisplayName
    
    $output += $UserObj  
    
    }
    }
    # update counters and write progress
    $i++
    Write-Progress -activity "Scanning Teams . . .Channels . . . Members" -status "Scanned: $i of $($AllTeams.Count)" -percentComplete (($i / $AllTeams.Count)  * 100)
    Write-Output $Output
    }
    ;Break}

    4 {
        $i = 0 
        $CSVfile = Read-Host "Enter the Path of CSV file (Eg. C:\Teams.csv)" 
        $Teamname = Read-Host "Enter the Team Display name or Range (Eg. Teamname , Team*,*Team)"
        $AllTeams = Get-Team | Where-object {$_.DisplayName -like $Teamname}
        Foreach ($Team in $AllTeams)
        {
        $AllChannels = Get-TeamChannel -GroupID $Team.GroupID
        Foreach ($Channel in $AllChannels)
        {
        $AllMembers = Get-TeamChannelUser -GroupId $Team.GroupID -DisplayName $channel.DisplayName
        Foreach ($member in $AllMembers)
        {
        $userObj = New-Object PSObject
        $userObj | Add-Member NoteProperty -Name "DisplayName" -Value $member.Name
        $userObj | Add-Member NoteProperty -Name "UserId" -Value $member.UserId
        $userObj | Add-Member NoteProperty -Name "User SMTP Address" -Value $member.User
        $userObj | Add-Member NoteProperty -Name "Role" -Value $member.role
        $userObj | Add-Member NoteProperty -Name "Channel DisplayName" -Value $Channel.DisplayName
        $userObj | Add-Member NoteProperty -Name "Channel Description" -Value $Channel.Description
        $userObj | Add-Member NoteProperty -Name "Channel MembershipType" -Value $Channel.MembershipType
        $userObj | Add-Member NoteProperty -Name "Team GroupID" -Value $Team.GroupId
        $userObj | Add-Member NoteProperty -Name "Team DisplayName" -Value $Team.DisplayName
        $userObj | Add-Member NoteProperty -Name "Team Description" -Value $Team.Description
        $userObj | Add-Member NoteProperty -Name "Team Visibility" -Value $Team.Visibility
        $userObj | Add-Member NoteProperty -Name "Team MailNickName" -Value $Team.MailNickName
        $userObj | Add-Member NoteProperty -Name "Team Classification" -Value $Team.Classification
        $userObj | Add-Member NoteProperty -Name "Team Archived" -Value $Team.Archived
        $userObj | Add-Member NoteProperty -Name "Team AllowGiphy" -Value $Team.AllowGiphy
        $userObj | Add-Member NoteProperty -Name "Team GiphyContentRating" -Value $Team.GiphyContentRating 
        $userObj | Add-Member NoteProperty -Name "Team AllowStickersAndMemes" -Value $Team.AllowStickersAndMemes
        $userObj | Add-Member NoteProperty -Name "Team AllowGuestCreateUpdateChannels" -Value $Team.AllowGuestCreateUpdateChannels
        $userObj | Add-Member NoteProperty -Name "Team AllowGuestDeleteChannels" -Value $Team.AllowGuestDeleteChannels
        $userObj | Add-Member NoteProperty -Name "Team AllowCreateUpdateChannels" -Value $Team.AllowCreateUpdateChannels
        $userObj | Add-Member NoteProperty -Name "Team AllowCreatePrivateChannels" -Value $Team.AllowCreatePrivateChannels
        $userObj | Add-Member NoteProperty -Name "Team AllowDeleteChannels" -Value $Team.AllowDeleteChannels
        $userObj | Add-Member NoteProperty -Name "Team AllowAddRemoveApps" -Value $Team.AllowAddRemoveApps
        $userObj | Add-Member NoteProperty -Name "Team AllowCreateUpdateRemoveTabs" -Value $Team.AllowCreateUpdateRemoveTabs
        $userObj | Add-Member NoteProperty -Name "Team AllowCreateUpdateRemoveConnectors" -Value $Team.AllowCreateUpdateRemoveConnectors
        $userObj | Add-Member NoteProperty -Name "Team AllowUserEditMessages" -Value $Team.AllowUserEditMessages
        $userObj | Add-Member NoteProperty -Name "Team AllowUserDeleteMessages " -Value $Team.AllowUserDeleteMessages 
        $userObj | Add-Member NoteProperty -Name "Team AllowOwnerDeleteMessages" -Value $Team.AllowOwnerDeleteMessages
        $userObj | Add-Member NoteProperty -Name "Team AllowTeamMentions" -Value $Team.AllowTeamMentions
        $userObj | Add-Member NoteProperty -Name "Team AllowChannelMentions" -Value $Team.AllowChannelMentions
        $userObj | Add-Member NoteProperty -Name "Team ShowInTeamsSearchAndSuggestions" -Value $Team.ShowInTeamsSearchAndSuggestions
        
        $output += $UserObj  
        
        }
        }
        # update counters and write progress
        $i++
        Write-Progress -activity "Scanning Teams . . .Channels . . . Members" -status "Scanned: $i of $($AllTeams.Count)" -percentComplete (($i / $AllTeams.Count)  * 100)
        $output | Export-csv -Path $CSVfile -NoTypeInformation -Encoding UTF8
        
        }
        ;Break}

Default {Write-Host "No matches found , Enter Options 1 or 2" -ForeGround "red"}

}