# File saved with Nlview 7.8.0 2024-04-26 e1825d835c VDI=44 GEI=38 GUI=JA:21.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 15
property maxzoom 6.25
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #0000ff
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 15
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new RISC_CPU work:RISC_CPU:NOFILE -nosplit
load symbol OBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol BUFG hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol IBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol ACC work:ACC:NOFILE HIERBOX pin clk input.left pin ir_reg_reg[29] output.right pin pc_out_reg[0] input.left pinBus D input.left [31:0] pinBus E input.left [0:0] pinBus Q output.right [31:0] pinBus S output.right [3:0] pinBus SR input.left [0:0] pinBus acc_out_reg[11]_0 output.right [3:0] pinBus acc_out_reg[15]_0 output.right [3:0] pinBus acc_out_reg[19]_0 output.right [3:0] pinBus acc_out_reg[23]_0 output.right [3:0] pinBus acc_out_reg[27]_0 output.right [3:0] pinBus acc_out_reg[3]_0 output.right [3:0] pinBus acc_out_reg[7]_0 output.right [3:0] pinBus data_out input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol ALU work:ALU:NOFILE HIERBOX pinBus S input.left [3:0] pinBus acc_out_reg[11] input.left [3:0] pinBus acc_out_reg[15] input.left [3:0] pinBus acc_out_reg[19] input.left [3:0] pinBus acc_out_reg[23] input.left [3:0] pinBus acc_out_reg[27] input.left [3:0] pinBus acc_out_reg[3] input.left [3:0] pinBus acc_out_reg[7] input.left [3:0] pinBus data1 output.right [31:0] pinBus data_in input.left [30:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Controller work:Controller:NOFILE HIERBOX pin clk input.left pin ram_reg input.left pin rd output.right pinBus ADDRBWRADDR output.right [4:0] pinBus E output.right [0:0] pinBus FSM_onehot_state_reg[0]_0 input.left [0:0] pinBus Q output.right [2:0] pinBus SS input.left [0:0] pinBus WEBWE output.right [0:0] pinBus pc_out_OBUF input.left [4:0] pinBus ram_reg_0 input.left [4:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol IR work:IR:NOFILE HIERBOX pin clk input.left pin halt_OBUF output.right pin ir_reg_reg[29]_0 output.right pin ir_reg_reg[30]_0 output.right pin ir_reg_reg[30]_1 output.right pin pc_out_reg[0] input.left pin wr output.right pinBus D output.right [31:0] pinBus E output.right [0:0] pinBus O output.right [3:0] pinBus Q input.left [2:0] pinBus SR input.left [0:0] pinBus acc_out_reg[31] input.left [31:0] pinBus data1 input.left [31:0] pinBus ir_reg_reg[31]_0 output.right [0:0] pinBus ir_reg_reg[31]_1 input.left [31:0] pinBus ir_reg_reg[31]_2 input.left [0:0] pinBus ir_reg_reg[4]_0 output.right [4:0] pinBus pc_out_OBUF input.left [31:0] pinBus pc_out_reg[11] output.right [3:0] pinBus pc_out_reg[15] output.right [3:0] pinBus pc_out_reg[19] output.right [3:0] pinBus pc_out_reg[23] output.right [3:0] pinBus pc_out_reg[27] output.right [3:0] pinBus pc_out_reg[31] output.right [3:0] pinBus pc_out_reg[7] output.right [3:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol memory work:memory:NOFILE HIERBOX pin clk input.left pin rd input.left pin wr input.left pinBus ADDRBWRADDR input.left [4:0] pinBus Q input.left [31:0] pinBus WEBWE input.left [0:0] pinBus ram_reg_0 output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol program_counter work:program_counter:NOFILE HIERBOX pin clk input.left pin pc_out_reg[0]_0 input.left pinBus O input.left [3:0] pinBus SR input.left [0:0] pinBus pc_out_OBUF output.right [31:0] pinBus pc_out_reg[11]_0 input.left [3:0] pinBus pc_out_reg[15]_0 input.left [3:0] pinBus pc_out_reg[19]_0 input.left [3:0] pinBus pc_out_reg[23]_0 input.left [3:0] pinBus pc_out_reg[27]_0 input.left [3:0] pinBus pc_out_reg[31]_0 input.left [3:0] pinBus pc_out_reg[7]_0 input.left [3:0] boxcolor 1 fillcolor 2 minwidth 13%
load port clk input -pg 1 -lvl 0 -x 0 -y 2980
load port halt output -pg 1 -lvl 9 -x 3200 -y 2910
load port rst input -pg 1 -lvl 0 -x 0 -y 2910
load portBus acc_out output [31:0] -attr @name acc_out[31:0] -pg 1 -lvl 9 -x 3200 -y 40
load portBus pc_out output [31:0] -attr @name pc_out[31:0] -pg 1 -lvl 9 -x 3200 -y 2940
load inst acc_out_OBUF[0]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 40
load inst acc_out_OBUF[10]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 740
load inst acc_out_OBUF[11]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 810
load inst acc_out_OBUF[12]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 880
load inst acc_out_OBUF[13]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 950
load inst acc_out_OBUF[14]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1020
load inst acc_out_OBUF[15]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1090
load inst acc_out_OBUF[16]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1160
load inst acc_out_OBUF[17]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1230
load inst acc_out_OBUF[18]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1300
load inst acc_out_OBUF[19]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1370
load inst acc_out_OBUF[1]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 110
load inst acc_out_OBUF[20]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1440
load inst acc_out_OBUF[21]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1510
load inst acc_out_OBUF[22]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1580
load inst acc_out_OBUF[23]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1650
load inst acc_out_OBUF[24]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1720
load inst acc_out_OBUF[25]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1790
load inst acc_out_OBUF[26]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1860
load inst acc_out_OBUF[27]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 1930
load inst acc_out_OBUF[28]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2000
load inst acc_out_OBUF[29]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2070
load inst acc_out_OBUF[2]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 180
load inst acc_out_OBUF[30]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2140
load inst acc_out_OBUF[31]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2210
load inst acc_out_OBUF[3]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 250
load inst acc_out_OBUF[4]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 320
load inst acc_out_OBUF[5]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 390
load inst acc_out_OBUF[6]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 460
load inst acc_out_OBUF[7]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 530
load inst acc_out_OBUF[8]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 600
load inst acc_out_OBUF[9]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 670
load inst clk_IBUF_BUFG_inst BUFG hdi_primitives -attr @cell(#000000) BUFG -pg 1 -lvl 2 -x 180 -y 2980
load inst clk_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 1 -x 40 -y 2980
load inst halt_OBUF_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2910
load inst pc_out_OBUF[0]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2280
load inst pc_out_OBUF[10]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3050
load inst pc_out_OBUF[11]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3120
load inst pc_out_OBUF[12]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3190
load inst pc_out_OBUF[13]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3260
load inst pc_out_OBUF[14]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3330
load inst pc_out_OBUF[15]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3400
load inst pc_out_OBUF[16]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3470
load inst pc_out_OBUF[17]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3540
load inst pc_out_OBUF[18]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3610
load inst pc_out_OBUF[19]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3680
load inst pc_out_OBUF[1]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2350
load inst pc_out_OBUF[20]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3750
load inst pc_out_OBUF[21]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3820
load inst pc_out_OBUF[22]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3890
load inst pc_out_OBUF[23]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 3960
load inst pc_out_OBUF[24]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4030
load inst pc_out_OBUF[25]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4100
load inst pc_out_OBUF[26]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4170
load inst pc_out_OBUF[27]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4240
load inst pc_out_OBUF[28]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4310
load inst pc_out_OBUF[29]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4380
load inst pc_out_OBUF[2]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2420
load inst pc_out_OBUF[30]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4450
load inst pc_out_OBUF[31]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 4520
load inst pc_out_OBUF[3]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2490
load inst pc_out_OBUF[4]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2560
load inst pc_out_OBUF[5]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2630
load inst pc_out_OBUF[6]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2700
load inst pc_out_OBUF[7]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2770
load inst pc_out_OBUF[8]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2840
load inst pc_out_OBUF[9]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 8 -x 3000 -y 2980
load inst rst_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 2 -x 180 -y 2910
load inst u_acc ACC work:ACC:NOFILE -autohide -attr @cell(#000000) ACC -pinBusAttr D @name D[31:0] -pinBusAttr E @name E -pinBusAttr Q @name Q[31:0] -pinBusAttr S @name S[3:0] -pinBusAttr SR @name SR -pinBusAttr acc_out_reg[11]_0 @name acc_out_reg[11]_0[3:0] -pinBusAttr acc_out_reg[15]_0 @name acc_out_reg[15]_0[3:0] -pinBusAttr acc_out_reg[19]_0 @name acc_out_reg[19]_0[3:0] -pinBusAttr acc_out_reg[23]_0 @name acc_out_reg[23]_0[3:0] -pinBusAttr acc_out_reg[27]_0 @name acc_out_reg[27]_0[3:0] -pinBusAttr acc_out_reg[3]_0 @name acc_out_reg[3]_0[3:0] -pinBusAttr acc_out_reg[7]_0 @name acc_out_reg[7]_0[3:0] -pinBusAttr data_out @name data_out[31:0] -pg 1 -lvl 7 -x 2590 -y 2540
load inst u_alu ALU work:ALU:NOFILE -autohide -attr @cell(#000000) ALU -pinBusAttr S @name S[3:0] -pinBusAttr acc_out_reg[11] @name acc_out_reg[11][3:0] -pinBusAttr acc_out_reg[15] @name acc_out_reg[15][3:0] -pinBusAttr acc_out_reg[19] @name acc_out_reg[19][3:0] -pinBusAttr acc_out_reg[23] @name acc_out_reg[23][3:0] -pinBusAttr acc_out_reg[27] @name acc_out_reg[27][3:0] -pinBusAttr acc_out_reg[3] @name acc_out_reg[3][3:0] -pinBusAttr acc_out_reg[7] @name acc_out_reg[7][3:0] -pinBusAttr data1 @name data1[31:0] -pinBusAttr data_in @name data_in[30:0] -pg 1 -lvl 5 -x 1590 -y 2540
load inst u_ctrl Controller work:Controller:NOFILE -autohide -attr @cell(#000000) Controller -pinBusAttr ADDRBWRADDR @name ADDRBWRADDR[4:0] -pinBusAttr E @name E -pinBusAttr FSM_onehot_state_reg[0]_0 @name FSM_onehot_state_reg[0]_0 -pinBusAttr Q @name Q[2:0] -pinBusAttr SS @name SS -pinBusAttr WEBWE @name WEBWE -pinBusAttr pc_out_OBUF @name pc_out_OBUF[4:0] -pinBusAttr ram_reg_0 @name ram_reg_0[4:0] -pg 1 -lvl 4 -x 1110 -y 3000
load inst u_ir IR work:IR:NOFILE -autohide -attr @cell(#000000) IR -pinBusAttr D @name D[31:0] -pinBusAttr E @name E -pinBusAttr O @name O[3:0] -pinBusAttr Q @name Q[2:0] -pinBusAttr SR @name SR -pinBusAttr acc_out_reg[31] @name acc_out_reg[31][31:0] -pinBusAttr data1 @name data1[31:0] -pinBusAttr ir_reg_reg[31]_0 @name ir_reg_reg[31]_0 -pinBusAttr ir_reg_reg[31]_1 @name ir_reg_reg[31]_1[31:0] -pinBusAttr ir_reg_reg[31]_2 @name ir_reg_reg[31]_2 -pinBusAttr ir_reg_reg[4]_0 @name ir_reg_reg[4]_0[4:0] -pinBusAttr pc_out_OBUF @name pc_out_OBUF[31:0] -pinBusAttr pc_out_reg[11] @name pc_out_reg[11][3:0] -pinBusAttr pc_out_reg[15] @name pc_out_reg[15][3:0] -pinBusAttr pc_out_reg[19] @name pc_out_reg[19][3:0] -pinBusAttr pc_out_reg[23] @name pc_out_reg[23][3:0] -pinBusAttr pc_out_reg[27] @name pc_out_reg[27][3:0] -pinBusAttr pc_out_reg[31] @name pc_out_reg[31][3:0] -pinBusAttr pc_out_reg[7] @name pc_out_reg[7][3:0] -pg 1 -lvl 6 -x 2060 -y 2840
load inst u_mem memory work:memory:NOFILE -autohide -attr @cell(#000000) memory -pinBusAttr ADDRBWRADDR @name ADDRBWRADDR[4:0] -pinBusAttr Q @name Q[31:0] -pinBusAttr WEBWE @name WEBWE -pinBusAttr ram_reg_0 @name ram_reg_0[31:0] -pg 1 -lvl 5 -x 1590 -y 3020
load inst u_pc program_counter work:program_counter:NOFILE -autohide -attr @cell(#000000) program_counter -pinBusAttr O @name O[3:0] -pinBusAttr SR @name SR -pinBusAttr pc_out_OBUF @name pc_out_OBUF[31:0] -pinBusAttr pc_out_reg[11]_0 @name pc_out_reg[11]_0[3:0] -pinBusAttr pc_out_reg[15]_0 @name pc_out_reg[15]_0[3:0] -pinBusAttr pc_out_reg[19]_0 @name pc_out_reg[19]_0[3:0] -pinBusAttr pc_out_reg[23]_0 @name pc_out_reg[23]_0[3:0] -pinBusAttr pc_out_reg[27]_0 @name pc_out_reg[27]_0[3:0] -pinBusAttr pc_out_reg[31]_0 @name pc_out_reg[31]_0[3:0] -pinBusAttr pc_out_reg[7]_0 @name pc_out_reg[7]_0[3:0] -pg 1 -lvl 3 -x 650 -y 2980
load net acc_out[0] -attr @rip 0 -port acc_out[0] -pin acc_out_OBUF[0]_inst O
load net acc_out[10] -attr @rip 10 -port acc_out[10] -pin acc_out_OBUF[10]_inst O
load net acc_out[11] -attr @rip 11 -port acc_out[11] -pin acc_out_OBUF[11]_inst O
load net acc_out[12] -attr @rip 12 -port acc_out[12] -pin acc_out_OBUF[12]_inst O
load net acc_out[13] -attr @rip 13 -port acc_out[13] -pin acc_out_OBUF[13]_inst O
load net acc_out[14] -attr @rip 14 -port acc_out[14] -pin acc_out_OBUF[14]_inst O
load net acc_out[15] -attr @rip 15 -port acc_out[15] -pin acc_out_OBUF[15]_inst O
load net acc_out[16] -attr @rip 16 -port acc_out[16] -pin acc_out_OBUF[16]_inst O
load net acc_out[17] -attr @rip 17 -port acc_out[17] -pin acc_out_OBUF[17]_inst O
load net acc_out[18] -attr @rip 18 -port acc_out[18] -pin acc_out_OBUF[18]_inst O
load net acc_out[19] -attr @rip 19 -port acc_out[19] -pin acc_out_OBUF[19]_inst O
load net acc_out[1] -attr @rip 1 -port acc_out[1] -pin acc_out_OBUF[1]_inst O
load net acc_out[20] -attr @rip 20 -port acc_out[20] -pin acc_out_OBUF[20]_inst O
load net acc_out[21] -attr @rip 21 -port acc_out[21] -pin acc_out_OBUF[21]_inst O
load net acc_out[22] -attr @rip 22 -port acc_out[22] -pin acc_out_OBUF[22]_inst O
load net acc_out[23] -attr @rip 23 -port acc_out[23] -pin acc_out_OBUF[23]_inst O
load net acc_out[24] -attr @rip 24 -port acc_out[24] -pin acc_out_OBUF[24]_inst O
load net acc_out[25] -attr @rip 25 -port acc_out[25] -pin acc_out_OBUF[25]_inst O
load net acc_out[26] -attr @rip 26 -port acc_out[26] -pin acc_out_OBUF[26]_inst O
load net acc_out[27] -attr @rip 27 -port acc_out[27] -pin acc_out_OBUF[27]_inst O
load net acc_out[28] -attr @rip 28 -port acc_out[28] -pin acc_out_OBUF[28]_inst O
load net acc_out[29] -attr @rip 29 -port acc_out[29] -pin acc_out_OBUF[29]_inst O
load net acc_out[2] -attr @rip 2 -port acc_out[2] -pin acc_out_OBUF[2]_inst O
load net acc_out[30] -attr @rip 30 -port acc_out[30] -pin acc_out_OBUF[30]_inst O
load net acc_out[31] -attr @rip 31 -port acc_out[31] -pin acc_out_OBUF[31]_inst O
load net acc_out[3] -attr @rip 3 -port acc_out[3] -pin acc_out_OBUF[3]_inst O
load net acc_out[4] -attr @rip 4 -port acc_out[4] -pin acc_out_OBUF[4]_inst O
load net acc_out[5] -attr @rip 5 -port acc_out[5] -pin acc_out_OBUF[5]_inst O
load net acc_out[6] -attr @rip 6 -port acc_out[6] -pin acc_out_OBUF[6]_inst O
load net acc_out[7] -attr @rip 7 -port acc_out[7] -pin acc_out_OBUF[7]_inst O
load net acc_out[8] -attr @rip 8 -port acc_out[8] -pin acc_out_OBUF[8]_inst O
load net acc_out[9] -attr @rip 9 -port acc_out[9] -pin acc_out_OBUF[9]_inst O
load net acc_out_OBUF[0] -attr @rip Q[0] -pin acc_out_OBUF[0]_inst I -pin u_acc Q[0] -pin u_alu data_in[0] -pin u_ir acc_out_reg[31][0] -pin u_mem Q[0]
load net acc_out_OBUF[10] -attr @rip Q[10] -pin acc_out_OBUF[10]_inst I -pin u_acc Q[10] -pin u_alu data_in[10] -pin u_ir acc_out_reg[31][10] -pin u_mem Q[10]
load net acc_out_OBUF[11] -attr @rip Q[11] -pin acc_out_OBUF[11]_inst I -pin u_acc Q[11] -pin u_alu data_in[11] -pin u_ir acc_out_reg[31][11] -pin u_mem Q[11]
load net acc_out_OBUF[12] -attr @rip Q[12] -pin acc_out_OBUF[12]_inst I -pin u_acc Q[12] -pin u_alu data_in[12] -pin u_ir acc_out_reg[31][12] -pin u_mem Q[12]
load net acc_out_OBUF[13] -attr @rip Q[13] -pin acc_out_OBUF[13]_inst I -pin u_acc Q[13] -pin u_alu data_in[13] -pin u_ir acc_out_reg[31][13] -pin u_mem Q[13]
load net acc_out_OBUF[14] -attr @rip Q[14] -pin acc_out_OBUF[14]_inst I -pin u_acc Q[14] -pin u_alu data_in[14] -pin u_ir acc_out_reg[31][14] -pin u_mem Q[14]
load net acc_out_OBUF[15] -attr @rip Q[15] -pin acc_out_OBUF[15]_inst I -pin u_acc Q[15] -pin u_alu data_in[15] -pin u_ir acc_out_reg[31][15] -pin u_mem Q[15]
load net acc_out_OBUF[16] -attr @rip Q[16] -pin acc_out_OBUF[16]_inst I -pin u_acc Q[16] -pin u_alu data_in[16] -pin u_ir acc_out_reg[31][16] -pin u_mem Q[16]
load net acc_out_OBUF[17] -attr @rip Q[17] -pin acc_out_OBUF[17]_inst I -pin u_acc Q[17] -pin u_alu data_in[17] -pin u_ir acc_out_reg[31][17] -pin u_mem Q[17]
load net acc_out_OBUF[18] -attr @rip Q[18] -pin acc_out_OBUF[18]_inst I -pin u_acc Q[18] -pin u_alu data_in[18] -pin u_ir acc_out_reg[31][18] -pin u_mem Q[18]
load net acc_out_OBUF[19] -attr @rip Q[19] -pin acc_out_OBUF[19]_inst I -pin u_acc Q[19] -pin u_alu data_in[19] -pin u_ir acc_out_reg[31][19] -pin u_mem Q[19]
load net acc_out_OBUF[1] -attr @rip Q[1] -pin acc_out_OBUF[1]_inst I -pin u_acc Q[1] -pin u_alu data_in[1] -pin u_ir acc_out_reg[31][1] -pin u_mem Q[1]
load net acc_out_OBUF[20] -attr @rip Q[20] -pin acc_out_OBUF[20]_inst I -pin u_acc Q[20] -pin u_alu data_in[20] -pin u_ir acc_out_reg[31][20] -pin u_mem Q[20]
load net acc_out_OBUF[21] -attr @rip Q[21] -pin acc_out_OBUF[21]_inst I -pin u_acc Q[21] -pin u_alu data_in[21] -pin u_ir acc_out_reg[31][21] -pin u_mem Q[21]
load net acc_out_OBUF[22] -attr @rip Q[22] -pin acc_out_OBUF[22]_inst I -pin u_acc Q[22] -pin u_alu data_in[22] -pin u_ir acc_out_reg[31][22] -pin u_mem Q[22]
load net acc_out_OBUF[23] -attr @rip Q[23] -pin acc_out_OBUF[23]_inst I -pin u_acc Q[23] -pin u_alu data_in[23] -pin u_ir acc_out_reg[31][23] -pin u_mem Q[23]
load net acc_out_OBUF[24] -attr @rip Q[24] -pin acc_out_OBUF[24]_inst I -pin u_acc Q[24] -pin u_alu data_in[24] -pin u_ir acc_out_reg[31][24] -pin u_mem Q[24]
load net acc_out_OBUF[25] -attr @rip Q[25] -pin acc_out_OBUF[25]_inst I -pin u_acc Q[25] -pin u_alu data_in[25] -pin u_ir acc_out_reg[31][25] -pin u_mem Q[25]
load net acc_out_OBUF[26] -attr @rip Q[26] -pin acc_out_OBUF[26]_inst I -pin u_acc Q[26] -pin u_alu data_in[26] -pin u_ir acc_out_reg[31][26] -pin u_mem Q[26]
load net acc_out_OBUF[27] -attr @rip Q[27] -pin acc_out_OBUF[27]_inst I -pin u_acc Q[27] -pin u_alu data_in[27] -pin u_ir acc_out_reg[31][27] -pin u_mem Q[27]
load net acc_out_OBUF[28] -attr @rip Q[28] -pin acc_out_OBUF[28]_inst I -pin u_acc Q[28] -pin u_alu data_in[28] -pin u_ir acc_out_reg[31][28] -pin u_mem Q[28]
load net acc_out_OBUF[29] -attr @rip Q[29] -pin acc_out_OBUF[29]_inst I -pin u_acc Q[29] -pin u_alu data_in[29] -pin u_ir acc_out_reg[31][29] -pin u_mem Q[29]
load net acc_out_OBUF[2] -attr @rip Q[2] -pin acc_out_OBUF[2]_inst I -pin u_acc Q[2] -pin u_alu data_in[2] -pin u_ir acc_out_reg[31][2] -pin u_mem Q[2]
load net acc_out_OBUF[30] -attr @rip Q[30] -pin acc_out_OBUF[30]_inst I -pin u_acc Q[30] -pin u_alu data_in[30] -pin u_ir acc_out_reg[31][30] -pin u_mem Q[30]
load net acc_out_OBUF[31] -attr @rip Q[31] -pin acc_out_OBUF[31]_inst I -pin u_acc Q[31] -pin u_ir acc_out_reg[31][31] -pin u_mem Q[31]
load net acc_out_OBUF[3] -attr @rip Q[3] -pin acc_out_OBUF[3]_inst I -pin u_acc Q[3] -pin u_alu data_in[3] -pin u_ir acc_out_reg[31][3] -pin u_mem Q[3]
load net acc_out_OBUF[4] -attr @rip Q[4] -pin acc_out_OBUF[4]_inst I -pin u_acc Q[4] -pin u_alu data_in[4] -pin u_ir acc_out_reg[31][4] -pin u_mem Q[4]
load net acc_out_OBUF[5] -attr @rip Q[5] -pin acc_out_OBUF[5]_inst I -pin u_acc Q[5] -pin u_alu data_in[5] -pin u_ir acc_out_reg[31][5] -pin u_mem Q[5]
load net acc_out_OBUF[6] -attr @rip Q[6] -pin acc_out_OBUF[6]_inst I -pin u_acc Q[6] -pin u_alu data_in[6] -pin u_ir acc_out_reg[31][6] -pin u_mem Q[6]
load net acc_out_OBUF[7] -attr @rip Q[7] -pin acc_out_OBUF[7]_inst I -pin u_acc Q[7] -pin u_alu data_in[7] -pin u_ir acc_out_reg[31][7] -pin u_mem Q[7]
load net acc_out_OBUF[8] -attr @rip Q[8] -pin acc_out_OBUF[8]_inst I -pin u_acc Q[8] -pin u_alu data_in[8] -pin u_ir acc_out_reg[31][8] -pin u_mem Q[8]
load net acc_out_OBUF[9] -attr @rip Q[9] -pin acc_out_OBUF[9]_inst I -pin u_acc Q[9] -pin u_alu data_in[9] -pin u_ir acc_out_reg[31][9] -pin u_mem Q[9]
load net clk -port clk -pin clk_IBUF_inst I
netloc clk 1 0 1 NJ 2980
load net clk_IBUF -pin clk_IBUF_BUFG_inst I -pin clk_IBUF_inst O
netloc clk_IBUF 1 1 1 NJ 2980
load net clk_IBUF_BUFG -pin clk_IBUF_BUFG_inst O -pin u_acc clk -pin u_ctrl clk -pin u_ir clk -pin u_mem clk -pin u_pc clk
netloc clk_IBUF_BUFG 1 2 5 360 2930 850 2950 1400 2970 1850 2650 NJ
load net data1[0] -attr @rip data1[0] -pin u_alu data1[0] -pin u_ir data1[0]
load net data1[10] -attr @rip data1[10] -pin u_alu data1[10] -pin u_ir data1[10]
load net data1[11] -attr @rip data1[11] -pin u_alu data1[11] -pin u_ir data1[11]
load net data1[12] -attr @rip data1[12] -pin u_alu data1[12] -pin u_ir data1[12]
load net data1[13] -attr @rip data1[13] -pin u_alu data1[13] -pin u_ir data1[13]
load net data1[14] -attr @rip data1[14] -pin u_alu data1[14] -pin u_ir data1[14]
load net data1[15] -attr @rip data1[15] -pin u_alu data1[15] -pin u_ir data1[15]
load net data1[16] -attr @rip data1[16] -pin u_alu data1[16] -pin u_ir data1[16]
load net data1[17] -attr @rip data1[17] -pin u_alu data1[17] -pin u_ir data1[17]
load net data1[18] -attr @rip data1[18] -pin u_alu data1[18] -pin u_ir data1[18]
load net data1[19] -attr @rip data1[19] -pin u_alu data1[19] -pin u_ir data1[19]
load net data1[1] -attr @rip data1[1] -pin u_alu data1[1] -pin u_ir data1[1]
load net data1[20] -attr @rip data1[20] -pin u_alu data1[20] -pin u_ir data1[20]
load net data1[21] -attr @rip data1[21] -pin u_alu data1[21] -pin u_ir data1[21]
load net data1[22] -attr @rip data1[22] -pin u_alu data1[22] -pin u_ir data1[22]
load net data1[23] -attr @rip data1[23] -pin u_alu data1[23] -pin u_ir data1[23]
load net data1[24] -attr @rip data1[24] -pin u_alu data1[24] -pin u_ir data1[24]
load net data1[25] -attr @rip data1[25] -pin u_alu data1[25] -pin u_ir data1[25]
load net data1[26] -attr @rip data1[26] -pin u_alu data1[26] -pin u_ir data1[26]
load net data1[27] -attr @rip data1[27] -pin u_alu data1[27] -pin u_ir data1[27]
load net data1[28] -attr @rip data1[28] -pin u_alu data1[28] -pin u_ir data1[28]
load net data1[29] -attr @rip data1[29] -pin u_alu data1[29] -pin u_ir data1[29]
load net data1[2] -attr @rip data1[2] -pin u_alu data1[2] -pin u_ir data1[2]
load net data1[30] -attr @rip data1[30] -pin u_alu data1[30] -pin u_ir data1[30]
load net data1[31] -attr @rip data1[31] -pin u_alu data1[31] -pin u_ir data1[31]
load net data1[3] -attr @rip data1[3] -pin u_alu data1[3] -pin u_ir data1[3]
load net data1[4] -attr @rip data1[4] -pin u_alu data1[4] -pin u_ir data1[4]
load net data1[5] -attr @rip data1[5] -pin u_alu data1[5] -pin u_ir data1[5]
load net data1[6] -attr @rip data1[6] -pin u_alu data1[6] -pin u_ir data1[6]
load net data1[7] -attr @rip data1[7] -pin u_alu data1[7] -pin u_ir data1[7]
load net data1[8] -attr @rip data1[8] -pin u_alu data1[8] -pin u_ir data1[8]
load net data1[9] -attr @rip data1[9] -pin u_alu data1[9] -pin u_ir data1[9]
load net halt -port halt -pin halt_OBUF_inst O
netloc halt 1 8 1 NJ 2910
load net halt_OBUF -pin halt_OBUF_inst I -pin u_ir halt_OBUF
netloc halt_OBUF 1 6 2 NJ 2910 NJ
load net ld_ac -attr @rip E[0] -pin u_acc E[0] -pin u_ir E[0]
netloc ld_ac 1 6 1 2440 2610n
load net ld_ir -attr @rip E[0] -pin u_ctrl E[0] -pin u_ir ir_reg_reg[31]_2[0]
netloc ld_ir 1 4 2 1320J 2910 1770
load net mem_addr[0] -attr @rip ADDRBWRADDR[0] -pin u_ctrl ADDRBWRADDR[0] -pin u_mem ADDRBWRADDR[0]
load net mem_addr[1] -attr @rip ADDRBWRADDR[1] -pin u_ctrl ADDRBWRADDR[1] -pin u_mem ADDRBWRADDR[1]
load net mem_addr[2] -attr @rip ADDRBWRADDR[2] -pin u_ctrl ADDRBWRADDR[2] -pin u_mem ADDRBWRADDR[2]
load net mem_addr[3] -attr @rip ADDRBWRADDR[3] -pin u_ctrl ADDRBWRADDR[3] -pin u_mem ADDRBWRADDR[3]
load net mem_addr[4] -attr @rip ADDRBWRADDR[4] -pin u_ctrl ADDRBWRADDR[4] -pin u_mem ADDRBWRADDR[4]
load net mem_data_out[0] -attr @rip ram_reg_0[0] -pin u_acc data_out[0] -pin u_ir ir_reg_reg[31]_1[0] -pin u_mem ram_reg_0[0]
load net mem_data_out[10] -attr @rip ram_reg_0[10] -pin u_acc data_out[10] -pin u_ir ir_reg_reg[31]_1[10] -pin u_mem ram_reg_0[10]
load net mem_data_out[11] -attr @rip ram_reg_0[11] -pin u_acc data_out[11] -pin u_ir ir_reg_reg[31]_1[11] -pin u_mem ram_reg_0[11]
load net mem_data_out[12] -attr @rip ram_reg_0[12] -pin u_acc data_out[12] -pin u_ir ir_reg_reg[31]_1[12] -pin u_mem ram_reg_0[12]
load net mem_data_out[13] -attr @rip ram_reg_0[13] -pin u_acc data_out[13] -pin u_ir ir_reg_reg[31]_1[13] -pin u_mem ram_reg_0[13]
load net mem_data_out[14] -attr @rip ram_reg_0[14] -pin u_acc data_out[14] -pin u_ir ir_reg_reg[31]_1[14] -pin u_mem ram_reg_0[14]
load net mem_data_out[15] -attr @rip ram_reg_0[15] -pin u_acc data_out[15] -pin u_ir ir_reg_reg[31]_1[15] -pin u_mem ram_reg_0[15]
load net mem_data_out[16] -attr @rip ram_reg_0[16] -pin u_acc data_out[16] -pin u_ir ir_reg_reg[31]_1[16] -pin u_mem ram_reg_0[16]
load net mem_data_out[17] -attr @rip ram_reg_0[17] -pin u_acc data_out[17] -pin u_ir ir_reg_reg[31]_1[17] -pin u_mem ram_reg_0[17]
load net mem_data_out[18] -attr @rip ram_reg_0[18] -pin u_acc data_out[18] -pin u_ir ir_reg_reg[31]_1[18] -pin u_mem ram_reg_0[18]
load net mem_data_out[19] -attr @rip ram_reg_0[19] -pin u_acc data_out[19] -pin u_ir ir_reg_reg[31]_1[19] -pin u_mem ram_reg_0[19]
load net mem_data_out[1] -attr @rip ram_reg_0[1] -pin u_acc data_out[1] -pin u_ir ir_reg_reg[31]_1[1] -pin u_mem ram_reg_0[1]
load net mem_data_out[20] -attr @rip ram_reg_0[20] -pin u_acc data_out[20] -pin u_ir ir_reg_reg[31]_1[20] -pin u_mem ram_reg_0[20]
load net mem_data_out[21] -attr @rip ram_reg_0[21] -pin u_acc data_out[21] -pin u_ir ir_reg_reg[31]_1[21] -pin u_mem ram_reg_0[21]
load net mem_data_out[22] -attr @rip ram_reg_0[22] -pin u_acc data_out[22] -pin u_ir ir_reg_reg[31]_1[22] -pin u_mem ram_reg_0[22]
load net mem_data_out[23] -attr @rip ram_reg_0[23] -pin u_acc data_out[23] -pin u_ir ir_reg_reg[31]_1[23] -pin u_mem ram_reg_0[23]
load net mem_data_out[24] -attr @rip ram_reg_0[24] -pin u_acc data_out[24] -pin u_ir ir_reg_reg[31]_1[24] -pin u_mem ram_reg_0[24]
load net mem_data_out[25] -attr @rip ram_reg_0[25] -pin u_acc data_out[25] -pin u_ir ir_reg_reg[31]_1[25] -pin u_mem ram_reg_0[25]
load net mem_data_out[26] -attr @rip ram_reg_0[26] -pin u_acc data_out[26] -pin u_ir ir_reg_reg[31]_1[26] -pin u_mem ram_reg_0[26]
load net mem_data_out[27] -attr @rip ram_reg_0[27] -pin u_acc data_out[27] -pin u_ir ir_reg_reg[31]_1[27] -pin u_mem ram_reg_0[27]
load net mem_data_out[28] -attr @rip ram_reg_0[28] -pin u_acc data_out[28] -pin u_ir ir_reg_reg[31]_1[28] -pin u_mem ram_reg_0[28]
load net mem_data_out[29] -attr @rip ram_reg_0[29] -pin u_acc data_out[29] -pin u_ir ir_reg_reg[31]_1[29] -pin u_mem ram_reg_0[29]
load net mem_data_out[2] -attr @rip ram_reg_0[2] -pin u_acc data_out[2] -pin u_ir ir_reg_reg[31]_1[2] -pin u_mem ram_reg_0[2]
load net mem_data_out[30] -attr @rip ram_reg_0[30] -pin u_acc data_out[30] -pin u_ir ir_reg_reg[31]_1[30] -pin u_mem ram_reg_0[30]
load net mem_data_out[31] -attr @rip ram_reg_0[31] -pin u_acc data_out[31] -pin u_ir ir_reg_reg[31]_1[31] -pin u_mem ram_reg_0[31]
load net mem_data_out[3] -attr @rip ram_reg_0[3] -pin u_acc data_out[3] -pin u_ir ir_reg_reg[31]_1[3] -pin u_mem ram_reg_0[3]
load net mem_data_out[4] -attr @rip ram_reg_0[4] -pin u_acc data_out[4] -pin u_ir ir_reg_reg[31]_1[4] -pin u_mem ram_reg_0[4]
load net mem_data_out[5] -attr @rip ram_reg_0[5] -pin u_acc data_out[5] -pin u_ir ir_reg_reg[31]_1[5] -pin u_mem ram_reg_0[5]
load net mem_data_out[6] -attr @rip ram_reg_0[6] -pin u_acc data_out[6] -pin u_ir ir_reg_reg[31]_1[6] -pin u_mem ram_reg_0[6]
load net mem_data_out[7] -attr @rip ram_reg_0[7] -pin u_acc data_out[7] -pin u_ir ir_reg_reg[31]_1[7] -pin u_mem ram_reg_0[7]
load net mem_data_out[8] -attr @rip ram_reg_0[8] -pin u_acc data_out[8] -pin u_ir ir_reg_reg[31]_1[8] -pin u_mem ram_reg_0[8]
load net mem_data_out[9] -attr @rip ram_reg_0[9] -pin u_acc data_out[9] -pin u_ir ir_reg_reg[31]_1[9] -pin u_mem ram_reg_0[9]
load net out[0] -attr @rip D[0] -pin u_acc D[0] -pin u_ir D[0]
load net out[10] -attr @rip D[10] -pin u_acc D[10] -pin u_ir D[10]
load net out[11] -attr @rip D[11] -pin u_acc D[11] -pin u_ir D[11]
load net out[12] -attr @rip D[12] -pin u_acc D[12] -pin u_ir D[12]
load net out[13] -attr @rip D[13] -pin u_acc D[13] -pin u_ir D[13]
load net out[14] -attr @rip D[14] -pin u_acc D[14] -pin u_ir D[14]
load net out[15] -attr @rip D[15] -pin u_acc D[15] -pin u_ir D[15]
load net out[16] -attr @rip D[16] -pin u_acc D[16] -pin u_ir D[16]
load net out[17] -attr @rip D[17] -pin u_acc D[17] -pin u_ir D[17]
load net out[18] -attr @rip D[18] -pin u_acc D[18] -pin u_ir D[18]
load net out[19] -attr @rip D[19] -pin u_acc D[19] -pin u_ir D[19]
load net out[1] -attr @rip D[1] -pin u_acc D[1] -pin u_ir D[1]
load net out[20] -attr @rip D[20] -pin u_acc D[20] -pin u_ir D[20]
load net out[21] -attr @rip D[21] -pin u_acc D[21] -pin u_ir D[21]
load net out[22] -attr @rip D[22] -pin u_acc D[22] -pin u_ir D[22]
load net out[23] -attr @rip D[23] -pin u_acc D[23] -pin u_ir D[23]
load net out[24] -attr @rip D[24] -pin u_acc D[24] -pin u_ir D[24]
load net out[25] -attr @rip D[25] -pin u_acc D[25] -pin u_ir D[25]
load net out[26] -attr @rip D[26] -pin u_acc D[26] -pin u_ir D[26]
load net out[27] -attr @rip D[27] -pin u_acc D[27] -pin u_ir D[27]
load net out[28] -attr @rip D[28] -pin u_acc D[28] -pin u_ir D[28]
load net out[29] -attr @rip D[29] -pin u_acc D[29] -pin u_ir D[29]
load net out[2] -attr @rip D[2] -pin u_acc D[2] -pin u_ir D[2]
load net out[30] -attr @rip D[30] -pin u_acc D[30] -pin u_ir D[30]
load net out[31] -attr @rip D[31] -pin u_acc D[31] -pin u_ir D[31]
load net out[3] -attr @rip D[3] -pin u_acc D[3] -pin u_ir D[3]
load net out[4] -attr @rip D[4] -pin u_acc D[4] -pin u_ir D[4]
load net out[5] -attr @rip D[5] -pin u_acc D[5] -pin u_ir D[5]
load net out[6] -attr @rip D[6] -pin u_acc D[6] -pin u_ir D[6]
load net out[7] -attr @rip D[7] -pin u_acc D[7] -pin u_ir D[7]
load net out[8] -attr @rip D[8] -pin u_acc D[8] -pin u_ir D[8]
load net out[9] -attr @rip D[9] -pin u_acc D[9] -pin u_ir D[9]
load net p_1_in -attr @rip Q[0] -pin u_ctrl Q[0] -pin u_ir Q[0]
load net p_1_in2_in -attr @rip Q[1] -pin u_ctrl Q[1] -pin u_ir Q[1]
load net p_2_in -attr @rip Q[2] -pin u_ctrl Q[2] -pin u_ir Q[2]
load net pc_out[0] -attr @rip 0 -port pc_out[0] -pin pc_out_OBUF[0]_inst O
load net pc_out[10] -attr @rip 10 -port pc_out[10] -pin pc_out_OBUF[10]_inst O
load net pc_out[11] -attr @rip 11 -port pc_out[11] -pin pc_out_OBUF[11]_inst O
load net pc_out[12] -attr @rip 12 -port pc_out[12] -pin pc_out_OBUF[12]_inst O
load net pc_out[13] -attr @rip 13 -port pc_out[13] -pin pc_out_OBUF[13]_inst O
load net pc_out[14] -attr @rip 14 -port pc_out[14] -pin pc_out_OBUF[14]_inst O
load net pc_out[15] -attr @rip 15 -port pc_out[15] -pin pc_out_OBUF[15]_inst O
load net pc_out[16] -attr @rip 16 -port pc_out[16] -pin pc_out_OBUF[16]_inst O
load net pc_out[17] -attr @rip 17 -port pc_out[17] -pin pc_out_OBUF[17]_inst O
load net pc_out[18] -attr @rip 18 -port pc_out[18] -pin pc_out_OBUF[18]_inst O
load net pc_out[19] -attr @rip 19 -port pc_out[19] -pin pc_out_OBUF[19]_inst O
load net pc_out[1] -attr @rip 1 -port pc_out[1] -pin pc_out_OBUF[1]_inst O
load net pc_out[20] -attr @rip 20 -port pc_out[20] -pin pc_out_OBUF[20]_inst O
load net pc_out[21] -attr @rip 21 -port pc_out[21] -pin pc_out_OBUF[21]_inst O
load net pc_out[22] -attr @rip 22 -port pc_out[22] -pin pc_out_OBUF[22]_inst O
load net pc_out[23] -attr @rip 23 -port pc_out[23] -pin pc_out_OBUF[23]_inst O
load net pc_out[24] -attr @rip 24 -port pc_out[24] -pin pc_out_OBUF[24]_inst O
load net pc_out[25] -attr @rip 25 -port pc_out[25] -pin pc_out_OBUF[25]_inst O
load net pc_out[26] -attr @rip 26 -port pc_out[26] -pin pc_out_OBUF[26]_inst O
load net pc_out[27] -attr @rip 27 -port pc_out[27] -pin pc_out_OBUF[27]_inst O
load net pc_out[28] -attr @rip 28 -port pc_out[28] -pin pc_out_OBUF[28]_inst O
load net pc_out[29] -attr @rip 29 -port pc_out[29] -pin pc_out_OBUF[29]_inst O
load net pc_out[2] -attr @rip 2 -port pc_out[2] -pin pc_out_OBUF[2]_inst O
load net pc_out[30] -attr @rip 30 -port pc_out[30] -pin pc_out_OBUF[30]_inst O
load net pc_out[31] -attr @rip 31 -port pc_out[31] -pin pc_out_OBUF[31]_inst O
load net pc_out[3] -attr @rip 3 -port pc_out[3] -pin pc_out_OBUF[3]_inst O
load net pc_out[4] -attr @rip 4 -port pc_out[4] -pin pc_out_OBUF[4]_inst O
load net pc_out[5] -attr @rip 5 -port pc_out[5] -pin pc_out_OBUF[5]_inst O
load net pc_out[6] -attr @rip 6 -port pc_out[6] -pin pc_out_OBUF[6]_inst O
load net pc_out[7] -attr @rip 7 -port pc_out[7] -pin pc_out_OBUF[7]_inst O
load net pc_out[8] -attr @rip 8 -port pc_out[8] -pin pc_out_OBUF[8]_inst O
load net pc_out[9] -attr @rip 9 -port pc_out[9] -pin pc_out_OBUF[9]_inst O
load net pc_out_OBUF[0] -attr @rip pc_out_OBUF[0] -pin pc_out_OBUF[0]_inst I -pin u_ctrl pc_out_OBUF[0] -pin u_ir pc_out_OBUF[0] -pin u_pc pc_out_OBUF[0]
load net pc_out_OBUF[10] -attr @rip pc_out_OBUF[10] -pin pc_out_OBUF[10]_inst I -pin u_ir pc_out_OBUF[10] -pin u_pc pc_out_OBUF[10]
load net pc_out_OBUF[11] -attr @rip pc_out_OBUF[11] -pin pc_out_OBUF[11]_inst I -pin u_ir pc_out_OBUF[11] -pin u_pc pc_out_OBUF[11]
load net pc_out_OBUF[12] -attr @rip pc_out_OBUF[12] -pin pc_out_OBUF[12]_inst I -pin u_ir pc_out_OBUF[12] -pin u_pc pc_out_OBUF[12]
load net pc_out_OBUF[13] -attr @rip pc_out_OBUF[13] -pin pc_out_OBUF[13]_inst I -pin u_ir pc_out_OBUF[13] -pin u_pc pc_out_OBUF[13]
load net pc_out_OBUF[14] -attr @rip pc_out_OBUF[14] -pin pc_out_OBUF[14]_inst I -pin u_ir pc_out_OBUF[14] -pin u_pc pc_out_OBUF[14]
load net pc_out_OBUF[15] -attr @rip pc_out_OBUF[15] -pin pc_out_OBUF[15]_inst I -pin u_ir pc_out_OBUF[15] -pin u_pc pc_out_OBUF[15]
load net pc_out_OBUF[16] -attr @rip pc_out_OBUF[16] -pin pc_out_OBUF[16]_inst I -pin u_ir pc_out_OBUF[16] -pin u_pc pc_out_OBUF[16]
load net pc_out_OBUF[17] -attr @rip pc_out_OBUF[17] -pin pc_out_OBUF[17]_inst I -pin u_ir pc_out_OBUF[17] -pin u_pc pc_out_OBUF[17]
load net pc_out_OBUF[18] -attr @rip pc_out_OBUF[18] -pin pc_out_OBUF[18]_inst I -pin u_ir pc_out_OBUF[18] -pin u_pc pc_out_OBUF[18]
load net pc_out_OBUF[19] -attr @rip pc_out_OBUF[19] -pin pc_out_OBUF[19]_inst I -pin u_ir pc_out_OBUF[19] -pin u_pc pc_out_OBUF[19]
load net pc_out_OBUF[1] -attr @rip pc_out_OBUF[1] -pin pc_out_OBUF[1]_inst I -pin u_ctrl pc_out_OBUF[1] -pin u_ir pc_out_OBUF[1] -pin u_pc pc_out_OBUF[1]
load net pc_out_OBUF[20] -attr @rip pc_out_OBUF[20] -pin pc_out_OBUF[20]_inst I -pin u_ir pc_out_OBUF[20] -pin u_pc pc_out_OBUF[20]
load net pc_out_OBUF[21] -attr @rip pc_out_OBUF[21] -pin pc_out_OBUF[21]_inst I -pin u_ir pc_out_OBUF[21] -pin u_pc pc_out_OBUF[21]
load net pc_out_OBUF[22] -attr @rip pc_out_OBUF[22] -pin pc_out_OBUF[22]_inst I -pin u_ir pc_out_OBUF[22] -pin u_pc pc_out_OBUF[22]
load net pc_out_OBUF[23] -attr @rip pc_out_OBUF[23] -pin pc_out_OBUF[23]_inst I -pin u_ir pc_out_OBUF[23] -pin u_pc pc_out_OBUF[23]
load net pc_out_OBUF[24] -attr @rip pc_out_OBUF[24] -pin pc_out_OBUF[24]_inst I -pin u_ir pc_out_OBUF[24] -pin u_pc pc_out_OBUF[24]
load net pc_out_OBUF[25] -attr @rip pc_out_OBUF[25] -pin pc_out_OBUF[25]_inst I -pin u_ir pc_out_OBUF[25] -pin u_pc pc_out_OBUF[25]
load net pc_out_OBUF[26] -attr @rip pc_out_OBUF[26] -pin pc_out_OBUF[26]_inst I -pin u_ir pc_out_OBUF[26] -pin u_pc pc_out_OBUF[26]
load net pc_out_OBUF[27] -attr @rip pc_out_OBUF[27] -pin pc_out_OBUF[27]_inst I -pin u_ir pc_out_OBUF[27] -pin u_pc pc_out_OBUF[27]
load net pc_out_OBUF[28] -attr @rip pc_out_OBUF[28] -pin pc_out_OBUF[28]_inst I -pin u_ir pc_out_OBUF[28] -pin u_pc pc_out_OBUF[28]
load net pc_out_OBUF[29] -attr @rip pc_out_OBUF[29] -pin pc_out_OBUF[29]_inst I -pin u_ir pc_out_OBUF[29] -pin u_pc pc_out_OBUF[29]
load net pc_out_OBUF[2] -attr @rip pc_out_OBUF[2] -pin pc_out_OBUF[2]_inst I -pin u_ctrl pc_out_OBUF[2] -pin u_ir pc_out_OBUF[2] -pin u_pc pc_out_OBUF[2]
load net pc_out_OBUF[30] -attr @rip pc_out_OBUF[30] -pin pc_out_OBUF[30]_inst I -pin u_ir pc_out_OBUF[30] -pin u_pc pc_out_OBUF[30]
load net pc_out_OBUF[31] -attr @rip pc_out_OBUF[31] -pin pc_out_OBUF[31]_inst I -pin u_ir pc_out_OBUF[31] -pin u_pc pc_out_OBUF[31]
load net pc_out_OBUF[3] -attr @rip pc_out_OBUF[3] -pin pc_out_OBUF[3]_inst I -pin u_ctrl pc_out_OBUF[3] -pin u_ir pc_out_OBUF[3] -pin u_pc pc_out_OBUF[3]
load net pc_out_OBUF[4] -attr @rip pc_out_OBUF[4] -pin pc_out_OBUF[4]_inst I -pin u_ctrl pc_out_OBUF[4] -pin u_ir pc_out_OBUF[4] -pin u_pc pc_out_OBUF[4]
load net pc_out_OBUF[5] -attr @rip pc_out_OBUF[5] -pin pc_out_OBUF[5]_inst I -pin u_ir pc_out_OBUF[5] -pin u_pc pc_out_OBUF[5]
load net pc_out_OBUF[6] -attr @rip pc_out_OBUF[6] -pin pc_out_OBUF[6]_inst I -pin u_ir pc_out_OBUF[6] -pin u_pc pc_out_OBUF[6]
load net pc_out_OBUF[7] -attr @rip pc_out_OBUF[7] -pin pc_out_OBUF[7]_inst I -pin u_ir pc_out_OBUF[7] -pin u_pc pc_out_OBUF[7]
load net pc_out_OBUF[8] -attr @rip pc_out_OBUF[8] -pin pc_out_OBUF[8]_inst I -pin u_ir pc_out_OBUF[8] -pin u_pc pc_out_OBUF[8]
load net pc_out_OBUF[9] -attr @rip pc_out_OBUF[9] -pin pc_out_OBUF[9]_inst I -pin u_ir pc_out_OBUF[9] -pin u_pc pc_out_OBUF[9]
load net rd -pin u_ctrl rd -pin u_mem rd
netloc rd 1 4 1 1320 3090n
load net rst -port rst -pin rst_IBUF_inst I
netloc rst 1 0 2 NJ 2910 NJ
load net rst_IBUF -attr @rip 0 -pin rst_IBUF_inst O -pin u_acc SR[0] -pin u_ctrl SS[0] -pin u_ir SR[0] -pin u_pc SR[0]
netloc rst_IBUF 1 2 5 340 2910 870 2890 NJ 2890 1890 2630 NJ
load net u_acc_n_0 -pin u_acc ir_reg_reg[29] -pin u_ir pc_out_reg[0]
netloc u_acc_n_0 1 5 3 1910 2770 2420J 2790 2800
load net u_acc_n_33 -attr @rip S[3] -pin u_acc S[3] -pin u_alu S[3]
load net u_acc_n_34 -attr @rip S[2] -pin u_acc S[2] -pin u_alu S[2]
load net u_acc_n_35 -attr @rip S[1] -pin u_acc S[1] -pin u_alu S[1]
load net u_acc_n_36 -attr @rip S[0] -pin u_acc S[0] -pin u_alu S[0]
load net u_acc_n_37 -attr @rip acc_out_reg[3]_0[3] -pin u_acc acc_out_reg[3]_0[3] -pin u_alu acc_out_reg[3][3]
load net u_acc_n_38 -attr @rip acc_out_reg[3]_0[2] -pin u_acc acc_out_reg[3]_0[2] -pin u_alu acc_out_reg[3][2]
load net u_acc_n_39 -attr @rip acc_out_reg[3]_0[1] -pin u_acc acc_out_reg[3]_0[1] -pin u_alu acc_out_reg[3][1]
load net u_acc_n_40 -attr @rip acc_out_reg[3]_0[0] -pin u_acc acc_out_reg[3]_0[0] -pin u_alu acc_out_reg[3][0]
load net u_acc_n_41 -attr @rip acc_out_reg[7]_0[3] -pin u_acc acc_out_reg[7]_0[3] -pin u_alu acc_out_reg[7][3]
load net u_acc_n_42 -attr @rip acc_out_reg[7]_0[2] -pin u_acc acc_out_reg[7]_0[2] -pin u_alu acc_out_reg[7][2]
load net u_acc_n_43 -attr @rip acc_out_reg[7]_0[1] -pin u_acc acc_out_reg[7]_0[1] -pin u_alu acc_out_reg[7][1]
load net u_acc_n_44 -attr @rip acc_out_reg[7]_0[0] -pin u_acc acc_out_reg[7]_0[0] -pin u_alu acc_out_reg[7][0]
load net u_acc_n_45 -attr @rip acc_out_reg[11]_0[3] -pin u_acc acc_out_reg[11]_0[3] -pin u_alu acc_out_reg[11][3]
load net u_acc_n_46 -attr @rip acc_out_reg[11]_0[2] -pin u_acc acc_out_reg[11]_0[2] -pin u_alu acc_out_reg[11][2]
load net u_acc_n_47 -attr @rip acc_out_reg[11]_0[1] -pin u_acc acc_out_reg[11]_0[1] -pin u_alu acc_out_reg[11][1]
load net u_acc_n_48 -attr @rip acc_out_reg[11]_0[0] -pin u_acc acc_out_reg[11]_0[0] -pin u_alu acc_out_reg[11][0]
load net u_acc_n_49 -attr @rip acc_out_reg[15]_0[3] -pin u_acc acc_out_reg[15]_0[3] -pin u_alu acc_out_reg[15][3]
load net u_acc_n_50 -attr @rip acc_out_reg[15]_0[2] -pin u_acc acc_out_reg[15]_0[2] -pin u_alu acc_out_reg[15][2]
load net u_acc_n_51 -attr @rip acc_out_reg[15]_0[1] -pin u_acc acc_out_reg[15]_0[1] -pin u_alu acc_out_reg[15][1]
load net u_acc_n_52 -attr @rip acc_out_reg[15]_0[0] -pin u_acc acc_out_reg[15]_0[0] -pin u_alu acc_out_reg[15][0]
load net u_acc_n_53 -attr @rip acc_out_reg[19]_0[3] -pin u_acc acc_out_reg[19]_0[3] -pin u_alu acc_out_reg[19][3]
load net u_acc_n_54 -attr @rip acc_out_reg[19]_0[2] -pin u_acc acc_out_reg[19]_0[2] -pin u_alu acc_out_reg[19][2]
load net u_acc_n_55 -attr @rip acc_out_reg[19]_0[1] -pin u_acc acc_out_reg[19]_0[1] -pin u_alu acc_out_reg[19][1]
load net u_acc_n_56 -attr @rip acc_out_reg[19]_0[0] -pin u_acc acc_out_reg[19]_0[0] -pin u_alu acc_out_reg[19][0]
load net u_acc_n_57 -attr @rip acc_out_reg[23]_0[3] -pin u_acc acc_out_reg[23]_0[3] -pin u_alu acc_out_reg[23][3]
load net u_acc_n_58 -attr @rip acc_out_reg[23]_0[2] -pin u_acc acc_out_reg[23]_0[2] -pin u_alu acc_out_reg[23][2]
load net u_acc_n_59 -attr @rip acc_out_reg[23]_0[1] -pin u_acc acc_out_reg[23]_0[1] -pin u_alu acc_out_reg[23][1]
load net u_acc_n_60 -attr @rip acc_out_reg[23]_0[0] -pin u_acc acc_out_reg[23]_0[0] -pin u_alu acc_out_reg[23][0]
load net u_acc_n_61 -attr @rip acc_out_reg[27]_0[3] -pin u_acc acc_out_reg[27]_0[3] -pin u_alu acc_out_reg[27][3]
load net u_acc_n_62 -attr @rip acc_out_reg[27]_0[2] -pin u_acc acc_out_reg[27]_0[2] -pin u_alu acc_out_reg[27][2]
load net u_acc_n_63 -attr @rip acc_out_reg[27]_0[1] -pin u_acc acc_out_reg[27]_0[1] -pin u_alu acc_out_reg[27][1]
load net u_acc_n_64 -attr @rip acc_out_reg[27]_0[0] -pin u_acc acc_out_reg[27]_0[0] -pin u_alu acc_out_reg[27][0]
load net u_ctrl_n_0 -attr @rip WEBWE[0] -pin u_ctrl WEBWE[0] -pin u_mem WEBWE[0]
netloc u_ctrl_n_0 1 4 1 N 3070
load net u_ir_n_0 -pin u_ir ir_reg_reg[30]_0 -pin u_pc pc_out_reg[0]_0
netloc u_ir_n_0 1 2 5 340 3270 NJ 3270 NJ 3270 NJ 3270 2480
load net u_ir_n_1 -pin u_acc pc_out_reg[0] -pin u_ir ir_reg_reg[29]_0
netloc u_ir_n_1 1 6 1 2480 2690n
load net u_ir_n_3 -attr @rip ir_reg_reg[4]_0[4] -pin u_ctrl ram_reg_0[4] -pin u_ir ir_reg_reg[4]_0[4]
load net u_ir_n_4 -attr @rip ir_reg_reg[4]_0[3] -pin u_ctrl ram_reg_0[3] -pin u_ir ir_reg_reg[4]_0[3]
load net u_ir_n_40 -attr @rip ir_reg_reg[31]_0[0] -pin u_ctrl FSM_onehot_state_reg[0]_0[0] -pin u_ir ir_reg_reg[31]_0[0]
netloc u_ir_n_40 1 3 4 890 3290 NJ 3290 NJ 3290 2440
load net u_ir_n_43 -pin u_ctrl ram_reg -pin u_ir ir_reg_reg[30]_1
netloc u_ir_n_43 1 3 4 910 3250 NJ 3250 NJ 3250 2460
load net u_ir_n_44 -attr @rip O[3] -pin u_ir O[3] -pin u_pc O[3]
load net u_ir_n_45 -attr @rip O[2] -pin u_ir O[2] -pin u_pc O[2]
load net u_ir_n_46 -attr @rip O[1] -pin u_ir O[1] -pin u_pc O[1]
load net u_ir_n_47 -attr @rip O[0] -pin u_ir O[0] -pin u_pc O[0]
load net u_ir_n_48 -attr @rip pc_out_reg[7][3] -pin u_ir pc_out_reg[7][3] -pin u_pc pc_out_reg[7]_0[3]
load net u_ir_n_49 -attr @rip pc_out_reg[7][2] -pin u_ir pc_out_reg[7][2] -pin u_pc pc_out_reg[7]_0[2]
load net u_ir_n_5 -attr @rip ir_reg_reg[4]_0[2] -pin u_ctrl ram_reg_0[2] -pin u_ir ir_reg_reg[4]_0[2]
load net u_ir_n_50 -attr @rip pc_out_reg[7][1] -pin u_ir pc_out_reg[7][1] -pin u_pc pc_out_reg[7]_0[1]
load net u_ir_n_51 -attr @rip pc_out_reg[7][0] -pin u_ir pc_out_reg[7][0] -pin u_pc pc_out_reg[7]_0[0]
load net u_ir_n_52 -attr @rip pc_out_reg[11][3] -pin u_ir pc_out_reg[11][3] -pin u_pc pc_out_reg[11]_0[3]
load net u_ir_n_53 -attr @rip pc_out_reg[11][2] -pin u_ir pc_out_reg[11][2] -pin u_pc pc_out_reg[11]_0[2]
load net u_ir_n_54 -attr @rip pc_out_reg[11][1] -pin u_ir pc_out_reg[11][1] -pin u_pc pc_out_reg[11]_0[1]
load net u_ir_n_55 -attr @rip pc_out_reg[11][0] -pin u_ir pc_out_reg[11][0] -pin u_pc pc_out_reg[11]_0[0]
load net u_ir_n_56 -attr @rip pc_out_reg[15][3] -pin u_ir pc_out_reg[15][3] -pin u_pc pc_out_reg[15]_0[3]
load net u_ir_n_57 -attr @rip pc_out_reg[15][2] -pin u_ir pc_out_reg[15][2] -pin u_pc pc_out_reg[15]_0[2]
load net u_ir_n_58 -attr @rip pc_out_reg[15][1] -pin u_ir pc_out_reg[15][1] -pin u_pc pc_out_reg[15]_0[1]
load net u_ir_n_59 -attr @rip pc_out_reg[15][0] -pin u_ir pc_out_reg[15][0] -pin u_pc pc_out_reg[15]_0[0]
load net u_ir_n_6 -attr @rip ir_reg_reg[4]_0[1] -pin u_ctrl ram_reg_0[1] -pin u_ir ir_reg_reg[4]_0[1]
load net u_ir_n_60 -attr @rip pc_out_reg[19][3] -pin u_ir pc_out_reg[19][3] -pin u_pc pc_out_reg[19]_0[3]
load net u_ir_n_61 -attr @rip pc_out_reg[19][2] -pin u_ir pc_out_reg[19][2] -pin u_pc pc_out_reg[19]_0[2]
load net u_ir_n_62 -attr @rip pc_out_reg[19][1] -pin u_ir pc_out_reg[19][1] -pin u_pc pc_out_reg[19]_0[1]
load net u_ir_n_63 -attr @rip pc_out_reg[19][0] -pin u_ir pc_out_reg[19][0] -pin u_pc pc_out_reg[19]_0[0]
load net u_ir_n_64 -attr @rip pc_out_reg[23][3] -pin u_ir pc_out_reg[23][3] -pin u_pc pc_out_reg[23]_0[3]
load net u_ir_n_65 -attr @rip pc_out_reg[23][2] -pin u_ir pc_out_reg[23][2] -pin u_pc pc_out_reg[23]_0[2]
load net u_ir_n_66 -attr @rip pc_out_reg[23][1] -pin u_ir pc_out_reg[23][1] -pin u_pc pc_out_reg[23]_0[1]
load net u_ir_n_67 -attr @rip pc_out_reg[23][0] -pin u_ir pc_out_reg[23][0] -pin u_pc pc_out_reg[23]_0[0]
load net u_ir_n_68 -attr @rip pc_out_reg[27][3] -pin u_ir pc_out_reg[27][3] -pin u_pc pc_out_reg[27]_0[3]
load net u_ir_n_69 -attr @rip pc_out_reg[27][2] -pin u_ir pc_out_reg[27][2] -pin u_pc pc_out_reg[27]_0[2]
load net u_ir_n_7 -attr @rip ir_reg_reg[4]_0[0] -pin u_ctrl ram_reg_0[0] -pin u_ir ir_reg_reg[4]_0[0]
load net u_ir_n_70 -attr @rip pc_out_reg[27][1] -pin u_ir pc_out_reg[27][1] -pin u_pc pc_out_reg[27]_0[1]
load net u_ir_n_71 -attr @rip pc_out_reg[27][0] -pin u_ir pc_out_reg[27][0] -pin u_pc pc_out_reg[27]_0[0]
load net u_ir_n_72 -attr @rip pc_out_reg[31][3] -pin u_ir pc_out_reg[31][3] -pin u_pc pc_out_reg[31]_0[3]
load net u_ir_n_73 -attr @rip pc_out_reg[31][2] -pin u_ir pc_out_reg[31][2] -pin u_pc pc_out_reg[31]_0[2]
load net u_ir_n_74 -attr @rip pc_out_reg[31][1] -pin u_ir pc_out_reg[31][1] -pin u_pc pc_out_reg[31]_0[1]
load net u_ir_n_75 -attr @rip pc_out_reg[31][0] -pin u_ir pc_out_reg[31][0] -pin u_pc pc_out_reg[31]_0[0]
load net wr -pin u_ir wr -pin u_mem wr
netloc wr 1 4 3 1440 3430 NJ 3430 2280
load netBundle @acc_out 32 acc_out[31] acc_out[30] acc_out[29] acc_out[28] acc_out[27] acc_out[26] acc_out[25] acc_out[24] acc_out[23] acc_out[22] acc_out[21] acc_out[20] acc_out[19] acc_out[18] acc_out[17] acc_out[16] acc_out[15] acc_out[14] acc_out[13] acc_out[12] acc_out[11] acc_out[10] acc_out[9] acc_out[8] acc_out[7] acc_out[6] acc_out[5] acc_out[4] acc_out[3] acc_out[2] acc_out[1] acc_out[0] -autobundled
netbloc @acc_out 1 8 1 3180 40n
load netBundle @pc_out 32 pc_out[31] pc_out[30] pc_out[29] pc_out[28] pc_out[27] pc_out[26] pc_out[25] pc_out[24] pc_out[23] pc_out[22] pc_out[21] pc_out[20] pc_out[19] pc_out[18] pc_out[17] pc_out[16] pc_out[15] pc_out[14] pc_out[13] pc_out[12] pc_out[11] pc_out[10] pc_out[9] pc_out[8] pc_out[7] pc_out[6] pc_out[5] pc_out[4] pc_out[3] pc_out[2] pc_out[1] pc_out[0] -autobundled
netbloc @pc_out 1 8 1 3180 2280n
load netBundle @acc_out_OBUF 32 acc_out_OBUF[31] acc_out_OBUF[30] acc_out_OBUF[29] acc_out_OBUF[28] acc_out_OBUF[27] acc_out_OBUF[26] acc_out_OBUF[25] acc_out_OBUF[24] acc_out_OBUF[23] acc_out_OBUF[22] acc_out_OBUF[21] acc_out_OBUF[20] acc_out_OBUF[19] acc_out_OBUF[18] acc_out_OBUF[17] acc_out_OBUF[16] acc_out_OBUF[15] acc_out_OBUF[14] acc_out_OBUF[13] acc_out_OBUF[12] acc_out_OBUF[11] acc_out_OBUF[10] acc_out_OBUF[9] acc_out_OBUF[8] acc_out_OBUF[7] acc_out_OBUF[6] acc_out_OBUF[5] acc_out_OBUF[4] acc_out_OBUF[3] acc_out_OBUF[2] acc_out_OBUF[1] acc_out_OBUF[0] -autobundled
netbloc @acc_out_OBUF 1 4 4 1440 2950 1870 2350 NJ 2350 2940
load netBundle @u_acc_n_ 4 u_acc_n_33 u_acc_n_34 u_acc_n_35 u_acc_n_36 -autobundled
netbloc @u_acc_n_ 1 4 4 1320 2370 NJ 2370 NJ 2370 2920
load netBundle @u_acc_n__1 4 u_acc_n_45 u_acc_n_46 u_acc_n_47 u_acc_n_48 -autobundled
netbloc @u_acc_n__1 1 4 4 1380 2430 NJ 2430 NJ 2430 2860
load netBundle @u_acc_n__2 4 u_acc_n_49 u_acc_n_50 u_acc_n_51 u_acc_n_52 -autobundled
netbloc @u_acc_n__2 1 4 4 1400 2450 NJ 2450 NJ 2450 2840
load netBundle @u_acc_n__3 4 u_acc_n_53 u_acc_n_54 u_acc_n_55 u_acc_n_56 -autobundled
netbloc @u_acc_n__3 1 4 4 1420 2470 NJ 2470 NJ 2470 2820
load netBundle @u_acc_n__4 4 u_acc_n_57 u_acc_n_58 u_acc_n_59 u_acc_n_60 -autobundled
netbloc @u_acc_n__4 1 4 4 1440 2490 NJ 2490 NJ 2490 2800
load netBundle @u_acc_n__5 4 u_acc_n_61 u_acc_n_62 u_acc_n_63 u_acc_n_64 -autobundled
netbloc @u_acc_n__5 1 4 4 1420 2750 NJ 2750 2460J 2770 2820
load netBundle @u_acc_n__6 4 u_acc_n_37 u_acc_n_38 u_acc_n_39 u_acc_n_40 -autobundled
netbloc @u_acc_n__6 1 4 4 1340 2390 NJ 2390 NJ 2390 2900
load netBundle @u_acc_n__7 4 u_acc_n_41 u_acc_n_42 u_acc_n_43 u_acc_n_44 -autobundled
netbloc @u_acc_n__7 1 4 4 1360 2410 NJ 2410 NJ 2410 2880
load netBundle @data1 32 data1[31] data1[30] data1[29] data1[28] data1[27] data1[26] data1[25] data1[24] data1[23] data1[22] data1[21] data1[20] data1[19] data1[18] data1[17] data1[16] data1[15] data1[14] data1[13] data1[12] data1[11] data1[10] data1[9] data1[8] data1[7] data1[6] data1[5] data1[4] data1[3] data1[2] data1[1] data1[0] -autobundled
netbloc @data1 1 5 1 1790 2630n
load netBundle @mem_addr 5 mem_addr[4] mem_addr[3] mem_addr[2] mem_addr[1] mem_addr[0] -autobundled
netbloc @mem_addr 1 4 1 1360 3010n
load netBundle @p_2_in,p_1_in2_in,p_1_in 3 p_2_in p_1_in2_in p_1_in -autobundled
netbloc @p_2_in,p_1_in2_in,p_1_in 1 4 2 1420J 2930 N
load netBundle @out 32 out[31] out[30] out[29] out[28] out[27] out[26] out[25] out[24] out[23] out[22] out[21] out[20] out[19] out[18] out[17] out[16] out[15] out[14] out[13] out[12] out[11] out[10] out[9] out[8] out[7] out[6] out[5] out[4] out[3] out[2] out[1] out[0] -autobundled
netbloc @out 1 6 1 2320 2590n
load netBundle @u_ir_n_ 4 u_ir_n_44 u_ir_n_45 u_ir_n_46 u_ir_n_47 -autobundled
netbloc @u_ir_n_ 1 2 5 400 3250 870J 3230 NJ 3230 NJ 3230 2420
load netBundle @u_ir_n__1 5 u_ir_n_3 u_ir_n_4 u_ir_n_5 u_ir_n_6 u_ir_n_7 -autobundled
netbloc @u_ir_n__1 1 3 4 930 3210 NJ 3210 NJ 3210 2260
load netBundle @u_ir_n__2 4 u_ir_n_52 u_ir_n_53 u_ir_n_54 u_ir_n_55 -autobundled
netbloc @u_ir_n__2 1 2 5 420 3330 NJ 3330 NJ 3330 NJ 3330 2380
load netBundle @u_ir_n__3 4 u_ir_n_56 u_ir_n_57 u_ir_n_58 u_ir_n_59 -autobundled
netbloc @u_ir_n__3 1 2 5 440 3350 NJ 3350 NJ 3350 NJ 3350 2360
load netBundle @u_ir_n__4 4 u_ir_n_60 u_ir_n_61 u_ir_n_62 u_ir_n_63 -autobundled
netbloc @u_ir_n__4 1 2 5 460 3370 NJ 3370 NJ 3370 NJ 3370 2340
load netBundle @u_ir_n__5 4 u_ir_n_64 u_ir_n_65 u_ir_n_66 u_ir_n_67 -autobundled
netbloc @u_ir_n__5 1 2 5 480 3390 NJ 3390 NJ 3390 NJ 3390 2320
load netBundle @u_ir_n__6 4 u_ir_n_68 u_ir_n_69 u_ir_n_70 u_ir_n_71 -autobundled
netbloc @u_ir_n__6 1 2 5 500 3230 850J 3170 NJ 3170 1830J 2790 2280
load netBundle @u_ir_n__7 4 u_ir_n_72 u_ir_n_73 u_ir_n_74 u_ir_n_75 -autobundled
netbloc @u_ir_n__7 1 2 5 380 3410 NJ 3410 NJ 3410 NJ 3410 2300
load netBundle @u_ir_n__8 4 u_ir_n_48 u_ir_n_49 u_ir_n_50 u_ir_n_51 -autobundled
netbloc @u_ir_n__8 1 2 5 360 3310 NJ 3310 NJ 3310 NJ 3310 2400
load netBundle @mem_data_out 32 mem_data_out[31] mem_data_out[30] mem_data_out[29] mem_data_out[28] mem_data_out[27] mem_data_out[26] mem_data_out[25] mem_data_out[24] mem_data_out[23] mem_data_out[22] mem_data_out[21] mem_data_out[20] mem_data_out[19] mem_data_out[18] mem_data_out[17] mem_data_out[16] mem_data_out[15] mem_data_out[14] mem_data_out[13] mem_data_out[12] mem_data_out[11] mem_data_out[10] mem_data_out[9] mem_data_out[8] mem_data_out[7] mem_data_out[6] mem_data_out[5] mem_data_out[4] mem_data_out[3] mem_data_out[2] mem_data_out[1] mem_data_out[0] -autobundled
netbloc @mem_data_out 1 5 2 1810 2670 NJ
load netBundle @pc_out_OBUF 32 pc_out_OBUF[31] pc_out_OBUF[30] pc_out_OBUF[29] pc_out_OBUF[28] pc_out_OBUF[27] pc_out_OBUF[26] pc_out_OBUF[25] pc_out_OBUF[24] pc_out_OBUF[23] pc_out_OBUF[22] pc_out_OBUF[21] pc_out_OBUF[20] pc_out_OBUF[19] pc_out_OBUF[18] pc_out_OBUF[17] pc_out_OBUF[16] pc_out_OBUF[15] pc_out_OBUF[14] pc_out_OBUF[13] pc_out_OBUF[12] pc_out_OBUF[11] pc_out_OBUF[10] pc_out_OBUF[9] pc_out_OBUF[8] pc_out_OBUF[7] pc_out_OBUF[6] pc_out_OBUF[5] pc_out_OBUF[4] pc_out_OBUF[3] pc_out_OBUF[2] pc_out_OBUF[1] pc_out_OBUF[0] -autobundled
netbloc @pc_out_OBUF 1 3 5 870 3190 NJ 3190 1890 3450 NJ 3450 2960
levelinfo -pg 1 0 40 180 650 1110 1590 2060 2590 3000 3200
pagesize -pg 1 -db -bbox -sgen -70 0 3340 4560
show
zoom 0.250286
scrollpos -36 344
#
# initialize ictrl to current module RISC_CPU work:RISC_CPU:NOFILE
ictrl init topinfo |
