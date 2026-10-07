##################################################
# BasicMind
# Data sits at the top so label immediates are < 128.
# Only instructions implemented in the base simpleCPUv1d.
##################################################

start:
  jump begin

###############
## VARIABLES ##
###############

scoreOffset:
  .data 20

### 0x04 = end of transmission ###
scoreString:
  .data 0x53
  .data 0x63
  .data 0x6F
  .data 0x72
  .data 0x65
  .data 0x3A
  .data 0x35
  .data 0x04


winOffset:
  .data 100

### 0x04 = end of transmission ###
winString:
  .data 0x59
  .data 0x6F
  .data 0x75
  .data 0x00
  .data 0x77
  .data 0x6f
  .data 0x6e
  .data 0x21
  .data 0x04


won:
  .data 0
maxTurns:
  .data 5
go:
  .data 0
answer:
  .data 0x30
  .data 0x30
  .data 0x30
  .data 0x30
  .data 0x04
uiX:
  .data 0
gPtr:
  .data 0
xPtr:
  .data 0
yPtr:
  .data 0
submitHeld:
  .data 0
tmp:
  .data 0

##############################
############Guesses ##########
# 5 rows x 4 circles, white  #
##############################
guesses:
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x3F
  .data 0x04

#####PRE COMPUTED OFFSETS FOR THE CIRCLES########
xOffsets:
  .data 20
  .data 40
  .data 60
  .data 80
yOffsets:
  .data 20
  .data 40
  .data 60
  .data 80
  .data 100

########
# CODE #
########

begin:

## main game loop
main:
game:
  call resetGame
  call checkInput
  call checkSubmit
  call drawGuesses
  call checkWin
  jumpu game


checkWin:
  load ra won
  and ra 1
  jumpz noWin
  call drawWin
  ret
noWin:
  call drawUI
  ret

###################Check Inputs###############################
###  hold a circle button, press a colour button           ###
###  writes the colour to guesses[go*4 + circle]           ###
##############################################################
checkInput:
  load ra go
  subm ra maxTurns
  jumpz inputDone
  load ra GPI
  and ra BTN_C0
  jumpz circle0
  load ra GPI
  and ra BTN_C1
  jumpz circle1
  load ra GPI
  and ra BTN_C2
  jumpz circle2
  load ra GPI
  and ra BTN_C3
  jumpz circle3
inputDone:
  ret
circle0:
  move rb 0
  jumpu pickColour
circle1:
  move rb 1
  jumpu pickColour
circle2:
  move rb 2
  jumpu pickColour
circle3:
  move rb 3
  jumpu pickColour

pickColour:
  load ra GPI
  and ra BTN_RED
  jumpz setRed
  load ra GPI
  and ra BTN_GREEN
  jumpz setGreen
  load ra GPI
  and ra BTN_BLUE
  jumpz setBlue
  ret
setRed:
  move rc RED
  jumpu storeColour
setGreen:
  move rc GREEN
  jumpu storeColour
setBlue:
  move rc BLUE

storeColour:
  load ra go
  rol ra
  rol ra
  add ra guesses
  move rd ra
offLoop:
  move ra rb
  and ra 0xFF
  jumpz offDone
  add rd 1
  sub rb 1
  jumpu offLoop
offDone:
  move ra rc
  store ra (rd)
  ret

###################Check Submit###############################
###  advances go once per press, stops on the last row     ###
##############################################################
checkSubmit:
  load ra GPI
  and ra BTN_SUBMIT
  jumpz submitPressed
  move ra 0
  store ra submitHeld
  ret
submitPressed:
  load ra submitHeld
  and ra 0xFF
  jumpnz submitDone
  move ra 1
  store ra submitHeld
  load ra go
  subm ra maxTurns
  jumpz submitDone
  load ra go
  add ra 1
  store ra go
  call checkAnswer
submitDone:
  ret

###################Check Answer##############################
###  compares guesses[go-1] with answer, 4 circles        ###
###  match - won = 1 and go = maxTurns (ends input)       ###
###  miss  - scoreString[6] decremented                    ###
##############################################################
checkAnswer:
  load ra go
  sub ra 1
  rol ra
  rol ra
  add ra guesses
  move rb ra
  move rc answer
  move rd 4
