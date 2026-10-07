##########
# SYSTEM #
##########

###########################################
# BUTTON MAP (GPI bits, active low)       #
# bits 0-3 : circle 0-3 (hold one)        #
# bit  4   : RED                          #
# bit  5   : GREEN                        #
# bit  6   : BLUE                         #
# bit  7   : submit                       #
###########################################
define(BTN_C0,`1')
define(BTN_C1,`2')
define(BTN_C2,`4')
define(BTN_C3,`8')
define(BTN_RED,`16')
define(BTN_GREEN,`32')
define(BTN_BLUE,`64')
define(BTN_SUBMIT,`0x80')


###################
# MEMORY MAP ADDR #
###################

define(DISPLAY_X_MAX,`319')	
define(DISPLAY_Y_MAX,`239')	

define(HDMI_Y_SIZE,`0xFFE')	
define(HDMI_X_SIZE,`0xFFD')
define(HDMI_COLOUR,`0xFFC')	
define(HDMI_TILE,`0xFFB')
define(HDMI_Y_POS,`0xFFA')
define(HDMI_X_POS,`0xFF9')
define(HDMI_COMMAND,`0xFF8')
define(HDMI_STATUS,`0xFF8')
define(GPO,`0xFF7')
define(GPI,`0xFF6')
define(UART_TX,`0xFF5')
define(UART_RX,`0xFF5')
define(UART_STATUS,`0xFF4')

################
# COLOUR CODES #
################

define(BLACK,`0x00')	
define(RED,`0x30')
define(GREEN,`0x0C')	
define(BLUE,`0x03')
define(YELLOW,`0x3C')	
define(PURPLE,`0x33')
define(CYAN,`0x0F')	
define(WHITE,`0x3F')

##############
# PIECE CODE #
##############

define(CIRCLE,`0xEB')


###############
# ROTATE LEFT #
###############

define( rotl, `
ifelse(eval($2==1), 1, `
  rol $1',)

ifelse(eval($2==2), 1, `
  rol $1
  rol $1',)

ifelse(eval($2==3), 1, `
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==4), 1, `
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==5), 1, `
  ro1 $1
  ro1 $1
  ro1 $1
  ro1 $1
  ro1 $1',)

ifelse(eval($2==6), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==7), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==8), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==9), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==10), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==11), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==12), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==13), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==14), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==15), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)
')

################
# ROTATE RIGHT #
################

define( rotr, `
ifelse(eval($2==15), 1, `
  rol $1',)

ifelse(eval($2==14), 1, `
  rol $1
  rol $1',)

ifelse(eval($2==13), 1, `
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==12), 1, `
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==11), 1, `
  ro1 $1
  ro1 $1
  ro1 $1
  ro1 $1
  ro1 $1',)

ifelse(eval($2==10), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==9), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==8), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==7), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==6), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==5), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==4), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==3), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==2), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)

ifelse(eval($2==1), 1, `
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1
  rol $1',)
')

#################
# REG_BITFIELDS #
#################

#                 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
# OPCODE REG IMM  X  X  X  X  0  0  0 0 X X X X X X X X  
#        RA       X  X  X  X  0  0  0 0 X X X X X X X X  = 000
#        RB       X  X  X  X  0  1  0 0 X X X X X X X X  = 400
#        RC       X  X  X  X  1  0  0 0 X X X X X X X X  = 800
#        RD       X  X  X  X  1  1  0 0 X X X X X X X X  = C00

define(`REG_BITFIELDS', `
ifelse($1, ra, 0x000,
       $1, rb, 0x400,
       $1, rc, 0x800,
       $1, RC, 0xC00,
       $1, rd, 0xC00,
       0)
')

######
# OR #
######

define( ori, `xop1 $1 eval(REG_BITFIELDS($1) + eval($2&255))')

######################
# MOVE 12BIT ADDRESS #
######################

define( movea, `
  move $1 `eval(( $2 & 0xFF00 ) >> 4)'
  and $1 0xFF
  asl $1
  asl $1
  asl $1
  asl $1
  `ori($1,eval( $2 & 0xFF ))'')

###################
# MOVE 16BIT DATA #
###################

define( moved, `
  move $1 `eval(( $2 & 0xFF00 ) >> 8)'
  and $1 0xFF
  asl $1
  asl $1
  asl $1
  asl $1
  asl $1
  asl $1
  asl $1
  asl $1
  `ori($1,eval( $2 & 0xFF ))'')

#################
# RESERVE SPACE #
#################

define( space, ` 
  .data 0'dnl 
`ifelse(eval($1-1), 0, ` 
  .data 0',`space(eval($1-1))')')


define(movea,`
move $1 `eval(($2 & 0xF00) >> 4)'
and $1 0xFF
asl $1
asl $1
asl $1
asl $1
`ori($1,eval($2 & 0xFF))'
')
