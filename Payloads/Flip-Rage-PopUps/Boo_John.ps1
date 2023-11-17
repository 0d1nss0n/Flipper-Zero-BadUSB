############################################################################################################################################################                      
#                                  |  ___                           _           _              _             #              ,d88b.d88b                     #                                 
# Title        : Rage-PopUps       | |_ _|   __ _   _ __ ___       | |   __ _  | | __   ___   | |__    _   _ #              88888888888                    #           
# Author       : I am Jakoby       |  | |   / _` | | '_ ` _ \   _  | |  / _` | | |/ /  / _ \  | '_ \  | | | |#              `Y8888888Y'                    #           
# Version      : 1.0               |  | |  | (_| | | | | | | | | |_| | | (_| | |   <  | (_) | | |_) | | |_| |#               `Y888Y'                       #
# Category     : Prank             | |___|  \__,_| |_| |_| |_|  \___/   \__,_| |_|\_\  \___/  |_.__/   \__, |#                 `Y'                         #
# Target       : Windows 7,10,11   |                                                                   |___/ #           /\/|_      __/\\                  #     
# Mode         : HID               |                                                           |\__/,|   (`\ #          /    -\    /-   ~\                 #             
#                                  |  My crime is that of curiosity                            |_ _  |.--.) )#          \    = Y =T_ =   /                 #      
#                                  |   and yea curiosity killed the cat                        ( T   )     / #   Luther  )==*(`     `) ~ \   Hobo          #                                                                                              
#                                  |    but satisfaction brought him back                     (((^_(((/(((_/ #          /     \     /     \                #    
#__________________________________|_________________________________________________________________________#          |     |     ) ~   (                #
#  tiktok.com/@i_am_jakoby                                                                                   #         /       \   /     ~ \               #
#  github.com/I-Am-Jakoby                                                                                    #         \       /   \~     ~/               #         
#  twitter.com/I_Am_Jakoby                                                                                   #   /\_/\_/\__  _/_/\_/\__~__/_/\_/\_/\_/\_/\_#                     
#  instagram.com/i_am_jakoby                                                                                 #  |  |  |  | ) ) |  |  | ((  |  |  |  |  |  |#              
#  youtube.com/c/IamJakoby                                                                                   #  |  |  |  |( (  |  |  |  \\ |  |  |  |  |  |#
############################################################################################################################################################

<#
.SYNOPSIS
	This script will open a series of pop-ups in order to taunt your target. I wrote it initially to target call center scammers.

.DESCRIPTION 
	This program is meant to taunt your target. Below are a series insults you can modify as you like. The program will generate a Pop-up 
	for each one of them. 
#>

#------------------------------------------------------------------------------------------------------------------------------------

Add-Type -AssemblyName System.Windows.Forms

# The number of times you want it to cycle through your list of questions

$cycles = 1

# List as many questions here as you like, it will cycle through all of them

$msgs = @(
"Oh, ladies and gentlemen, buckle up, because we have got John the software developer in the house! Give it up for John, the guy who writes code faster than he can order a pizza. Seriously, John, your code is like a bad delivery – it takes forever, and when it finally arrives, you wish you would have ordered from a different place."
"I heard John's code is so inefficient, they are thinking of renaming it from Pizza Point-of-Sale to Pizza Point-of-Fail. I mean, come on, John, even my grandma's rotary phone has better response time than your software."
"And let's talk about John's coding style – it's like trying to read hieroglyphics after a night of heavy drinking. I asked him for some clean code once, and he handed me a napkin with spaghetti sauce stains. Real professional, John."
"But hey, give John a break, he's a software developer at a pizza POS company. His code might be a mess, but at least it's not as cheesy as the excuses he gives for those bugs. 'Oh, it's not a bug, it's a feature!' No, John, it's a disaster."
"I hear John's idea of version control is writing 'final_final_version_v2.0_final_really_this_time' at the end of every file. No wonder his colleagues have started calling him the 'Commit King' – because every time he commits, the whole team wants to commit to finding a new job."
"But in all seriousness, John, keep doing your thing. Who knows, maybe one day your code will be so legendary, they'll name a pizza after it – the 'Buffer Overflow Supreme.' Just make sure it doesn't crash halfway through eating it. Cheers, John!"
)

for ($i=1; $i -le $cycles; $i++) {

Foreach ($msg in $msgs) {
[System.Windows.Forms.MessageBox]::Show($msg , "Booo John, Boooo.exe" , 4 , 'Question')
}
}

#----------------------------------------------------------------------------------------------------

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
