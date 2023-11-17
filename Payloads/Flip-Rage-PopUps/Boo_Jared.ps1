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
"Well, well, well, if it isn't Jared, the software developer extraordinaire. You know, Jared, I've seen better code from my grandma when she accidentally sat on the TV remote. I mean, come on, your code is so convoluted, it's like you're trying to hide a secret pizza recipe in there. Newsflash, Jared: no one's stealing your code; they're too busy trying to decipher it."
"I asked Jared for a clean code review once, and he handed me a document that looked like it had been through a paper shredder and then reassembled by a blindfolded monkey. I've seen more structure in a collapsed Jenga tower than in your codebase."
"And let's not even get started on Jared's debugging skills. Rumor has it, the last time he tried to fix a bug, he ended up creating three more and a new flavor of pizza – 'Null Pointer Margherita.' It's so tasteless; even the compiler refused to swallow it."
"Jared, I heard your idea of refactoring is copying and pasting the same chunk of code over and over until it looks like modern art. Picasso would be proud, my friend."
"But hey, don't worry, Jared, your code is like a fine wine – it gets worse with time. I bet even the hackers take pity on your system. They're probably thinking, 'Why bother? Let's find a challenge, not a comedy show.'"
"So, here's to you, Jared, the maestro of messy code. May your bugs be as elusive as your code comments. Cheers!"
)

for ($i=1; $i -le $cycles; $i++) {

Foreach ($msg in $msgs) {
[System.Windows.Forms.MessageBox]::Show($msg , "Booo Jared, Boooo.exe" , 4 , 'Question')
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
