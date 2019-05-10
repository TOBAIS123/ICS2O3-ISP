%Erfan Yeganehfar
%Mr.Rosen
%15/12/2017
%This program creates a user interactive game, that lets the user make their own car using the pre-determined options

import GUI %Imports GUI Module

%Declaration Section
var mouseX, mouseY, button : int %Variables used in the mosewhere function;
%To find out where the users x and y mouse coordinates are and whether they pressed doen on the mouse keys
var mainWin := Window.Open ("Position:center;center,graphics:740;640") %Main window for Car Creator
var mainButton, instuctionsButton, quitButton, playGame : int := 0 %All the GUI buttons used throughtout the program;
%main menu button, instucttions button, quit button, and the play game buttn

%Set screen up
setscreen ("noecho") %Typed text does not show on the screen
setscreen ("nocursor") %Causes turing cursor to be hidden
setscreen ("nobuttonbar") %No buttonbar is set on the display window

%Program title
procedure title (programTitle : string)
    var fonttitle := Font.New ("serif:20:Bold") %Font declaration
    cls %Clears the screen
    Font.Draw (programTitle, maxx div 2 - Font.Width (programTitle, fonttitle) div 2, 600, fonttitle, 251) %Prints and centers the programTitle onto the console
end title

forward proc mainMenu
forward proc instructions
forward proc display
forward proc goodbye

process introMusic
    Music.PlayFile ("Car_Start_Sound.mp3")
end introMusic

process gameMusic
    var fonttitle := Font.New ("serif:20:Bold") %Font declaration
    Font.Draw ("Loading...", maxx div 2 - Font.Width ("Loading...", fonttitle) div 2, maxy div 2 - 10, fonttitle, 251)
    Music.PlayFile ("Wii_Sports.mp3")
end gameMusic

%Introduction
procedure introduction
    fork introMusic
    %Introduces the user to the program
    setscreen ("offscreenonly")
    title ("Car Creator") %Calls title
    for x : 0 .. 740 %Draws the ground for introduction
	drawline (0 + x, 0, 0 + x, 150, green)
    end for
    locate (5, 27)
    put "This game lets you build your own car"
    locate (6, 9)
    put "For more information or to continue just press the Main Menu button below."
    locate (7, 42)
    put "Have fun!"

    for x : 0 .. 1040 %Animates a yellow monster struck across the screen
	drawfillbox (-300 + x - 1, 150, -75 + x, 350, 0) %erase

	drawfilloval (-250 + x, 200, 50, 50, 20) %Left wheel
	drawfilloval (-75 + x, 200, 50, 50, 20) %right wheel
	drawoval (-250 + x, 200, 50, 50, 251) %Left wheel outline
	drawoval (-75 + x, 200, 50, 50, 251) %right wheel outline

	drawfilloval (-250 + x, 200, 25, 25, 29) %Left wheel frame
	drawfilloval (-75 + x, 200, 25, 25, 29) %right wheel frame
	drawoval (-250 + x, 200, 25, 25, 251) %Left wheel frame outline
	drawoval (-75 + x, 200, 25, 25, 251) %right wheel frame outline

	drawfillbox (-300 + x, 225, -25 + x, 300, 14) %Main chasis
	drawbox (-300 + x, 225, -25 + x, 300, 251) %Main chasis outline

	drawfillbox (-275 + x, 300, -100 + x, 350, 14) %Top
	drawline (-275 + x, 300, -275 + x, 350, 251) %Top outline
	drawline (-275 + x, 350, -100 + x, 350, 251) %Top outline
	drawline (-100 + x, 350, -100 + x, 300, 251) %Top outline

	drawfillbox (-255 + x, 300, -120 + x, 340, 79) %Window
	drawbox (-255 + x, 300, -120 + x, 340, 251) %Window outline

	drawline (-175 + x, 340, -175 + x, 225, 251) %Door
	drawfilloval (-40 + x, 287, 20, 10, 42) %Headlight
	drawoval (-40 + x, 287, 20, 10, 251) %Headlight outline
	delay (0)
	View.Update
    end for

    setscreen ("nooffscreenonly")
    %A GUI button that lets the user to continue to the mainMenu
    mainButton := GUI.CreateButton (320, 479, 0, "Main Menu", mainMenu) %Button that leads to mainMenu

end introduction

% Main menu of the game
body procedure mainMenu
    title ("Car Creator")
    GUI.Hide (mainButton) %Hides the mainButton so a ghost button doesnt appear
    playGame := GUI.CreateButton (319, 400, 87, "Play", display) %New game button
    instuctionsButton := GUI.CreateButton (319, 350, 0, "Instuctions", instructions) %instructions button
    quitButton := GUI.CreateButtonFull (319, 300, 88, "Quit", GUI.Quit, 0, KEY_ESC, false) %Exit button
    GUI.Show (instuctionsButton) %Shows the GUI buttons so when the main program loop re-loops back to mainMenu the buttons will show for the user
    GUI.Show (playGame)
    GUI.Show (quitButton)
end mainMenu

body proc instructions
    title ("Car Creator")
    GUI.Hide (instuctionsButton)
    GUI.Hide (playGame)
    GUI.Hide (quitButton)
    var font1 := Font.New ("Arial:11:Bold") % Initiates the variable into a new font
    var font2 := Font.New ("Arial:20:Bold") % Initiates the variable into a new font
    Font.Draw ("INSTRUCTIONS", maxx div 2 - Font.Width ("INSTRUCTIONS", font2) div 2, 550, font2, 251)
    %-----------------------------------------------------------------------------------------
    %Informs the user about the program
    put "Instructions:"
    locate (13, 10)
    put "To play press New Game in the Main Menu to start costumizing your car."
    locate (14, 3)
    put "In the game you'll have 7 main options with about 3 sub-options to create your car with,"
    locate (16, 14)
    put "for your choices to be displayed you must first choose a car model."
    locate (17, 4)
    put "When you dont want to play anymore just return to main menu using the Main Menu button."
    mainButton := GUI.CreateButton (319, 50, 0, "Main Menu", mainMenu) %Button that leads to mainMenu
end instructions