cmpLoop:
  load ra (rc)
  store ra tmp
  load ra (rb)
  subm ra tmp
  jumpnz answerWrong
  
  load ra tmp #store correct in next guess
  add rb 4
  store ra (rb)
  sub rb 4

  add rb 1
  add rc 1
  sub rd 1
  jumpnz cmpLoop
  move ra 1
  store ra won
  load ra maxTurns
  store ra go
  move ra 32
  store ra GPO
  ret
answerWrong:
  move rd scoreString
  add rd 6
  load ra (rd)
  sub ra 1
  store ra (rd)
  move ra 16
  store ra GPO
  ret

###################### Draw Guesses #######################
####   draws rows 0 to go inclusive, 4 circles per row   ####
####   walks gPtr / xPtr / yPtr forward, no reg-reg add ####
###########################################################
drawGuesses:
  move ra guesses
  store ra gPtr
  move ra yOffsets
  store ra yPtr
  move rb 0
rowLoop:
  move ra xOffsets
  store ra xPtr
  move rc 4
colLoop:
  load ra gPtr
  move rd ra
  load ra (rd)
  store ra HDMI_COLOUR
  load ra gPtr
  add ra 1
  store ra gPtr

  move ra CIRCLE
  store ra HDMI_TILE

  load ra yPtr
  move rd ra
  load ra (rd)
  store ra HDMI_Y_POS

  load ra xPtr
  move rd ra
  load ra (rd)
  store ra HDMI_X_POS
  load ra xPtr
  add ra 1
  store ra xPtr

  move ra 3
  store ra HDMI_COMMAND
  call wait

  sub rc 1
  jumpnz colLoop

  load ra yPtr
  add ra 1
  store ra yPtr

  move ra rb
  subm ra go
  jumpz endDraw
  move ra rb
  add ra 1
  subm ra maxTurns
  jumpz endDraw
  add rb 1
  jumpu rowLoop
endDraw:
  ret

###########################
##########drawUI###########
##writes score at the top##
###########################
drawUI:
  move ra 3
  store ra HDMI_Y_POS
  move ra WHITE
  store ra HDMI_COLOUR
  load ra scoreOffset
  store ra uiX
  move rd scoreString
uiLoop:
  load ra uiX
  store ra HDMI_X_POS
  load ra (rd)
  sub ra 0x04
  jumpz uiDone
  load ra (rd)
  store ra HDMI_TILE
  move ra 3
  store ra HDMI_COMMAND
  call wait
  add rd 1
  load ra uiX
  add ra 8
  store ra uiX
  jumpu uiLoop
uiDone:
  ret

###########################
##########drawWin##########
##Displays win message   ##
###########################
drawWin:
  move ra 80
  store ra HDMI_Y_POS
  move ra WHITE
  store ra HDMI_COLOUR
  load ra winOffset
  store ra uiX
  move rd winString
winLoop:
  load ra uiX
  store ra HDMI_X_POS
  load ra (rd)
  sub ra 0x04
  jumpz winDone
  load ra (rd)
  store ra HDMI_TILE
  move ra 3
  store ra HDMI_COMMAND
  call wait
  add rd 1
  load ra uiX
  add ra 8
  store ra uiX
  jumpu winLoop
winDone:
  ret

#########resetGame#########
# SW0 = on = reset game   #
###########################
resetGame:
  load ra GPI
  rotl(ra,8)
  and ra 1
  jumpz skipReset
  move ra 0
  store ra go #reset game variable
  store ra won #reset game variable
  
  move ra scoreString # reset score
  add ra 6
  move rd ra
  move ra 0x35
  store ra (rd)

  call clear #clear screen

  move ra 0 #reset light
  store ra GPO

  move rd guesses
resetLoop:
  load ra (rd)
  sub ra 0x04
  jumpz doneReset
  move ra 0x3F
  store ra (rd)
  add rd 1
  jumpu resetLoop
doneReset:
  ret
skipReset:
  ret


wait:
  load ra HDMI_STATUS
  and RA 3
  sub ra 3
  jumpnz wait
  ret

################Clear ##############
# draw a black block 320 x 240
#################################
clear:
  move RA 0                        
  store RA HDMI_X_POS
  store RA HDMI_Y_POS

  moved(RA,DISPLAY_X_MAX)
  store RA HDMI_X_SIZE
  moved(RA,DISPLAY_Y_MAX)
  store RA HDMI_Y_SIZE

  move RA BLACK
  store RA HDMI_COLOUR

  move RA 2
  store RA HDMI_COMMAND
  call wait
  ret
