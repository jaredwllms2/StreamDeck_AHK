; Activate Ticket System Chrome Window
DetectHiddenWindows, On ;Ensures that any windows or apps can be seen by AHK
If WinExist("TicketSystemWindowTitle (Prod) - Google Chrome") ;Checks if the website we are interested in is opened
{
	WinActivate ;If the website is opened on the computer, activate that Chrome window
}
else
{
	If WinExist("TicketSystemWindowAlternateTitle - Google Chrome") ;Sometimes the website title shows up under an alternative name, this checks to see if the first title wasn't found, look for the alternate
	{
	WinActivate ;If a Chrome window exists with the alternate window title, open that window
	WinWaitActive, TicketSystemWindowAlternateTitle - Google Chrome ;Wait until the Chrome window is active
	Send {F5} ;Refresh the window - this is to get back to a fresh, clean page
	Sleep 5000 ;Wait 5 seconds (5000ms) for the page to refresh
	}
	else
	{
	MsgBox Please Open ExampleWebsite ;If no ticket system window exist, display a warning message to the user
	return ;Since no ticket system window exists, break out of the script - we don't want to proceed further
	}
}

; Wait Until Fresh Window is Activated
WinWaitActive, TicketSystemWindowAlternateTitle - Google Chrome

; Wait Until the page finishes loading - to tell this, we repeatedly look to see if the website's icon appears in the tab area of Chrome
Loop
{
ImageSearch, EvX, EvY, 22, 13, 200, 41, %USERPROFILE%\Documents\StreamDeck\Images\ImageSearch\TicketSystem_Icon.png ;I have a screenshot of the website icon saved to my computer, this command searches the coordinates on screen to see if the saved image exists on screen
if (ErrorLevel = 2) ;ErrorLevel 2 means the search couldn't be complete
    Sleep 1000 ;Wait one second and then try again
else if (ErrorLevel = 1) ;ErrorLevel 1 means the search was completed, but the image was not found
    Sleep 1000 ;Wait one second and then try searching again
else ;If the image was found, there will be an ErrorLevel of 0, so if else, then break from the ImageSearch loop and continue with the script now that the page has loaded
    break
}


; Confirm that the window is scrolled to the top of the page - again we use ImageSearch to search for the logo which exists at the top of the page
Send {Home} ;First we push HOME to try jumping to the top of the page before running a search
Sleep 1000 ;Wait one second after jumping to the top of the page before continuing to the ImageSearch
ImageSearch, EvX, EvY, 0, 100, 280, 170, %USERPROFILE%\Documents\StreamDeck\Images\ImageSearch\ExampleWebsite_logo.png ;Scan the top left area of the webpage for the website's logo
if (ErrorLevel = 2) ;ErrorLevel 2 means the search couldn't be complete
{
    MsgBox Could not conduct the ITSM logo search ;If the search couldn't be complete, display an error to the user
	return ;If the search couldn't be complete, break out of the script, we don't want to continue further
}
else if (ErrorLevel = 1);ErrorLevel 1 means the search was completed, but the image was not found
{
    MsgBox Unable to locate the ExampleWebsite logo ;If we weren't able to find the logo, display an error to the user
	return ;Break out of the script, we don't want to continue further
}

; Locate "My Actions" button on the website and click it
ImageSearch, CoordX, CoordY, 0, 115, 224, 676, %USERPROFILE%\Documents\StreamDeck\Images\ImageSearch\MyActions_Text_Screenshot.png ;Scan the left hand area of the webpage for the My Actions button
MOUSEMOVE, (CoordX+73), (CoordY+5) ;CoordX and CoordY are the window coordinates for the top left pixel of the "My Actions" button - based on the .png file above, I know that the MyAction button is 146x10px. So to click the middle of the button, I add 1/2 of the length (+73)and width (+5) to CoordX and CoordY.
Sleep 400 ;Wait .4 seconds for the mouse to move
Click ;Click the "My Actions" button 