body proc display
    Music.PlayFileStop
    fork gameMusic
    title ("Car Creator")
    GUI.Hide (instuctionsButton) %Hides the 3 main menu buttons so that ghost button dont appear
    GUI.Hide (playGame)
    GUI.Hide (quitButton)
    mousewhere (mouseX, mouseY, button)
    var firstModel : boolean := true %The first car model that the user chooses is set to firstModel true, which later turns into false
    var font1 : int := Font.New ("Arial:11:Bold") %font1 declaration
    var font2 : int := Font.New ("Arial:7:Bold") %font2 declaration
    var font3 := Font.New ("serif:16:Bold") %font3 declaration
    var carModel : int := 0
    var licensePlate : int := 0
    var carBrandnum : int := 0
    var bumper : int := 1 %Stores the type of bumper the user has choosen; 1 is initiated as the default
    var exColour : int := 12 %Stores the exterior colour the user has choosen; 12 is initiated as the default colour #
    var hubCaps := 1 %Stores the type of hub cap the user has choosen; 1 is initiated as the default
    var car2Door := false %Defult car comes with one door
    var car, bumperTrue : boolean := false %User should pick a car model first before being able to choose the other options bumperTrue is to see if the user has picked a bumper
    drawfillbox (120, 120, 620, 580, 0) %Displays the users choosen choices within the box
    drawbox (120, 120, 620, 580, 251) %Displays the users choosen choices within the box
    drawline (300, 120, 300, 580, 251) %Seperates front from side view
    Font.Draw ("Front View", 160, 560, font3, 251) %Front view title
    Font.Draw ("Side View", 420, 560, font3, 251) %Side view title
    Font.Draw ("A Car Model has to be choosen first", 380, 350, font2, 251)
    Font.Draw ("for any other choice to be shown", 387, 340, font2, 251)
    %--------------------------------------------------------------------------------DISPLAY_BUTTONS------------------------------------------------------------------------------------%
    %-------------------------------------RESET--------------------------------------------%
    drawfillbox (630, 20, 730, 100, 43) %reset button
    drawbox (630, 20, 730, 100, 251) %reset button
    Font.Draw ("RESET", 655, 55, font1, 251)
    %-------------------------------------MAIN_MENU--------------------------------------------%
    drawfillbox (630, 120, 730, 200, 12) %Exit button
    drawbox (630, 120, 730, 200, 251) %Exit button
    Font.Draw ("MAIN MENU", 638, 155, font1, 251)
    %---------------------------------CAR_MODELS-------------------------------------------------%
    drawfillbox (10, 520, 110, 560, 53) %Models options
    Font.Draw ("Car Models", 20, 535, font1, 251)
    drawfillbox (10, 460, 40, 520, 29) %Models option 1
    Font.Draw ("1", 23, 485, font1, 251)
    drawfillbox (40, 460, 80, 520, 29) %Models option 2
    Font.Draw ("2", 57, 485, font1, 251)
    drawfillbox (80, 460, 110, 520, 29) %Models option 3
    Font.Draw ("3", 92, 485, font1, 251)
    drawbox (10, 520, 110, 560, 251) %Models options outline
    drawbox (10, 460, 40, 520, 251) %Models option 1 outline
    drawbox (40, 460, 80, 520, 251) %Models option 2 outline
    drawbox (80, 460, 110, 520, 251) %Models option 3 outline
    %---------------------------------EX_COLOURS--------------------------------------------------%
    drawfillbox (10, 320, 110, 360, 53) %Exterior colours options
    Font.Draw ("Exterior", 29, 344, font1, 251)
    Font.Draw ("Colours", 30, 329, font1, 251)
    drawfillbox (10, 260, 40, 320, 12) %Exterior colours option 1
    Font.Draw ("1", 23, 285, font1, 251)
    drawfillbox (40, 260, 80, 320, 76) %Exterior colours option 2
    Font.Draw ("2", 57, 285, font1, 251)
    drawfillbox (80, 260, 110, 320, 43) %Exterior colours option 3
    Font.Draw ("3", 92, 285, font1, 251)
    drawfillbox (10, 200, 40, 260, 27) %Exterior colours option 4
    Font.Draw ("4", 23, 225, font1, 251)
    drawfillbox (40, 200, 80, 260, 47) %Exterior colours option 5
    Font.Draw ("5", 57, 225, font1, 251)
    drawfillbox (80, 200, 110, 260, 54) %Exterior colours option 6
    Font.Draw ("6", 92, 225, font1, 251)
    drawbox (10, 320, 110, 360, 251) %Exterior colours options outline
    drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
    drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
    drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
    drawbox (10, 200, 40, 260, 251) %Exterior colours option 4 outline
    drawbox (40, 200, 80, 260, 251) %Exterior colours option 5 outline
    drawbox (80, 200, 110, 260, 251) %Exterior colours option 6 outline
    %------------------------------------#_OF_DOORS-------------------------------------------------%
    drawfillbox (630, 520, 730, 560, 53)   %# of doors options
    Font.Draw ("# of", 658, 545, font1, 251)
    Font.Draw ("Doors", 659, 530, font1, 251)
    drawfillbox (630, 460, 680, 520, 29) %# of doors option 1
    Font.Draw ("1", 650, 485, font1, 251)
    drawfillbox (680, 460, 730, 520, 29) %# of doors option 2
    Font.Draw ("2", 700, 485, font1, 251)
    drawbox (630, 520, 730, 560, 251) %# of doors options outline
    drawbox (630, 460, 680, 520, 251) %# of doors option 1 outline
    drawbox (680, 460, 730, 520, 251) %# of doors option 2 outline
    %---------------------------------LICENSE_PLATE------------------------------------------------%
    drawfillbox (630, 320, 730, 360, 53) %License plate options
    Font.Draw ("License", 652, 344, font1, 251)
    Font.Draw ("Plate", 662, 329, font1, 251)
    drawfillbox (630, 260, 660, 320, 29) %License plate option 1
    Font.Draw ("1", 643, 285, font1, 251)
    drawfillbox (660, 260, 700, 320, 29) %License plate option 2
    Font.Draw ("2", 677, 285, font1, 251)
    drawfillbox (700, 260, 730, 320, 29) %License plate option 3
    Font.Draw ("3", 713, 285, font1, 251)
    drawbox (630, 320, 730, 360, 251) %License plate options outline
    drawbox (630, 260, 660, 320, 251) %License plate option 1 outline
    drawbox (660, 260, 700, 320, 251) %License plate option 2 outline
    drawbox (700, 260, 730, 320, 251) %License plate option 3 outline
    %-----------------------------------CAR_MAKES------------------------------------------------%
    drawfillbox (120, 70, 220, 110, 53) %Car brands plate options
    Font.Draw ("Car Brands", 130, 85, font1, 251)
    drawfillbox (120, 10, 150, 70, 29) %Car brands plate option 1
    Font.Draw ("1", 130, 35, font1, 251)
    drawfillbox (150, 10, 190, 70, 29) %Car brands plate option 2
    Font.Draw ("2", 167, 35, font1, 251)
    drawfillbox (190, 10, 220, 70, 29) %Car brands plate option 3
    Font.Draw ("3", 200, 35, font1, 251)
    drawbox (120, 70, 220, 110, 251) %Car brands plate options outline
    drawbox (120, 10, 150, 70, 251) %Car brands plate option 1 outline
    drawbox (150, 10, 190, 70, 251) %Car brands plate option 2 outline
    drawbox (190, 10, 220, 70, 251) %Car brands plate option 3 outline
    %---------------------------------BUMPERS--------------------------------------------------%
    drawfillbox (320, 70, 420, 110, 53) %Bumper styles plate options
    Font.Draw ("Bumper", 342, 95, font1, 251)
    Font.Draw ("Styles", 347, 80, font1, 251)
    drawfillbox (320, 10, 350, 70, 29) %Bumper styles plate option 1
    Font.Draw ("1", 330, 35, font1, 251)
    drawfillbox (350, 10, 390, 70, 29) %Bumper styles plate option 2
    Font.Draw ("2", 367, 35, font1, 251)
    drawfillbox (390, 10, 420, 70, 29) %Bumper styles plate option 3
    Font.Draw ("3", 403, 35, font1, 251)
    drawbox (320, 70, 420, 110, 251) %Bumper styles plate options outline
    drawbox (320, 10, 350, 70, 251) %Bumper styles plate option 1 outline
    drawbox (350, 10, 390, 70, 251) %Bumper styles plate option 2 outline
    drawbox (390, 10, 420, 70, 251) %Bumper styles plate option 3 outline
    %----------------------------------HUB_CAPS-------------------------------------------------%
    drawfillbox (520, 70, 620, 110, 53) %Hub caps plate options
    Font.Draw ("Hub Caps", 535, 85, font1, 251)
    drawfillbox (520, 10, 550, 70, 29) %Hub caps plate option 1
    Font.Draw ("1", 530, 35, font1, 251)
    drawfillbox (550, 10, 590, 70, 29) %Hub caps plate option 2
    Font.Draw ("2", 565, 35, font1, 251)
    drawfillbox (590, 10, 620, 70, 29) %Hub caps plate option 3
    Font.Draw ("3", 602, 35, font1, 251)
    drawbox (520, 70, 620, 110, 251) %Hub caps plate options outline
    drawbox (520, 10, 550, 70, 251) %Hub caps plate option 1 outline
    drawbox (550, 10, 590, 70, 251) %Hub caps plate option 2 outline
    drawbox (590, 10, 620, 70, 251) %Hub caps plate option 3 outline

    %------------------------------------------------------------------------MOUSEWHERE_BUTTON_COMMANDS----------------------------------------------------------------%
    setscreen ("offscreenonly")
    loop
	mousewhere (mouseX, mouseY, button)
	if button = 1 then
	    %-------------------------------------------------------EX_COLOUR--------------------------------------------------------------%
	    if (mouseX >= 10 and mouseX <= 40) and (mouseY >= 260 and mouseY <= 320) and car = true then   %Colour 1
		if exColour = 76 then %Indent erase
		    drawfillbox (40, 260, 80, 320, 76) %Exterior colours option 2
		    drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
		    Font.Draw ("2", 57, 285, font1, 251)
		elsif exColour = 43 then %Indent erase
		    drawfillbox (80, 260, 110, 320, 43) %Exterior colours option 3
		    drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
		    Font.Draw ("3", 92, 285, font1, 251)
		elsif exColour = 27 then %Indent erase
		    drawfillbox (10, 200, 40, 260, 27) %Exterior colours option 4
		    drawbox (10, 200, 40, 260, 251) %Exterior colours option 4 outline
		    Font.Draw ("4", 23, 225, font1, 251)
		elsif exColour = 47 then %Indent erase
		    drawfillbox (40, 200, 80, 260, 47) %Exterior colours option 5
		    drawbox (40, 200, 80, 260, 251) %Exterior colours option 5 outline
		    Font.Draw ("5", 57, 225, font1, 251)
		elsif exColour = 54 then %Indent erase
		    drawfillbox (80, 200, 110, 260, 54) %Exterior colours option 6
		    drawbox (80, 200, 110, 260, 251) %Exterior colours option 6 outline
		    Font.Draw ("6", 92, 225, font1, 251)
		end if

		drawfillbox (10, 260, 40, 320, 4) %Exterior colours option 1 indent
		drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
		Font.Draw ("1", 23, 285, font1, 251)

		exColour := 12
		drawfill (530, 320, exColour, 251) %Colours the side veiw of the car
		drawfill (210, 331, exColour, 251) %Colours the front veiw of the car
		if carModel = 3 then %Updates the back colour of the model 3 car
		    drawfill (370, 300, exColour, 251)
		end if
		if hubCaps = 2 or hubCaps = 3 then %Updates the colour of the hub caps of choices 2 or 3
		    drawfill (410, 280, exColour, 251)
		    drawfill (530, 280, exColour, 251)
		end if

	    elsif (mouseX >= 40 and mouseX <= 80) and (mouseY >= 260 and mouseY <= 320) and car = true then %Colour 2
		if exColour = 12 then %Indent erase
		    drawfillbox (10, 260, 40, 320, 12) %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		elsif exColour = 43 then %Indent erase
		    drawfillbox (80, 260, 110, 320, 43) %Exterior colours option 3
		    drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
		    Font.Draw ("3", 92, 285, font1, 251)
		elsif exColour = 27 then %Indent erase
		    drawfillbox (10, 200, 40, 260, 27) %Exterior colours option 4
		    drawbox (10, 200, 40, 260, 251) %Exterior colours option 4 outline
		    Font.Draw ("4", 23, 225, font1, 251)
		elsif exColour = 47 then  %Indent erase
		    drawfillbox (40, 200, 80, 260, 47) %Exterior colours option 5
		    drawbox (40, 200, 80, 260, 251) %Exterior colours option 5 outline
		    Font.Draw ("5", 57, 225, font1, 251)
		elsif exColour = 54 then %Indent erase
		    drawfillbox (80, 200, 110, 260, 54) %Exterior colours option 6
		    drawbox (80, 200, 110, 260, 251) %Exterior colours option 6 outline
		    Font.Draw ("6", 92, 225, font1, 251)
		end if

		drawfillbox (40, 260, 80, 320, 148) %Exterior colours option 2 indent
		drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
		Font.Draw ("2", 57, 285, font1, 251)

		exColour := 76
		drawfill (530, 320, exColour, 251) %Colours the side veiw of the car
		drawfill (210, 331, exColour, 251) %Colours the front veiw of the car
		if carModel = 3 then %Updates the back colour of the model 3 car
		    drawfill (370, 300, exColour, 251)
		end if
		if hubCaps = 2 or hubCaps = 3 then %Updates the colour of the hub caps of choices 2 or 3
		    drawfill (410, 280, exColour, 251)
		    drawfill (530, 280, exColour, 251)
		end if

	    elsif (mouseX >= 80 and mouseX <= 110) and (mouseY >= 260 and mouseY <= 320) and car = true then %Colour 3
		if exColour = 76 then %Indent erase
		    drawfillbox (40, 260, 80, 320, 76) %Exterior colours option 2
		    drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
		    Font.Draw ("2", 57, 285, font1, 251)
		elsif exColour = 12 then %Indent erase
		    drawfillbox (10, 260, 40, 320, 12) %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		elsif exColour = 27 then %Indent erase
		    drawfillbox (10, 200, 40, 260, 27) %Exterior colours option 4
		    drawbox (10, 200, 40, 260, 251) %Exterior colours option 4 outline
		    Font.Draw ("4", 23, 225, font1, 251)
		elsif exColour = 47 then  %Indent erase
		    drawfillbox (40, 200, 80, 260, 47) %Exterior colours option 5
		    drawbox (40, 200, 80, 260, 251) %Exterior colours option 5 outline
		    Font.Draw ("5", 57, 225, font1, 251)
		elsif exColour = 54 then %Indent erase
		    drawfillbox (80, 200, 110, 260, 54) %Exterior colours option 6
		    drawbox (80, 200, 110, 260, 251) %Exterior colours option 6 outline
		    Font.Draw ("6", 92, 225, font1, 251)
		end if

		drawfillbox (80, 260, 110, 320, 114) %Exterior colours option 3 indent
		drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
		Font.Draw ("3", 92, 285, font1, 251)

		exColour := 43
		drawfill (530, 320, exColour, 251) %Colours the side veiw of the car
		drawfill (210, 331, exColour, 251) %Colours the front veiw of the car
		if carModel = 3 then %Updates the back colour of the model 3 car
		    drawfill (370, 300, exColour, 251)
		end if
		if hubCaps = 2 or hubCaps = 3 then %Updates the colour of the hub caps of choices 2 or 3
		    drawfill (410, 280, exColour, 251)
		    drawfill (530, 280, exColour, 251)
		end if
	    elsif (mouseX >= 10 and mouseX <= 40) and (mouseY >= 200 and mouseY <= 260) and car = true then %Colour 4
		if exColour = 76 then %Indent erase
		    drawfillbox (40, 260, 80, 320, 76) %Exterior colours option 2
		    drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
		    Font.Draw ("2", 57, 285, font1, 251)
		elsif exColour = 12 then %Indent erase
		    drawfillbox (10, 260, 40, 320, 12) %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		elsif exColour = 43 then %Indent erase
		    drawfillbox (80, 260, 110, 320, 43) %Exterior colours option 3
		    drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
		    Font.Draw ("3", 92, 285, font1, 251)
		elsif exColour = 47 then  %Indent erase
		    drawfillbox (40, 200, 80, 260, 47) %Exterior colours option 5
		    drawbox (40, 200, 80, 260, 251) %Exterior colours option 5 outline
		    Font.Draw ("5", 57, 225, font1, 251)
		elsif exColour = 54 then %Indent erase
		    drawfillbox (80, 200, 110, 260, 54) %Exterior colours option 6
		    drawbox (80, 200, 110, 260, 251) %Exterior colours option 6 outline
		    Font.Draw ("6", 92, 225, font1, 251)
		end if

		drawfillbox (10, 200, 40, 260, 21) %Exterior colours option 1 indent
		drawbox (10, 200, 40, 260, 251) %Exterior colours option 1 outline
		Font.Draw ("4", 23, 225, font1, 251)

		exColour := 27
		drawfill (530, 320, exColour, 251) %Colours the side veiw of the car
		drawfill (210, 331, exColour, 251) %Colours the front veiw of the car
		if carModel = 3 then %Updates the back colour of the model 3 car
		    drawfill (370, 300, exColour, 251)
		end if
		if hubCaps = 2 or hubCaps = 3 then %Updates the colour of the hub caps of choices 2 or 3
		    drawfill (410, 280, exColour, 251)
		    drawfill (530, 280, exColour, 251)
		end if
	    elsif (mouseX >= 40 and mouseX <= 80) and (mouseY >= 200 and mouseY <= 260) and car = true then %Colour 5
		if exColour = 12 then %Indent erase
		    drawfillbox (10, 260, 40, 320, 12) %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		elsif exColour = 76 then %Indent erase
		    drawfillbox (40, 260, 80, 320, 76) %Exterior colours option 2
		    drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
		    Font.Draw ("2", 57, 285, font1, 251)
		elsif exColour = 43 then %Indent erase
		    drawfillbox (80, 260, 110, 320, 43) %Exterior colours option 3
		    drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
		    Font.Draw ("3", 92, 285, font1, 251)
		elsif exColour = 27 then %Indent erase
		    drawfillbox (10, 200, 40, 260, 27) %Exterior colours option 4
		    drawbox (10, 200, 40, 260, 251) %Exterior colours option 4 outline
		    Font.Draw ("4", 23, 225, font1, 251)
		elsif exColour = 54 then %Indent erase
		    drawfillbox (80, 200, 110, 260, 54) %Exterior colours option 6
		    drawbox (80, 200, 110, 260, 251) %Exterior colours option 6 outline
		    Font.Draw ("6", 92, 225, font1, 251)
		end if

		drawfillbox (40, 200, 80, 260, 119) %Exterior colours option 2 indent
		drawbox (40, 200, 80, 260, 251) %Exterior colours option 2 outline
		Font.Draw ("5", 57, 225, font1, 251)

		exColour := 47
		drawfill (530, 320, exColour, 251) %Colours the side veiw of the car
		drawfill (210, 331, exColour, 251) %Colours the front veiw of the car
		if carModel = 3 then %Updates the back colour of the model 3 car
		    drawfill (370, 300, exColour, 251)
		end if
		if hubCaps = 2 or hubCaps = 3 then %Updates the colour of the hub caps of choices 2 or 3
		    drawfill (410, 280, exColour, 251)
		    drawfill (530, 280, exColour, 251)
		end if
	    elsif (mouseX >= 80 and mouseX <= 110) and (mouseY >= 200 and mouseY <= 260) and car = true then %Colour 6
		if exColour = 12 then %Indent erase
		    drawfillbox (10, 260, 40, 320, 12) %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		elsif exColour = 76 then %Indent erase
		    drawfillbox (40, 260, 80, 320, 76) %Exterior colours option 2
		    drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
		    Font.Draw ("2", 57, 285, font1, 251)
		elsif exColour = 43 then %Indent erase
		    drawfillbox (80, 260, 110, 320, 43) %Exterior colours option 3
		    drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
		    Font.Draw ("3", 92, 285, font1, 251)
		elsif exColour = 27 then %Indent erase
		    drawfillbox (10, 200, 40, 260, 27) %Exterior colours option 4
		    drawbox (10, 200, 40, 260, 251) %Exterior colours option 4 outline
		    Font.Draw ("4", 23, 225, font1, 251)
		elsif exColour = 47 then  %Indent erase
		    drawfillbox (40, 200, 80, 260, 47) %Exterior colours option 5
		    drawbox (40, 200, 80, 260, 251) %Exterior colours option 5 outline
		    Font.Draw ("5", 57, 225, font1, 251)
		end if

		drawfillbox (80, 200, 110, 260, 125) %Exterior colours option 3 indent
		drawbox (80, 200, 110, 260, 251) %Exterior colours option 3 outline
		Font.Draw ("6", 92, 225, font1, 251)

		exColour := 54
		drawfill (530, 320, exColour, 251) %Colours the side veiw of the car
		drawfill (210, 331, exColour, 251) %Colours the front veiw of the car
		if carModel = 3 then %Updates the back colour of the model 3 car
		    drawfill (370, 300, exColour, 251)
		end if
		if hubCaps = 2 or hubCaps = 3 then %Updates the colour of the hub caps of choices 2 or 3
		    drawfill (410, 280, exColour, 251)
		    drawfill (530, 280, exColour, 251)
		end if
		%---------------------------------------------------------------CAR_BRANDS----------------------------------------------------%
	    elsif (mouseX >= 120 and mouseX <= 150) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Car Brand 1
		if carBrandnum = 2 then     %Indent erase
		    drawfillbox (150, 10, 190, 70, 29)     %Car brands plate option 2
		    drawbox (150, 10, 190, 70, 251)     %Car brands plate option 2 outline
		    Font.Draw ("2", 167, 35, font1, 251)
		elsif carBrandnum = 3 then     %Indent erase
		    drawfillbox (190, 10, 220, 70, 29)     %Car brands plate option 3
		    drawbox (190, 10, 220, 70, 251)     %Car brands plate option 3 outline
		    Font.Draw ("3", 200, 35, font1, 251)
		end if
		drawfillbox (120, 10, 150, 70, 22)     %Car brands plate option 1 indent
		drawbox (120, 10, 150, 70, 251)     %Car brands plate option 1 outline
		Font.Draw ("1", 130, 35, font1, 251)

		carBrandnum := 1
		drawfillbox (200, 290, 220, 310, 20)     %erase
		drawfilloval (210, 300, 10, 10, 251)     %Car Brand 1
		drawfillarc (210, 300, 7, 7, 0, 90, 53)     %Top right
		drawfillarc (210, 300, 7, 7, 90, 180, 0)     %Top left
		drawfillarc (210, 300, 7, 7, 180, 270, 53)     %Down left
		drawfillarc (210, 300, 7, 7, 270, 360, 0)     %Down right
	    elsif (mouseX >= 150 and mouseX <= 190) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Car Brand 2
		if carBrandnum = 1 then     %Indent erase
		    drawfillbox (120, 10, 150, 70, 29)     %Car brands plate option 1
		    drawbox (120, 10, 150, 70, 251)     %Car brands plate option 1 outline
		    Font.Draw ("1", 130, 35, font1, 251)
		elsif carBrandnum = 3 then     %Indent erase
		    drawfillbox (190, 10, 220, 70, 29)     %Car brands plate option 3
		    drawbox (190, 10, 220, 70, 251)     %Car brands plate option 3 outline
		    Font.Draw ("3", 200, 35, font1, 251)
		end if
		drawfillbox (150, 10, 190, 70, 22)     %Car brands plate option 2 indent
		drawbox (150, 10, 190, 70, 251)     %Car brands plate option 2 outline
		Font.Draw ("2", 167, 35, font1, 251)

		carBrandnum := 2
		drawfillbox (200, 290, 220, 310, 20)     %erase
		drawoval (210, 300, 10, 10, 29)     %Car Brand 2
		drawline (209, 300, 210, 310, 29)     %Mercedes Benz logo
		drawline (210, 310, 211, 300, 29)
		drawline (210, 300, 210, 310, 29)
		drawline (211, 300, 218, 297, 29)
		drawline (218, 297, 210, 299, 29)
		drawline (210, 299, 200, 297, 29)
		drawline (200, 297, 209, 300, 29)
	    elsif (mouseX >= 190 and mouseX <= 220) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Car Brand 3
		if carBrandnum = 1 then     %Indent erase
		    drawfillbox (120, 10, 150, 70, 29)     %Car brands plate option 1
		    drawbox (120, 10, 150, 70, 251)     %Car brands plate option 1 outline
		    Font.Draw ("1", 130, 35, font1, 251)
		elsif carBrandnum = 2 then     %Indent erase
		    drawfillbox (150, 10, 190, 70, 29)     %Car brands plate option 2
		    drawbox (150, 10, 190, 70, 251)     %Car brands plate option 2 outline
		    Font.Draw ("2", 167, 35, font1, 251)
		end if
		drawfillbox (190, 10, 220, 70, 22)     %Car brands plate option 3 indent
		drawbox (190, 10, 220, 70, 251)     %Car brands plate option 3 outline
		Font.Draw ("3", 200, 35, font1, 251)

		carBrandnum := 3
		drawfillbox (200, 290, 220, 310, 20)     %erase
		drawoval (210, 300, 10, 8, 29)     %Car Brand 3
		drawoval (210, 300, 4, 7, 29)     %Middle oval
		drawoval (210, 304, 10, 3, 29)     %Top oval
		%---------------------------------------------------------------#_OF_DOORS-------------------------------------------------%
	    elsif (mouseX >= 630 and mouseX <= 680) and (mouseY >= 460 and mouseY <= 520) and car = true then     %1 Door
		drawfillbox (680, 460, 730, 520, 29)     %# of doors option 2 indent erase
		drawbox (680, 460, 730, 520, 251)     %# of doors option 2 outline
		Font.Draw ("2", 700, 485, font1, 251)

		drawfillbox (630, 460, 680, 520, 22)     %# of doors option 1 indent
		drawbox (630, 460, 680, 520, 251)     %# of doors option 1 outline
		Font.Draw ("1", 650, 485, font1, 251)
		car2Door := false
		if carModel = 1| carModel = 2 then     %According to the car model the 2nd door is erased
		    drawline (380, 281, 380, 339, exColour)     %2nd door erase
		    drawfillbox (390, 315, 410, 330, exColour)     %2nd door handle erase
		elsif carModel = 3 then
		    drawline (400, 298, 400, 339, exColour)     %2nd door erase
		    drawfillbox (410, 315, 430, 330, exColour)     %2nd door handle erase
		end if
	    elsif (mouseX >= 680 and mouseX <= 730) and (mouseY >= 460 and mouseY <= 520) and car = true then     %2 Doors
		drawfillbox (630, 460, 680, 520, 29)     %# of doors option 1 indent erase
		drawbox (630, 460, 680, 520, 251)     %# of doors option 1 outline
		Font.Draw ("1", 650, 485, font1, 251)

		drawfillbox (680, 460, 730, 520, 22)     %# of doors option 2 indent
		drawbox (680, 460, 730, 520, 251)     %# of doors option 2 outline
		Font.Draw ("2", 700, 485, font1, 251)
		car2Door := true
		if carModel = 1| carModel = 2 then     %According to the car model a 2nd door is drawn
		    drawline (380, 281, 380, 339, 249)     %2nd door
		    drawfillbox (390, 315, 410, 330, 249)     %2nd door handle
		elsif carModel = 3 then
		    drawline (400, 298, 400, 339, 249)     %2nd door
		    drawfillbox (410, 315, 430, 330, 249)     %2nd door handle
		end if
		%--------------------------------------------------------LICENSE_PLATE----------------------------------------------------%
	    elsif (mouseX >= 630 and mouseX <= 660) and (mouseY >= 260 and mouseY <= 320) and car = true then     %License plate 1
		if licensePlate = 2 then     %indent erase
		    drawfillbox (660, 260, 700, 320, 29)     %License plate option 2
		    drawbox (660, 260, 700, 320, 251)     %License plate option 2 outline
		    Font.Draw ("2", 677, 285, font1, 251)
		elsif licensePlate = 3 then     %indent erase
		    drawfillbox (700, 260, 730, 320, 29)     %License plate option 3
		    drawbox (700, 260, 730, 320, 251)     %License plate option 3 outline
		    Font.Draw ("3", 713, 285, font1, 251)
		end if
		drawfillbox (630, 260, 660, 320, 22)     %License plate option 1 indent
		drawbox (630, 260, 660, 320, 251)     %License plate option 1 outline
		Font.Draw ("1", 643, 285, font1, 251)

		licensePlate := 1
		drawfillbox (190, 240, 230, 257, 0)     %License plate erase
		drawbox (190, 240, 230, 257, 251)     %License plate outline
		Font.Draw ("2CUL4U", 192, 245, font2, 251)

	    elsif (mouseX >= 660 and mouseX <= 700) and (mouseY >= 260 and mouseY <= 320) and car = true then     %License plate 2
		if licensePlate = 1 then     %indent erase
		    drawfillbox (630, 260, 660, 320, 29)     %License plate option 1
		    drawbox (630, 260, 660, 320, 251)     %License plate option 1 outline
		    Font.Draw ("1", 643, 285, font1, 251)
		elsif licensePlate = 3 then     %indent erase
		    drawfillbox (700, 260, 730, 320, 29)     %License plate option 3
		    drawbox (700, 260, 730, 320, 251)     %License plate option 3 outline
		    Font.Draw ("3", 713, 285, font1, 251)
		end if
		drawfillbox (660, 260, 700, 320, 22)     %License plate option 2 indent
		drawbox (660, 260, 700, 320, 251)     %License plate option 2 outline
		Font.Draw ("2", 677, 285, font1, 251)

		licensePlate := 2
		drawfillbox (190, 240, 230, 257, 0)     %License plate erase
		drawbox (190, 240, 230, 257, 251)     %License plate outline
		Font.Draw ("3R2ANS", 192, 245, font2, 251)

	    elsif (mouseX >= 700 and mouseX <= 730) and (mouseY >= 260 and mouseY <= 320) and car = true then     %License plate 3
		if licensePlate = 2 then     %indent erase
		    drawfillbox (660, 260, 700, 320, 29)     %License plate option 2
		    drawbox (660, 260, 700, 320, 251)     %License plate option 2 outline
		    Font.Draw ("2", 677, 285, font1, 251)
		elsif licensePlate = 1 then     %indent erase
		    drawfillbox (630, 260, 660, 320, 29)     %License plate option 1
		    drawbox (630, 260, 660, 320, 251)     %License plate option 1 outline
		    Font.Draw ("1", 643, 285, font1, 251)
		end if
		drawfillbox (700, 260, 730, 320, 22)     %License plate option 3 indent
		drawbox (700, 260, 730, 320, 251)     %License plate option 3 outline
		Font.Draw ("3", 713, 285, font1, 251)

		licensePlate := 3
		drawfillbox (190, 240, 230, 257, 0)     %License plate erase
		drawbox (190, 240, 230, 257, 251)     %License plate outline
		Font.Draw ("M8WHAT", 192, 245, font2, 251)

		%---------------------------------------------------------------BUMPERS----------------------------------------------------%
	    elsif (mouseX >= 320 and mouseX <= 350) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Bumper 1
		if bumper = 2 then     %indent erase
		    drawfillbox (350, 10, 390, 70, 29)     %Bumper styles plate option 2
		    drawbox (350, 10, 390, 70, 251)     %Bumper styles plate option 2 outline
		    Font.Draw ("2", 367, 35, font1, 251)
		elsif bumper = 3 then     %indent erase
		    drawfillbox (390, 10, 420, 70, 29)     %Bumper styles plate option 3
		    drawbox (390, 10, 420, 70, 251)     %Bumper styles plate option 3 outline
		    Font.Draw ("3", 403, 35, font1, 251)
		end if
		drawfillbox (320, 10, 350, 70, 22)     %Bumper styles plate option 1 indent
		drawbox (320, 10, 350, 70, 251)     %Bumper styles plate option 1 outline
		Font.Draw ("1", 330, 35, font1, 251)

		bumper := 1
		bumperTrue := true
		drawbox (130, 220, 290, 260, 31)     %Erase the bumper underneath
		drawbox (189, 239, 231, 258, 31)
		drawfill (210, 237, 0, 31)     %Fills the margins with white to erase

		drawfillbox (550, 260, 600, 279, 0)     %Side view bumper erase
		drawfillbox (581, 280, 600, 290, 0)

		drawfillbox (140, 220, 160, 260, 251)     %Left wheel
		drawfillbox (260, 220, 280, 260, 251)     %Right wheel
		drawfillbox (130, 235, 290, 260, 29)     %Front view bumper
		drawbox (130, 235, 290, 260, 251)     %Front view bumper outline
		drawfillbox (190, 240, 230, 257, 0)     %License plate
		drawbox (190, 240, 230, 257, 251)     %License plate outline

		drawline (550, 280, 580, 280, 251)     %Side view bumper outline
		drawline (580, 270, 550, 280, 251)
		drawbox (580, 270, 590, 287, 251)
		drawline (580, 279, 580, 271, 29)
		drawfill (570, 279, 29, 251)     %Fills in side view

		if licensePlate = 1 then     %Redraws the license plate if chosen
		    Font.Draw ("2CUL4U", 192, 245, font2, 251)
		elsif licensePlate = 2 then
		    Font.Draw ("3R2ANS", 192, 245, font2, 251)
		elsif licensePlate = 3 then
		    Font.Draw ("M8WHAT", 192, 245, font2, 251)
		end if
	    elsif (mouseX >= 350 and mouseX <= 390) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Bumper 2
		if bumper = 1 then     %indent erase
		    drawfillbox (320, 10, 350, 70, 29)     %Bumper styles plate option 1
		    drawbox (320, 10, 350, 70, 251)     %Bumper styles plate option 1 outline
		    Font.Draw ("1", 330, 35, font1, 251)
		elsif bumper = 3 then     %indent erase
		    drawfillbox (390, 10, 420, 70, 29)     %Bumper styles plate option 3
		    drawbox (390, 10, 420, 70, 251)     %Bumper styles plate option 3 outline
		    Font.Draw ("3", 403, 35, font1, 251)
		end if
		drawfillbox (350, 10, 390, 70, 22)     %Bumper styles plate option 2 indent
		drawbox (350, 10, 390, 70, 251)     %Bumper styles plate option 2 outline
		Font.Draw ("2", 367, 35, font1, 251)

		bumper := 2
		bumperTrue := true
		drawbox (130, 220, 290, 260, 31)     %Erase the bumper underneath
		drawbox (189, 239, 231, 258, 31)
		drawfill (210, 237, 0, 31)     %Fills the margins with white to erase

		drawfillbox (550, 260, 600, 279, 0)     %Side view bumper erase
		drawfillbox (581, 280, 600, 290, 0)

		drawfillbox (140, 220, 160, 260, 251)     %Left wheel
		drawfillbox (260, 220, 280, 260, 251)     %Right wheel
		drawfillarc (210, 260, 80, 30, 180, 360, 29)     %Bumper
		drawarc (210, 260, 80, 30, 180, 360, 251)     %Bumper outline
		drawline (130, 260, 290, 260, 251)
		drawfillbox (190, 240, 230, 257, 0)     %License plate
		drawbox (190, 240, 230, 257, 251)     %License plate outline

		drawline (550, 280, 580, 280, 251)
		drawline (580, 270, 550, 280, 251)
		drawarc (580, 280, 10, 10, 270, 45, 251)     %Side view bumper
		drawline (580, 287, 587, 287, 251)
		drawfill (580, 279, 29, 251)


		if licensePlate = 1 then     %Redraws the license plate if chosen
		    Font.Draw ("2CUL4U", 192, 245, font2, 251)
		elsif licensePlate = 2 then
		    Font.Draw ("3R2ANS", 192, 245, font2, 251)
		elsif licensePlate = 3 then
		    Font.Draw ("M8WHAT", 192, 245, font2, 251)
		end if
	    elsif (mouseX >= 390 and mouseX <= 420) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Bumper 3
		if bumper = 1 then             %indent erase
		    drawfillbox (320, 10, 350, 70, 29)     %Bumper styles plate option 1
		    drawbox (320, 10, 350, 70, 251)     %Bumper styles plate option 1 outline
		    Font.Draw ("1", 330, 35, font1, 251)
		elsif bumper = 2 then     %indent erase
		    drawfillbox (350, 10, 390, 70, 29)     %Bumper styles plate option 2
		    drawbox (350, 10, 390, 70, 251)     %Bumper styles plate option 2 outline
		    Font.Draw ("2", 367, 35, font1, 251)
		end if
		drawfillbox (390, 10, 420, 70, 22)     %Bumper styles plate option 3 indent
		drawbox (390, 10, 420, 70, 251)     %Bumper styles plate option 3 outline
		Font.Draw ("3", 403, 35, font1, 251)

		bumper := 3
		bumperTrue := true
		drawbox (130, 220, 290, 260, 31)     %Erase the bumper underneath
		drawbox (189, 239, 231, 258, 31)
		drawfill (210, 237, 0, 31)     %Fills the margins with white to erase

		drawfillbox (550, 260, 600, 279, 0)     %Side view bumper erase
		drawfillbox (581, 280, 600, 290, 0)

		drawfillbox (140, 220, 160, 260, 251)     %Front left wheel
		drawfillbox (260, 220, 280, 260, 251)     %Front right wheel
		drawfillbox (130, 230, 180, 260, 29)     %Front view bumper
		drawfillbox (180, 235, 240, 260, 29)
		drawfillbox (240, 230, 290, 260, 29)
		drawline (130, 260, 130, 230, 251)     %Front view bumper outlines
		drawline (130, 230, 180, 230, 251)
		drawline (180, 230, 180, 235, 251)
		drawline (180, 235, 240, 235, 251)
		drawline (240, 235, 240, 230, 251)
		drawline (240, 230, 290, 230, 251)
		drawline (290, 230, 290, 260, 251)
		drawline (290, 260, 130, 260, 251)
		drawfillbox (190, 240, 230, 257, 0)     %License plate
		drawbox (190, 240, 230, 257, 251)     %License plate outline

		drawline (550, 280, 570, 270, 251)     %Side view bumper
		drawline (570, 270, 590, 270, 251)
		drawline (590, 270, 590, 280, 251)
		drawline (590, 280, 550, 280, 251)
		drawfill (580, 279, 29, 251)

		if licensePlate = 1 then     %Redraws the license plate if chosen
		    Font.Draw ("2CUL4U", 192, 245, font2, 251)
		elsif licensePlate = 2 then
		    Font.Draw ("3R2ANS", 192, 245, font2, 251)
		elsif licensePlate = 3 then
		    Font.Draw ("M8WHAT", 192, 245, font2, 251)
		end if
		%------------------------------------------------------------HUB_CAPS------------------------------------------------------%
	    elsif (mouseX >= 520 and mouseX <= 550) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Hub cap 1
		if hubCaps = 2 then     %indent erase
		    drawfillbox (550, 10, 590, 70, 29)     %Hub caps plate option 2
		    drawbox (550, 10, 590, 70, 251)     %Hub caps plate option 2 outline
		    Font.Draw ("2", 565, 35, font1, 251)
		elsif hubCaps = 3 then     %indent erase
		    drawfillbox (590, 10, 620, 70, 29)     %Hub caps plate option 3
		    drawbox (590, 10, 620, 70, 251)     %Hub caps plate option 3 outline
		    Font.Draw ("3", 602, 35, font1, 251)
		end if
		drawfillbox (520, 10, 550, 70, 22)     %Hub caps plate option 1 indent
		drawbox (520, 10, 550, 70, 251)     %Hub caps plate option 1 outline
		Font.Draw ("1", 530, 35, font1, 251)

		hubCaps := 1
		drawfilloval (410, 280, 17, 17, 251)     %Left tire
		drawfilloval (410, 280, 13, 13, 27)     %Left hub cap
		drawfilloval (530, 280, 17, 17, 251)     %Right tire
		drawfilloval (530, 280, 13, 13, 27)     %Right hub cap
	    elsif (mouseX >= 550 and mouseX <= 590) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Hub cap 2
		if hubCaps = 1 then     %indent erase
		    drawfillbox (520, 10, 550, 70, 29)     %Hub caps plate option 1
		    drawbox (520, 10, 550, 70, 251)     %Hub caps plate option 1 outline
		    Font.Draw ("1", 530, 35, font1, 251)
		elsif hubCaps = 3 then     %indent erase
		    drawfillbox (590, 10, 620, 70, 29)     %Hub caps plate option 3
		    drawbox (590, 10, 620, 70, 251)     %Hub caps plate option 3 outline
		    Font.Draw ("3", 602, 35, font1, 251)
		end if
		drawfillbox (550, 10, 590, 70, 22)     %Hub caps plate option 2 indent
		drawbox (550, 10, 590, 70, 251)     %Hub caps plate option 2 outline
		Font.Draw ("2", 565, 35, font1, 251)

		hubCaps := 2
		drawfilloval (410, 280, 17, 17, 251)     %Left tire
		drawfilloval (410, 280, 13, 13, 27)     %Left hub cap
		drawoval (410, 280, 4, 4, 251)     %Details of the left hub cap
		drawoval (410, 280, 8, 8, 251)
		drawoval (410, 280, 10, 10, 251)
		drawfill (410, 280, exColour, 251)
		drawfilloval (530, 280, 17, 17, 251)     %Right tire
		drawfilloval (530, 280, 13, 13, 27)     %Right hub cap
		drawoval (530, 280, 4, 4, 251)
		drawoval (530, 280, 8, 8, 251)
		drawoval (530, 280, 10, 10, 251)
		drawfill (530, 280, exColour, 251)     %Details of the right hub cap
	    elsif (mouseX >= 590 and mouseX <= 620) and (mouseY >= 10 and mouseY <= 70) and car = true then     %Hub cap 3
		if hubCaps = 1 then     %indent erase
		    drawfillbox (520, 10, 550, 70, 29)     %Hub caps plate option 1
		    drawbox (520, 10, 550, 70, 251)     %Hub caps plate option 1 outline
		    Font.Draw ("1", 530, 35, font1, 251)
		elsif hubCaps = 2 then     %indent erase
		    drawfillbox (550, 10, 590, 70, 29)     %Hub caps plate option 2
		    drawbox (550, 10, 590, 70, 251)     %Hub caps plate option 2 outline
		    Font.Draw ("2", 565, 35, font1, 251)
		end if
		drawfillbox (590, 10, 620, 70, 22)     %Hub caps plate option 3 indent
		drawbox (590, 10, 620, 70, 251)     %Hub caps plate option 3 outline
		Font.Draw ("3", 602, 35, font1, 251)

		hubCaps := 3
		drawfilloval (410, 280, 17, 17, 251)     %Left tire
		drawfilloval (410, 280, 13, 13, 27)     %Left hub cap
		drawfilloval (410, 287, 4, 4, 20)     %Details of the left hub cap
		drawfilloval (417, 280, 4, 4, 20)
		drawfilloval (410, 273, 4, 4, 20)
		drawfilloval (403, 280, 4, 4, 20)
		drawoval (410, 280, 2, 2, 251)
		drawfill (410, 280, exColour, 251)
		drawfilloval (530, 280, 17, 17, 251)     %Right tire
		drawfilloval (530, 280, 13, 13, 27)     %Right hub cap
		drawfilloval (530, 287, 4, 4, 20)
		drawfilloval (537, 280, 4, 4, 20)
		drawfilloval (530, 273, 4, 4, 20)
		drawfilloval (523, 280, 4, 4, 20)
		drawoval (530, 280, 2, 2, 251)
		drawfill (530, 280, exColour, 251)
		%---------------------------------------------------------------CAR_MODEL_1-------------------------------------------------------------%
	    elsif (mouseX >= 10 and mouseX <= 40) and (mouseY >= 460 and mouseY <= 520) then
		if firstModel = false and carModel = 2 then     %Indent erase
		    drawfillbox (40, 460, 80, 520, 29)     %Models option 2
		    drawbox (40, 460, 80, 520, 251)     %Models option 2 outline
		    Font.Draw ("2", 57, 485, font1, 251)
		elsif firstModel = false and carModel = 3 then     %Indent erase
		    drawfillbox (80, 460, 110, 520, 29)     %Models option 3
		    drawbox (80, 460, 110, 520, 251)     %Models option 3 outline
		    Font.Draw ("3", 92, 485, font1, 251)
		end if

		drawfillbox (10, 460, 40, 520, 22)     %Models option 1 indent
		drawbox (10, 460, 40, 520, 251)     %Models option 1 outline
		Font.Draw ("1", 23, 485, font1, 251)

		if firstModel = true then     %Indents default car model choices
		    drawfillbox (10, 260, 40, 320, 4)     %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251)     %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		    drawfillbox (630, 460, 680, 520, 22)     %# of doors option 1
		    drawbox (630, 460, 680, 520, 251)     %# of doors option 1 outline
		    Font.Draw ("1", 650, 485, font1, 251)
		    drawfillbox (320, 10, 350, 70, 22)     %Bumper styles plate option 1
		    drawbox (320, 10, 350, 70, 251)     %Bumper styles plate option 1 outline
		    Font.Draw ("1", 330, 35, font1, 251)
		    drawfillbox (520, 10, 550, 70, 22)     %Hub caps plate option 1
		    drawbox (520, 10, 550, 70, 251)     %Hub caps plate option 1 outline
		    Font.Draw ("1", 530, 35, font1, 251)
		end if
		firstModel := false
		carModel := 1
		car := true
		drawfillbox (130, 260, 290, 400, 0)     %Erase front view
		drawline (340, 280, 340, 380, 31)     %Erase car model side view
		drawline (340, 380, 580, 380, 31)
		drawline (580, 380, 580, 340, 31)
		drawline (580, 340, 580, 280, 31)
		drawline (580, 280, 550, 280, 31)
		drawarc (530, 280, 20, 20, 0, 180, 31)
		drawline (510, 281, 430, 281, 31)
		drawarc (410, 280, 20, 20, 0, 180, 31)
		drawline (390, 281, 340, 281, 31)
		drawfill (530, 320, 31, 31)     %fills in the erase margins of the car

		drawline (340, 280, 340, 340, 251)     %Draws the side view  for car model 1
		drawline (340, 340, 410, 380, 251)
		drawline (410, 380, 500, 380, 251)
		drawline (500, 380, 550, 340, 251)
		drawline (550, 340, 580, 340, 251)
		drawline (580, 340, 580, 280, 251)
		drawline (580, 280, 550, 280, 251)
		drawarc (530, 280, 20, 20, 0, 180, 251)
		drawline (510, 281, 430, 281, 251)
		drawarc (410, 280, 20, 20, 0, 180, 251)
		drawline (390, 281, 340, 281, 251)
		drawfill (530, 320, exColour, 251)     %Colour of the car

		drawline (360, 340, 410, 370, 251)     %Draws the  left window for car model 1
		drawline (410, 370, 440, 370, 251)
		drawline (440, 370, 440, 340, 251)
		drawline (360, 340, 440, 340, 251)
		drawfill (370, 341, 251, 251)     %Colours inside of the window


		drawline (460, 340, 460, 370, 251)     %Draws the right window for car model 1
		drawline (460, 370, 500, 370, 251)
		drawline (500, 370, 540, 340, 251)
		drawline (540, 340, 460, 340, 251)
		drawfill (470, 341, 251, 251)     %Colours inside of the window

		drawfillbox (560, 320, 580, 340, yellow)     %Car light
		drawbox (560, 320, 580, 340, 251)     %Car light outline

		drawline (460, 281, 460, 340, 250)     %Door 1
		drawfillbox (470, 315, 490, 330, 251)     %Door handle
		%-------------------------------REDRAWS_2ND_DOOR-----------------------------------------
		if car2Door = true then
		    drawline (380, 281, 380, 339, 249)     %2nd door
		    drawfillbox (390, 315, 410, 330, 249)     %2nd door handle
		end if
		%----------------------------------DEFUALT_HUBCAP----------------------------------------------
		if hubCaps = 1 then
		    drawfilloval (410, 280, 17, 17, 251)     %Left tire
		    drawfilloval (410, 280, 13, 13, 27)     %Left hub cap
		    drawfilloval (530, 280, 17, 17, 251)     %Right tire
		    drawfilloval (530, 280, 13, 13, 27)     %Right hub cap
		end if
		%-----------------------------------------------FRONT_VIEW-----------------------------------------------------%
		drawline (130, 260, 130, 340, 251)     %Draws the front view frame for car model 1
		drawline (130, 340, 170, 400, 251)
		drawline (170, 400, 250, 400, 251)
		drawline (250, 400, 290, 340, 251)
		drawline (290, 340, 290, 260, 251)
		drawline (290, 260, 130, 260, 251)
		drawfill (210, 330, exColour, 251)     %Fills in the front view frame

		drawline (140, 340, 175, 390, 251)     %Window
		drawline (175, 390, 245, 390, 251)
		drawline (245, 390, 280, 340, 251)
		drawline (140, 340, 280, 340, 251)
		drawfill (145, 341, 251, 251)     %Fills in the window

		drawline (140, 310, 140, 330, 251)     %Left headlight
		drawline (140, 330, 160, 330, 251)
		drawline (160, 330, 180, 320, 251)
		drawline (180, 320, 160, 310, 251)
		drawline (160, 310, 140, 310, 251)
		drawfill (141, 311, yellow, 251)     %Fills left headlight

		drawline (280, 310, 280, 330, 251)     %Right headlight
		drawline (280, 330, 260, 330, 251)
		drawline (260, 330, 240, 320, 251)
		drawline (240, 320, 260, 310, 251)
		drawline (260, 310, 280, 310, 251)
		drawfill (270, 311, yellow, 251)     %Fills right headlight

		drawfillbox (180, 260, 240, 301, 20)     %Front grill
		drawfillarc (210, 299, 30, 30, 0, 180, 20)
		drawline (180, 260, 240, 260, 251)
		drawline (180, 260, 180, 300, 251)
		drawline (240, 260, 240, 300, 251)
		drawarc (210, 299, 30, 30, 0, 180, 251)
		%-------------------------------------DEFUALT_BUMPER---------------------------------------------
		if bumperTrue = false then     %Default bumper
		    drawfillbox (140, 220, 160, 260, 251)     %Left wheel
		    drawfillbox (260, 220, 280, 260, 251)     %Right wheel
		    drawfillbox (130, 235, 290, 260, 29)     %Front view bumper
		    drawbox (130, 235, 290, 260, 251)     %Front view bumper outline
		    drawfillbox (190, 240, 230, 257, 0)     %License plate
		    drawbox (190, 240, 230, 257, 251)     %License plate outline

		    drawline (550, 280, 580, 280, 251) %Side view bumper outline
		    drawline (580, 270, 550, 280, 251)
		    drawbox (580, 270, 590, 287, 251)
		    drawline (580, 279, 580, 271, 29)
		    drawfill (570, 279, 29, 251) %Fills in side view
		end if
		%-----------------------------------REDRAWS_CURRENT_CARBRAND-----------------------------------------------
		if carBrandnum = 1 then
		    drawfilloval (210, 300, 10, 10, 251)     %Car Brand 1
		    drawfillarc (210, 300, 7, 7, 0, 90, 53)     %Top right
		    drawfillarc (210, 300, 7, 7, 90, 180, 0)     %Top left
		    drawfillarc (210, 300, 7, 7, 180, 270, 53)     %Down left
		    drawfillarc (210, 300, 7, 7, 270, 360, 0)     %Down right
		elsif carBrandnum = 2 then
		    drawoval (210, 300, 10, 10, 29)     %Car Brand 2
		    drawline (209, 300, 210, 310, 29)     %Mercedes Benz logo
		    drawline (210, 310, 211, 300, 29)
		    drawline (210, 300, 210, 310, 29)
		    drawline (211, 300, 218, 297, 29)
		    drawline (218, 297, 210, 299, 29)
		    drawline (210, 299, 200, 297, 29)
		    drawline (200, 297, 209, 300, 29)
		elsif carBrandnum = 3 then
		    drawoval (210, 300, 10, 8, 29)     %Car Brand 3
		    drawoval (210, 300, 4, 7, 29)     %Middle oval
		    drawoval (210, 304, 10, 3, 29)     %Top oval
		end if
		%---------------------------------------------------------------CAR_MODEL_2-------------------------------------------------------------%
	    elsif (mouseX >= 40 and mouseX <= 80) and (mouseY >= 460 and mouseY <= 520) then
		if firstModel = false and carModel = 3 then     %Indent erase
		    drawfillbox (80, 460, 110, 520, 29)     %Models option 3
		    drawbox (80, 460, 110, 520, 251)     %Models option 3 outline
		    Font.Draw ("3", 92, 485, font1, 251)
		elsif firstModel = false and carModel = 1 then    %Indent erase
		    drawfillbox (10, 460, 40, 520, 29)     %Models option 1
		    drawbox (10, 460, 40, 520, 251)     %Models option 1 outline
		    Font.Draw ("1", 23, 485, font1, 251)
		end if

		drawfillbox (40, 460, 80, 520, 22)     %Models option 2 indent
		drawbox (40, 460, 80, 520, 251)     %Models option 2 outline
		Font.Draw ("2", 57, 485, font1, 251)

		if firstModel = true then     %Indents default car model choices
		    drawfillbox (10, 260, 40, 320, 4)     %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251)     %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		    drawfillbox (630, 460, 680, 520, 22)     %# of doors option 1
		    drawbox (630, 460, 680, 520, 251)     %# of doors option 1 outline
		    Font.Draw ("1", 650, 485, font1, 251)
		    drawfillbox (320, 10, 350, 70, 22)     %Bumper styles plate option 1
		    drawbox (320, 10, 350, 70, 251)     %Bumper styles plate option 1 outline
		    Font.Draw ("1", 330, 35, font1, 251)
		    drawfillbox (520, 10, 550, 70, 22)     %Hub caps plate option 1
		    drawbox (520, 10, 550, 70, 251)     %Hub caps plate option 1 outline
		    Font.Draw ("1", 530, 35, font1, 251)
		end if
		firstModel := false
		carModel := 2
		car := true
		drawfillbox (130, 260, 290, 400, 0)     %Erase front view
		drawline (340, 280, 340, 380, 31)     %Erase side view
		drawline (340, 380, 580, 380, 31)
		drawline (580, 380, 580, 340, 31)
		drawline (580, 340, 580, 280, 31)
		drawline (580, 280, 550, 280, 31)
		drawarc (530, 280, 20, 20, 0, 180, 31)
		drawline (510, 281, 430, 281, 31)
		drawarc (410, 280, 20, 20, 0, 180, 31)
		drawline (390, 281, 340, 281, 31)
		drawfill (530, 320, 31, 31)     %fills in the erase margins of the car

		drawline (340, 280, 340, 380, 251)     %Draws the side view for car model 2
		drawline (340, 380, 500, 380, 251)
		drawline (500, 380, 550, 340, 251)
		drawline (550, 340, 580, 340, 251)
		drawline (580, 340, 580, 280, 251)
		drawline (580, 280, 550, 280, 251)
		drawarc (530, 280, 20, 20, 0, 180, 251)
		drawline (510, 281, 430, 281, 251)
		drawarc (410, 280, 20, 20, 0, 180, 251)
		drawline (390, 281, 340, 281, 251)
		drawfill (530, 320, exColour, 251)     %Colour of the car

		drawfillbox (350, 340, 440, 370, 251)     %Left window for car model 2


		drawline (460, 340, 460, 370, 251)     %Draws the right window for car model 2
		drawline (460, 370, 500, 370, 251)
		drawline (500, 370, 540, 340, 251)
		drawline (540, 340, 460, 340, 251)
		drawfill (470, 341, 251, 251)     %Colours inside of the window

		drawline (560, 340, 580, 323, 251)     %Headlight
		drawfill (562, 339, yellow, 251)

		drawline (460, 281, 460, 340, 250)     %Door 1
		drawfillbox (470, 315, 490, 330, 251)     %Door handle
		%-------------------------------REDRAWS_2ND_DOOR-----------------------------------------
		if car2Door = true then
		    drawline (380, 281, 380, 339, 249)     %2nd door
		    drawfillbox (390, 315, 410, 330, 249)     %2nd door handle
		end if
		%----------------------------------DEFUALT_HUBCAP----------------------------------------------
		if hubCaps = 1 then
		    drawfilloval (410, 280, 17, 17, 251)     %Left tire
		    drawfilloval (410, 280, 13, 13, 27)     %Left hub cap
		    drawfilloval (530, 280, 17, 17, 251)     %Right tire
		    drawfilloval (530, 280, 13, 13, 27)     %Right hub cap
		end if
		%-----------------------------------------------FRONT_VIEW-----------------------------------------------------%
		drawline (130, 320, 160, 400, 251)     %Draws the front view frame for car model 2
		drawline (160, 400, 260, 400, 251)
		drawline (260, 400, 290, 320, 251)
		drawline (290, 320, 290, 260, 251)
		drawline (290, 260, 130, 260, 251)
		drawline (130, 260, 130, 320, 251)
		drawfill (210, 330, exColour, 251)     %Fills the front veiw of car model 2

		drawline (150, 340, 170, 390, 251)
		drawline (170, 390, 250, 390, 251)
		drawline (250, 390, 270, 340, 251)
		drawline (270, 340, 150, 340, 251)
		drawfill (210, 370, 251, 251)     %Fills in the front window

		drawfillbox (130, 300, 160, 320, yellow)     %Left front healight
		drawbox (130, 300, 160, 320, 251)     %Left headlight outline
		drawfillbox (260, 300, 290, 320, yellow)     %Right front healight
		drawbox (260, 300, 290, 320, 251)     %Right headlight outline

		drawfillbox (180, 260, 240, 320, 20)     %Grill
		drawbox (180, 260, 240, 320, 251)     %Grill outline
		%-------------------------------------DEFUALT_BUMPER---------------------------------------------
		if bumperTrue = false then     %Default bumper
		    drawfillbox (140, 220, 160, 260, 251)     %Left wheel
		    drawfillbox (260, 220, 280, 260, 251)     %Right wheel
		    drawfillbox (130, 235, 290, 260, 29)     %Front view bumper
		    drawbox (130, 235, 290, 260, 251)     %Front view bumper outline
		    drawfillbox (190, 240, 230, 257, 0)     %License plate
		    drawbox (190, 240, 230, 257, 251)     %License plate outline

		    drawline (550, 280, 580, 280, 251) %Side view bumper outline
		    drawline (580, 270, 550, 280, 251)
		    drawbox (580, 270, 590, 287, 251)
		    drawline (580, 279, 580, 271, 29)
		    drawfill (570, 279, 29, 251) %Fills in side view
		end if
		%-----------------------------------REDRAWS_CURRENT_CARBRAND-----------------------------------------------
		if carBrandnum = 1 then
		    drawfilloval (210, 300, 10, 10, 251)     %Car Brand 1
		    drawfillarc (210, 300, 7, 7, 0, 90, 53)     %Top right
		    drawfillarc (210, 300, 7, 7, 90, 180, 0)     %Top left
		    drawfillarc (210, 300, 7, 7, 180, 270, 53)     %Down left
		    drawfillarc (210, 300, 7, 7, 270, 360, 0)     %Down right
		elsif carBrandnum = 2 then
		    drawoval (210, 300, 10, 10, 29)     %Car Brand 2
		    drawline (209, 300, 210, 310, 29)     %Mercedes Benz logo
		    drawline (210, 310, 211, 300, 29)
		    drawline (210, 300, 210, 310, 29)
		    drawline (211, 300, 218, 297, 29)
		    drawline (218, 297, 210, 299, 29)
		    drawline (210, 299, 200, 297, 29)
		    drawline (200, 297, 209, 300, 29)
		elsif carBrandnum = 3 then
		    drawoval (210, 300, 10, 8, 29)     %Car Brand 3
		    drawoval (210, 300, 4, 7, 29)     %Middle oval
		    drawoval (210, 304, 10, 3, 29)     %Top oval
		end if
		%---------------------------------------------------------------CAR_MODEL_3-------------------------------------------------------------%
	    elsif (mouseX >= 80 and mouseX <= 110) and (mouseY >= 460 and mouseY <= 520) then
		if firstModel = false and carModel = 2 then     %Indent erase
		    drawfillbox (40, 460, 80, 520, 29)     %Models option 2
		    drawbox (40, 460, 80, 520, 251)     %Models option 2 outline
		    Font.Draw ("2", 57, 485, font1, 251)
		elsif firstModel = false and carModel = 1 then     %Indent erase
		    drawfillbox (10, 460, 40, 520, 29)     %Models option 1
		    drawbox (10, 460, 40, 520, 251)     %Models option 1 outline
		    Font.Draw ("1", 23, 485, font1, 251)
		end if

		drawfillbox (80, 460, 110, 520, 22)     %Models option 3 indent
		drawbox (80, 460, 110, 520, 251)     %Models option 3 outline
		Font.Draw ("3", 92, 485, font1, 251)

		if firstModel = true then     %Indents default car model choices
		    drawfillbox (340, 250, 600, 400, 0)             %erases the side view
		    drawfillbox (10, 260, 40, 320, 4)     %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251)     %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		    drawfillbox (630, 460, 680, 520, 22)     %# of doors option 1
		    drawbox (630, 460, 680, 520, 251)     %# of doors option 1 outline
		    Font.Draw ("1", 650, 485, font1, 251)
		    drawfillbox (320, 10, 350, 70, 22)     %Bumper styles plate option 1
		    drawbox (320, 10, 350, 70, 251)     %Bumper styles plate option 1 outline
		    Font.Draw ("1", 330, 35, font1, 251)
		    drawfillbox (520, 10, 550, 70, 22)     %Hub caps plate option 1
		    drawbox (520, 10, 550, 70, 251)     %Hub caps plate option 1 outline
		    Font.Draw ("1", 530, 35, font1, 251)
		end if

		firstModel := false
		carModel := 3
		car := true
		drawfillbox (130, 260, 290, 400, 0)     %Erase front view
		drawline (340, 280, 340, 380, 31)     %Erase car model side view
		drawline (340, 380, 580, 380, 31)
		drawline (580, 380, 580, 340, 31)
		drawline (580, 340, 580, 280, 31)
		drawline (580, 280, 550, 280, 31)
		drawarc (530, 280, 20, 20, 0, 180, 31)
		drawline (510, 281, 430, 281, 31)
		drawarc (410, 280, 20, 20, 0, 180, 31)
		drawline (390, 281, 340, 281, 31)
		drawfill (530, 320, 31, 31)     %fills in the erase margins of the car

		drawline (340, 280, 340, 340, 251)     %Draws the side view for car model 3
		drawline (340, 340, 400, 340, 251)
		drawline (400, 340, 400, 380, 251)
		drawline (400, 380, 560, 380, 251)
		drawline (560, 380, 580, 340, 251)
		drawline (580, 340, 580, 280, 251)
		drawline (580, 280, 550, 280, 251)
		drawarc (530, 280, 20, 20, 0, 180, 251)
		drawline (510, 281, 430, 281, 251)
		drawarc (410, 280, 20, 20, 0, 180, 251)
		drawline (390, 281, 340, 281, 251)
		drawfill (530, 320, exColour, 251)     %Colour of the car
		drawfill (370, 300, exColour, 251)     %Colour of the car

		drawfillbox (560, 310, 580, 330, yellow)
		drawbox (560, 310, 580, 330, 251)

		drawline (410, 340, 410, 375, 251)     %Draws the right window for car model 3
		drawline (410, 375, 552, 375, 251)
		drawline (552, 375, 570, 340, 251)
		drawline (570, 340, 410, 340, 251)
		drawfill (420, 341, 251, 251)     %Colours inside of the window
		drawfillbox (470, 340, 479, 375, exColour)     %Seperates the left window into 2

		drawline (480, 281, 480, 340, 250)     %Door 1
		drawfillbox (490, 315, 510, 330, 251)     %Door handle
		%-------------------------------REDRAWS_2ND_DOOR-----------------------------------------
		if car2Door = true then
		    drawline (400, 298, 400, 339, 249)     %2nd door
		    drawfillbox (410, 315, 430, 330, 249)     %2nd door handle
		end if
		%----------------------------------DEFUALT_HUBCAP----------------------------------------------
		if hubCaps = 1 then
		    drawfilloval (410, 280, 17, 17, 251)     %Left tire
		    drawfilloval (410, 280, 13, 13, 27)     %Left hub cap
		    drawfilloval (530, 280, 17, 17, 251)     %Right tire
		    drawfilloval (530, 280, 13, 13, 27)     %Right hub cap
		end if
		%-----------------------------------------------FRONT_VIEW-----------------------------------------------------%
		drawline (130, 360, 160, 400, 251)     %Draws the front view frame for car model 2
		drawline (160, 400, 260, 400, 251)
		drawline (260, 400, 290, 360, 251)
		drawline (290, 360, 290, 260, 251)
		drawline (290, 261, 130, 261, 251)
		drawline (290, 260, 130, 260, 251)
		drawline (130, 261, 130, 361, 251)
		drawfill (210, 330, exColour, 251)     %Fills the front veiw of car model 2

		drawline (140, 360, 160, 390, 251)     %Front window
		drawline (160, 390, 260, 390, 251)
		drawline (260, 390, 280, 360, 251)
		drawline (280, 360, 140, 360, 251)
		drawfill (145, 361, 251, 251)     %Fills in the front window

		drawfillbox (130, 320, 180, 340, yellow)     %Left front healight
		drawbox (130, 320, 180, 340, 251)     %Left headlight outline
		drawfillbox (240, 320, 290, 340, yellow)     %Right front healight
		drawbox (240, 320, 290, 340, 251)     %Right headlight outline

		drawfillarc (210, 260, 50, 60, 0, 180, 20)     %Front grill
		drawarc (210, 260, 50, 60, 0, 180, 251)     %Front grill outline
		drawarc (210, 260, 50, 60, 0, 180, 251)     %Grill bars
		drawline (180, 260, 180, 307, 251)
		drawline (240, 260, 240, 307, 251)
		%-------------------------------------DEFUALT_BUMPER---------------------------------------------
		if bumperTrue = false then     %Default bumper
		    drawfillbox (140, 220, 160, 260, 251)     %Left wheel
		    drawfillbox (260, 220, 280, 260, 251)     %Right wheel
		    drawfillbox (130, 235, 290, 260, 29)     %Front view bumper
		    drawbox (130, 235, 290, 260, 251)     %Front view bumper outline
		    drawfillbox (190, 240, 230, 257, 0)     %License plate
		    drawbox (190, 240, 230, 257, 251)     %License plate outline

		    drawline (550, 280, 580, 280, 251) %Side view bumper outline
		    drawline (580, 270, 550, 280, 251)
		    drawbox (580, 270, 590, 287, 251)
		    drawline (580, 279, 580, 271, 29)
		    drawfill (570, 279, 29, 251) %Fills in side view
		end if
		%-----------------------------------REDRAWS_CURRENT_CARBRAND-----------------------------------------------
		if carBrandnum = 1 then
		    drawfilloval (210, 300, 10, 10, 251)     %Car Brand 1
		    drawfillarc (210, 300, 7, 7, 0, 90, 53)     %Top right
		    drawfillarc (210, 300, 7, 7, 90, 180, 0)     %Top left
		    drawfillarc (210, 300, 7, 7, 180, 270, 53)     %Down left
		    drawfillarc (210, 300, 7, 7, 270, 360, 0)     %Down right
		elsif carBrandnum = 2 then
		    drawoval (210, 300, 10, 10, 29)     %Car Brand 2
		    drawline (209, 300, 210, 310, 29)     %Mercedes Benz logo
		    drawline (210, 310, 211, 300, 29)
		    drawline (210, 300, 210, 310, 29)
		    drawline (211, 300, 218, 297, 29)
		    drawline (218, 297, 210, 299, 29)
		    drawline (210, 299, 200, 297, 29)
		    drawline (200, 297, 209, 300, 29)
		elsif carBrandnum = 3 then
		    drawoval (210, 300, 10, 8, 29)     %Car Brand 3
		    drawoval (210, 300, 4, 7, 29)     %Middle oval
		    drawoval (210, 304, 10, 3, 29)     %Top oval
		end if

	    elsif (mouseX >= 630 and mouseX <= 730) and (mouseY >= 20 and mouseY <= 100) then %Resets the users option
		drawfillbox (130, 220, 290, 400, 0) %erases the front view
		drawfillbox (340, 250, 600, 400, 0) %erases the side view
		Font.Draw ("A Car Model has to be choosen first", 380, 350, font2, 251)
		Font.Draw ("for any other choice to be shown", 387, 340, font2, 251)

		if exColour = 12 then %Indent erase
		    drawfillbox (10, 260, 40, 320, 12) %Exterior colours option 1
		    drawbox (10, 260, 40, 320, 251) %Exterior colours option 1 outline
		    Font.Draw ("1", 23, 285, font1, 251)
		elsif exColour = 76 then %Indent erase
		    drawfillbox (40, 260, 80, 320, 76) %Exterior colours option 2
		    drawbox (40, 260, 80, 320, 251) %Exterior colours option 2 outline
		    Font.Draw ("2", 57, 285, font1, 251)
		elsif exColour = 43 then %Indent erase
		    drawfillbox (80, 260, 110, 320, 43) %Exterior colours option 3
		    drawbox (80, 260, 110, 320, 251) %Exterior colours option 3 outline
		    Font.Draw ("3", 92, 285, font1, 251)
		elsif exColour = 27 then %Indent erase
		    drawfillbox (10, 200, 40, 260, 27) %Exterior colours option 4
		    drawbox (10, 200, 40, 260, 251) %Exterior colours option 4 outline
		    Font.Draw ("4", 23, 225, font1, 251)
		elsif exColour = 47 then %Indent erase
		    drawfillbox (40, 200, 80, 260, 47) %Exterior colours option 5
		    drawbox (40, 200, 80, 260, 251) %Exterior colours option 5 outline
		    Font.Draw ("5", 57, 225, font1, 251)
		elsif exColour = 54 then %Indent erase
		    drawfillbox (80, 200, 110, 260, 54) %Exterior colours option 6
		    drawbox (80, 200, 110, 260, 251) %Exterior colours option 6 outline
		    Font.Draw ("6", 92, 225, font1, 251)
		end if
		if hubCaps = 1 then               %indent erase
		    drawfillbox (520, 10, 550, 70, 29)     %Hub caps plate option 1
		    drawbox (520, 10, 550, 70, 251)     %Hub caps plate option 1 outline
		    Font.Draw ("1", 530, 35, font1, 251)
		elsif hubCaps = 2 then     %indent erase
		    drawfillbox (550, 10, 590, 70, 29)     %Hub caps plate option 2
		    drawbox (550, 10, 590, 70, 251)     %Hub caps plate option 2 outline
		    Font.Draw ("2", 565, 35, font1, 251)
		elsif hubCaps = 3 then     %indent erase
		    drawfillbox (590, 10, 620, 70, 29)     %Hub caps plate option 3
		    drawbox (590, 10, 620, 70, 251)     %Hub caps plate option 3 outline
		    Font.Draw ("3", 602, 35, font1, 251)
		end if

		if bumper = 1 then             %indent erase
		    drawfillbox (320, 10, 350, 70, 29)     %Bumper styles plate option 1
		    drawbox (320, 10, 350, 70, 251)     %Bumper styles plate option 1 outline
		    Font.Draw ("1", 330, 35, font1, 251)
		elsif bumper = 2 then     %indent erase
		    drawfillbox (350, 10, 390, 70, 29)     %Bumper styles plate option 2
		    drawbox (350, 10, 390, 70, 251)     %Bumper styles plate option 2 outline
		    Font.Draw ("2", 367, 35, font1, 251)
		elsif bumper = 3 then     %indent erase
		    drawfillbox (390, 10, 420, 70, 29)     %Bumper styles plate option 3
		    drawbox (390, 10, 420, 70, 251)     %Bumper styles plate option 3 outline
		    Font.Draw ("3", 403, 35, font1, 251)
		end if

		if licensePlate = 2 then     %indent erase
		    drawfillbox (660, 260, 700, 320, 29)     %License plate option 2
		    drawbox (660, 260, 700, 320, 251)     %License plate option 2 outline
		    Font.Draw ("2", 677, 285, font1, 251)
		elsif licensePlate = 1 then     %indent erase
		    drawfillbox (630, 260, 660, 320, 29)     %License plate option 1
		    drawbox (630, 260, 660, 320, 251)     %License plate option 1 outline
		    Font.Draw ("1", 643, 285, font1, 251)
		elsif licensePlate = 3 then     %indent erase
		    drawfillbox (700, 260, 730, 320, 29)     %License plate option 3
		    drawbox (700, 260, 730, 320, 251)     %License plate option 3 outline
		    Font.Draw ("3", 713, 285, font1, 251)
		end if

		if car2Door = false then
		    drawfillbox (630, 460, 680, 520, 29) %# of doors option 1 indent erase
		    drawbox (630, 460, 680, 520, 251) %# of doors option 1 outline
		    Font.Draw ("1", 650, 485, font1, 251)
		elsif car2Door = true then
		    drawfillbox (680, 460, 730, 520, 29) %# of doors option 2 indent erase
		    drawbox (680, 460, 730, 520, 251) %# of doors option 2 outline
		    Font.Draw ("2", 700, 485, font1, 251)
		end if

		if carBrandnum = 1 then     %Indent erase
		    drawfillbox (120, 10, 150, 70, 29)     %Car brands plate option 1
		    drawbox (120, 10, 150, 70, 251)     %Car brands plate option 1 outline
		    Font.Draw ("1", 130, 35, font1, 251)
		elsif carBrandnum = 2 then     %Indent erase
		    drawfillbox (150, 10, 190, 70, 29)     %Car brands plate option 2
		    drawbox (150, 10, 190, 70, 251)     %Car brands plate option 2 outline
		    Font.Draw ("2", 167, 35, font1, 251)
		elsif carBrandnum = 3 then     %Indent erase
		    drawfillbox (190, 10, 220, 70, 29)     %Car brands plate option 3
		    drawbox (190, 10, 220, 70, 251)     %Car brands plate option 3 outline
		    Font.Draw ("3", 200, 35, font1, 251)
		end if

		if carModel = 2 then           %Indent erase
		    drawfillbox (40, 460, 80, 520, 29) %Models option 2
		    drawbox (40, 460, 80, 520, 251) %Models option 2 outline
		    Font.Draw ("2", 57, 485, font1, 251)
		elsif carModel = 1 then      %Indent erase
		    drawfillbox (10, 460, 40, 520, 29) %Models option 1
		    drawbox (10, 460, 40, 520, 251) %Models option 1 outline
		    Font.Draw ("1", 23, 485, font1, 251)
		elsif carModel = 3 then    %Indent erase
		    drawfillbox (80, 460, 110, 520, 29) %Models option 3
		    drawbox (80, 460, 110, 520, 251)     %Models option 3 outline
		    Font.Draw ("3", 92, 485, font1, 251)
		end if

		carModel := 0
		licensePlate := 0
		carBrandnum := 0
		bumper := 1 %Stores the type of bumper the user has choosen; 1 is initiated as the default
		exColour := 12  %Stores the exterior colour the user has choosen; 12 is initiated as the default colour #
		hubCaps := 1 %Stores the type of hub cap the user has choosen; 1 is initiated as the default
		car2Door := false %Defult car comes with one door
		car := false
		bumperTrue := false
		firstModel := true
		%------------------------------------------------------EXIT_BUTTON---------------------------------------------------------------%

	    elsif (mouseX >= 630 and mouseX <= 730) and (mouseY >= 120 and mouseY <= 200) then %Exits the display loop, and sets setscreen back to nooffscreenoly
		setscreen ("nooffscreenonly")
		Music.PlayFileStop
		mainMenu
		exit
	    end if
 
	end if
	View.Update
    end loop
end display

body proc goodbye
    title ("Car Creator")
    GUI.Hide (instuctionsButton)     %Hides the main menu buttons so that ghost buttons dont apear
    GUI.Hide (playGame)
    GUI.Hide (quitButton)
    locate (4, 30)
    put "Thank you for playing Car Creator" ..
    locate (5, 34)
    put "Hope you have a nice day"
    locate (15, 24)
    put "The Car Creator was made by: Erfan Yeganehfar"
    locate (20, 16)
    put "For more information go to www.CarCreator/CustomerService.com"
    delay (5000)
    Window.Close (mainWin)
end goodbye

%Main program
introduction
loop
    exit when GUI.ProcessEvent
end loop
goodbye
%End of program
