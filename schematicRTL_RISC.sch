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
load symbol ACC work:ACC:NOFILE HIERBOX pin clk input.left pin ld_ac input.left pin rst input.left pinBus acc_in input.left [31:0] pinBus acc_out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol address_mux work:address_mux:NOFILE HIERBOX pin sel input.left pinBus ir_addr input.left [31:0] pinBus mem_addr output.right [31:0] pinBus pc_addr input.left [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol ALU work:ALU:NOFILE HIERBOX pin is_zero output.right pinBus inA input.left [31:0] pinBus inB input.left [31:0] pinBus opcode input.left [2:0] pinBus out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol Controller work:Controller:NOFILE HIERBOX pin clk input.left pin data_e output.right pin halt output.right pin inc_pc output.right pin is_zero input.left pin ld_ac output.right pin ld_ir output.right pin ld_pc output.right pin rd output.right pin rst input.left pin sel output.right pin wr output.right pinBus opcode input.left [2:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol IR work:IR:NOFILE HIERBOX pin clk input.left pin ld_ir input.left pin rst input.left pinBus data_in input.left [31:0] pinBus opcode output.right [2:0] pinBus operand output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol memory work:memory:NOFILE HIERBOX pin clk input.left pin rd input.left pin wr input.left pinBus addr input.left [31:0] pinBus data_in input.left [31:0] pinBus data_out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol program_counter work:program_counter:NOFILE HIERBOX pin clk input.left pin inc_pc input.left pin ld_pc input.left pin reset input.left pinBus pc_in input.left [31:0] pinBus pc_out output.right [31:0] boxcolor 1 fillcolor 2 minwidth 13%
load port clk input -pg 1 -lvl 0 -x 0 -y 110
load port halt output -pg 1 -lvl 7 -x 2070 -y 40
load port rst input -pg 1 -lvl 0 -x 0 -y 230
load portBus acc_out output [31:0] -attr @name acc_out[31:0] -pg 1 -lvl 7 -x 2070 -y 290
load portBus pc_out output [31:0] -attr @name pc_out[31:0] -pg 1 -lvl 7 -x 2070 -y 140
load inst u_acc ACC work:ACC:NOFILE -autohide -attr @cell(#000000) ACC -pinBusAttr acc_in @name acc_in[31:0] -pinBusAttr acc_out @name acc_out[31:0] -pg 1 -lvl 6 -x 1860 -y 260
load inst u_addr_mux address_mux work:address_mux:NOFILE -autohide -attr @cell(#000000) address_mux -pinBusAttr ir_addr @name ir_addr[31:0] -pinBusAttr mem_addr @name mem_addr[31:0] -pinBusAttr pc_addr @name pc_addr[31:0] -pg 1 -lvl 2 -x 460 -y 240
load inst u_alu ALU work:ALU:NOFILE -autohide -attr @cell(#000000) ALU -pinBusAttr inA @name inA[31:0] -pinBusAttr inB @name inB[31:0] -pinBusAttr opcode @name opcode[2:0] -pinBusAttr out @name out[31:0] -pg 1 -lvl 4 -x 1130 -y 200
load inst u_ctrl Controller work:Controller:NOFILE -autohide -attr @cell(#000000) Controller -pinAttr data_e @attr n/c -pinBusAttr opcode @name opcode[2:0] -pg 1 -lvl 5 -x 1470 -y 60
load inst u_ir IR work:IR:NOFILE -autohide -attr @cell(#000000) IR -pinBusAttr data_in @name data_in[31:0] -pinBusAttr opcode @name opcode[2:0] -pinBusAttr operand @name operand[31:0] -pg 1 -lvl 1 -x 160 -y 160
load inst u_mem memory work:memory:NOFILE -autohide -attr @cell(#000000) memory -pinBusAttr addr @name addr[31:0] -pinBusAttr data_in @name data_in[31:0] -pinBusAttr data_out @name data_out[31:0] -pg 1 -lvl 3 -x 820 -y 140
load inst u_pc program_counter work:program_counter:NOFILE -autohide -attr @cell(#000000) program_counter -pinBusAttr pc_in @name pc_in[31:0] -pinBusAttr pc_out @name pc_out[31:0] -pg 1 -lvl 6 -x 1860 -y 90
load net acc_out[0] -attr @rip acc_out[0] -port acc_out[0] -pin u_acc acc_out[0] -pin u_alu inA[0] -pin u_mem data_in[0]
load net acc_out[10] -attr @rip acc_out[10] -port acc_out[10] -pin u_acc acc_out[10] -pin u_alu inA[10] -pin u_mem data_in[10]
load net acc_out[11] -attr @rip acc_out[11] -port acc_out[11] -pin u_acc acc_out[11] -pin u_alu inA[11] -pin u_mem data_in[11]
load net acc_out[12] -attr @rip acc_out[12] -port acc_out[12] -pin u_acc acc_out[12] -pin u_alu inA[12] -pin u_mem data_in[12]
load net acc_out[13] -attr @rip acc_out[13] -port acc_out[13] -pin u_acc acc_out[13] -pin u_alu inA[13] -pin u_mem data_in[13]
load net acc_out[14] -attr @rip acc_out[14] -port acc_out[14] -pin u_acc acc_out[14] -pin u_alu inA[14] -pin u_mem data_in[14]
load net acc_out[15] -attr @rip acc_out[15] -port acc_out[15] -pin u_acc acc_out[15] -pin u_alu inA[15] -pin u_mem data_in[15]
load net acc_out[16] -attr @rip acc_out[16] -port acc_out[16] -pin u_acc acc_out[16] -pin u_alu inA[16] -pin u_mem data_in[16]
load net acc_out[17] -attr @rip acc_out[17] -port acc_out[17] -pin u_acc acc_out[17] -pin u_alu inA[17] -pin u_mem data_in[17]
load net acc_out[18] -attr @rip acc_out[18] -port acc_out[18] -pin u_acc acc_out[18] -pin u_alu inA[18] -pin u_mem data_in[18]
load net acc_out[19] -attr @rip acc_out[19] -port acc_out[19] -pin u_acc acc_out[19] -pin u_alu inA[19] -pin u_mem data_in[19]
load net acc_out[1] -attr @rip acc_out[1] -port acc_out[1] -pin u_acc acc_out[1] -pin u_alu inA[1] -pin u_mem data_in[1]
load net acc_out[20] -attr @rip acc_out[20] -port acc_out[20] -pin u_acc acc_out[20] -pin u_alu inA[20] -pin u_mem data_in[20]
load net acc_out[21] -attr @rip acc_out[21] -port acc_out[21] -pin u_acc acc_out[21] -pin u_alu inA[21] -pin u_mem data_in[21]
load net acc_out[22] -attr @rip acc_out[22] -port acc_out[22] -pin u_acc acc_out[22] -pin u_alu inA[22] -pin u_mem data_in[22]
load net acc_out[23] -attr @rip acc_out[23] -port acc_out[23] -pin u_acc acc_out[23] -pin u_alu inA[23] -pin u_mem data_in[23]
load net acc_out[24] -attr @rip acc_out[24] -port acc_out[24] -pin u_acc acc_out[24] -pin u_alu inA[24] -pin u_mem data_in[24]
load net acc_out[25] -attr @rip acc_out[25] -port acc_out[25] -pin u_acc acc_out[25] -pin u_alu inA[25] -pin u_mem data_in[25]
load net acc_out[26] -attr @rip acc_out[26] -port acc_out[26] -pin u_acc acc_out[26] -pin u_alu inA[26] -pin u_mem data_in[26]
load net acc_out[27] -attr @rip acc_out[27] -port acc_out[27] -pin u_acc acc_out[27] -pin u_alu inA[27] -pin u_mem data_in[27]
load net acc_out[28] -attr @rip acc_out[28] -port acc_out[28] -pin u_acc acc_out[28] -pin u_alu inA[28] -pin u_mem data_in[28]
load net acc_out[29] -attr @rip acc_out[29] -port acc_out[29] -pin u_acc acc_out[29] -pin u_alu inA[29] -pin u_mem data_in[29]
load net acc_out[2] -attr @rip acc_out[2] -port acc_out[2] -pin u_acc acc_out[2] -pin u_alu inA[2] -pin u_mem data_in[2]
load net acc_out[30] -attr @rip acc_out[30] -port acc_out[30] -pin u_acc acc_out[30] -pin u_alu inA[30] -pin u_mem data_in[30]
load net acc_out[31] -attr @rip acc_out[31] -port acc_out[31] -pin u_acc acc_out[31] -pin u_alu inA[31] -pin u_mem data_in[31]
load net acc_out[3] -attr @rip acc_out[3] -port acc_out[3] -pin u_acc acc_out[3] -pin u_alu inA[3] -pin u_mem data_in[3]
load net acc_out[4] -attr @rip acc_out[4] -port acc_out[4] -pin u_acc acc_out[4] -pin u_alu inA[4] -pin u_mem data_in[4]
load net acc_out[5] -attr @rip acc_out[5] -port acc_out[5] -pin u_acc acc_out[5] -pin u_alu inA[5] -pin u_mem data_in[5]
load net acc_out[6] -attr @rip acc_out[6] -port acc_out[6] -pin u_acc acc_out[6] -pin u_alu inA[6] -pin u_mem data_in[6]
load net acc_out[7] -attr @rip acc_out[7] -port acc_out[7] -pin u_acc acc_out[7] -pin u_alu inA[7] -pin u_mem data_in[7]
load net acc_out[8] -attr @rip acc_out[8] -port acc_out[8] -pin u_acc acc_out[8] -pin u_alu inA[8] -pin u_mem data_in[8]
load net acc_out[9] -attr @rip acc_out[9] -port acc_out[9] -pin u_acc acc_out[9] -pin u_alu inA[9] -pin u_mem data_in[9]
load net alu_out[0] -attr @rip out[0] -pin u_acc acc_in[0] -pin u_alu out[0]
load net alu_out[10] -attr @rip out[10] -pin u_acc acc_in[10] -pin u_alu out[10]
load net alu_out[11] -attr @rip out[11] -pin u_acc acc_in[11] -pin u_alu out[11]
load net alu_out[12] -attr @rip out[12] -pin u_acc acc_in[12] -pin u_alu out[12]
load net alu_out[13] -attr @rip out[13] -pin u_acc acc_in[13] -pin u_alu out[13]
load net alu_out[14] -attr @rip out[14] -pin u_acc acc_in[14] -pin u_alu out[14]
load net alu_out[15] -attr @rip out[15] -pin u_acc acc_in[15] -pin u_alu out[15]
load net alu_out[16] -attr @rip out[16] -pin u_acc acc_in[16] -pin u_alu out[16]
load net alu_out[17] -attr @rip out[17] -pin u_acc acc_in[17] -pin u_alu out[17]
load net alu_out[18] -attr @rip out[18] -pin u_acc acc_in[18] -pin u_alu out[18]
load net alu_out[19] -attr @rip out[19] -pin u_acc acc_in[19] -pin u_alu out[19]
load net alu_out[1] -attr @rip out[1] -pin u_acc acc_in[1] -pin u_alu out[1]
load net alu_out[20] -attr @rip out[20] -pin u_acc acc_in[20] -pin u_alu out[20]
load net alu_out[21] -attr @rip out[21] -pin u_acc acc_in[21] -pin u_alu out[21]
load net alu_out[22] -attr @rip out[22] -pin u_acc acc_in[22] -pin u_alu out[22]
load net alu_out[23] -attr @rip out[23] -pin u_acc acc_in[23] -pin u_alu out[23]
load net alu_out[24] -attr @rip out[24] -pin u_acc acc_in[24] -pin u_alu out[24]
load net alu_out[25] -attr @rip out[25] -pin u_acc acc_in[25] -pin u_alu out[25]
load net alu_out[26] -attr @rip out[26] -pin u_acc acc_in[26] -pin u_alu out[26]
load net alu_out[27] -attr @rip out[27] -pin u_acc acc_in[27] -pin u_alu out[27]
load net alu_out[28] -attr @rip out[28] -pin u_acc acc_in[28] -pin u_alu out[28]
load net alu_out[29] -attr @rip out[29] -pin u_acc acc_in[29] -pin u_alu out[29]
load net alu_out[2] -attr @rip out[2] -pin u_acc acc_in[2] -pin u_alu out[2]
load net alu_out[30] -attr @rip out[30] -pin u_acc acc_in[30] -pin u_alu out[30]
load net alu_out[31] -attr @rip out[31] -pin u_acc acc_in[31] -pin u_alu out[31]
load net alu_out[3] -attr @rip out[3] -pin u_acc acc_in[3] -pin u_alu out[3]
load net alu_out[4] -attr @rip out[4] -pin u_acc acc_in[4] -pin u_alu out[4]
load net alu_out[5] -attr @rip out[5] -pin u_acc acc_in[5] -pin u_alu out[5]
load net alu_out[6] -attr @rip out[6] -pin u_acc acc_in[6] -pin u_alu out[6]
load net alu_out[7] -attr @rip out[7] -pin u_acc acc_in[7] -pin u_alu out[7]
load net alu_out[8] -attr @rip out[8] -pin u_acc acc_in[8] -pin u_alu out[8]
load net alu_out[9] -attr @rip out[9] -pin u_acc acc_in[9] -pin u_alu out[9]
load net clk -port clk -pin u_acc clk -pin u_ctrl clk -pin u_ir clk -pin u_mem clk -pin u_pc clk
netloc clk 1 0 6 60 110 NJ 110 680 70 NJ 70 1370 290 1740
load net halt -port halt -pin u_ctrl halt
netloc halt 1 5 2 1740J 40 NJ
load net inc_pc -pin u_ctrl inc_pc -pin u_pc inc_pc
netloc inc_pc 1 5 1 1720 90n
load net is_zero -pin u_alu is_zero -pin u_ctrl is_zero
netloc is_zero 1 4 1 1290 130n
load net ld_ac -pin u_acc ld_ac -pin u_ctrl ld_ac
netloc ld_ac 1 5 1 1700 110n
load net ld_ir -pin u_ctrl ld_ir -pin u_ir ld_ir
netloc ld_ir 1 0 6 60 370 NJ 370 NJ 370 NJ 370 NJ 370 1620
load net ld_pc -pin u_ctrl ld_pc -pin u_pc ld_pc
netloc ld_pc 1 5 1 1680 140n
load net mem_addr[0] -attr @rip mem_addr[0] -pin u_addr_mux mem_addr[0] -pin u_mem addr[0]
load net mem_addr[10] -attr @rip mem_addr[10] -pin u_addr_mux mem_addr[10] -pin u_mem addr[10]
load net mem_addr[11] -attr @rip mem_addr[11] -pin u_addr_mux mem_addr[11] -pin u_mem addr[11]
load net mem_addr[12] -attr @rip mem_addr[12] -pin u_addr_mux mem_addr[12] -pin u_mem addr[12]
load net mem_addr[13] -attr @rip mem_addr[13] -pin u_addr_mux mem_addr[13] -pin u_mem addr[13]
load net mem_addr[14] -attr @rip mem_addr[14] -pin u_addr_mux mem_addr[14] -pin u_mem addr[14]
load net mem_addr[15] -attr @rip mem_addr[15] -pin u_addr_mux mem_addr[15] -pin u_mem addr[15]
load net mem_addr[16] -attr @rip mem_addr[16] -pin u_addr_mux mem_addr[16] -pin u_mem addr[16]
load net mem_addr[17] -attr @rip mem_addr[17] -pin u_addr_mux mem_addr[17] -pin u_mem addr[17]
load net mem_addr[18] -attr @rip mem_addr[18] -pin u_addr_mux mem_addr[18] -pin u_mem addr[18]
load net mem_addr[19] -attr @rip mem_addr[19] -pin u_addr_mux mem_addr[19] -pin u_mem addr[19]
load net mem_addr[1] -attr @rip mem_addr[1] -pin u_addr_mux mem_addr[1] -pin u_mem addr[1]
load net mem_addr[20] -attr @rip mem_addr[20] -pin u_addr_mux mem_addr[20] -pin u_mem addr[20]
load net mem_addr[21] -attr @rip mem_addr[21] -pin u_addr_mux mem_addr[21] -pin u_mem addr[21]
load net mem_addr[22] -attr @rip mem_addr[22] -pin u_addr_mux mem_addr[22] -pin u_mem addr[22]
load net mem_addr[23] -attr @rip mem_addr[23] -pin u_addr_mux mem_addr[23] -pin u_mem addr[23]
load net mem_addr[24] -attr @rip mem_addr[24] -pin u_addr_mux mem_addr[24] -pin u_mem addr[24]
load net mem_addr[25] -attr @rip mem_addr[25] -pin u_addr_mux mem_addr[25] -pin u_mem addr[25]
load net mem_addr[26] -attr @rip mem_addr[26] -pin u_addr_mux mem_addr[26] -pin u_mem addr[26]
load net mem_addr[27] -attr @rip mem_addr[27] -pin u_addr_mux mem_addr[27] -pin u_mem addr[27]
load net mem_addr[28] -attr @rip mem_addr[28] -pin u_addr_mux mem_addr[28] -pin u_mem addr[28]
load net mem_addr[29] -attr @rip mem_addr[29] -pin u_addr_mux mem_addr[29] -pin u_mem addr[29]
load net mem_addr[2] -attr @rip mem_addr[2] -pin u_addr_mux mem_addr[2] -pin u_mem addr[2]
load net mem_addr[30] -attr @rip mem_addr[30] -pin u_addr_mux mem_addr[30] -pin u_mem addr[30]
load net mem_addr[31] -attr @rip mem_addr[31] -pin u_addr_mux mem_addr[31] -pin u_mem addr[31]
load net mem_addr[3] -attr @rip mem_addr[3] -pin u_addr_mux mem_addr[3] -pin u_mem addr[3]
load net mem_addr[4] -attr @rip mem_addr[4] -pin u_addr_mux mem_addr[4] -pin u_mem addr[4]
load net mem_addr[5] -attr @rip mem_addr[5] -pin u_addr_mux mem_addr[5] -pin u_mem addr[5]
load net mem_addr[6] -attr @rip mem_addr[6] -pin u_addr_mux mem_addr[6] -pin u_mem addr[6]
load net mem_addr[7] -attr @rip mem_addr[7] -pin u_addr_mux mem_addr[7] -pin u_mem addr[7]
load net mem_addr[8] -attr @rip mem_addr[8] -pin u_addr_mux mem_addr[8] -pin u_mem addr[8]
load net mem_addr[9] -attr @rip mem_addr[9] -pin u_addr_mux mem_addr[9] -pin u_mem addr[9]
load net mem_data_out[0] -attr @rip data_out[0] -pin u_alu inB[0] -pin u_ir data_in[0] -pin u_mem data_out[0]
load net mem_data_out[10] -attr @rip data_out[10] -pin u_alu inB[10] -pin u_ir data_in[10] -pin u_mem data_out[10]
load net mem_data_out[11] -attr @rip data_out[11] -pin u_alu inB[11] -pin u_ir data_in[11] -pin u_mem data_out[11]
load net mem_data_out[12] -attr @rip data_out[12] -pin u_alu inB[12] -pin u_ir data_in[12] -pin u_mem data_out[12]
load net mem_data_out[13] -attr @rip data_out[13] -pin u_alu inB[13] -pin u_ir data_in[13] -pin u_mem data_out[13]
load net mem_data_out[14] -attr @rip data_out[14] -pin u_alu inB[14] -pin u_ir data_in[14] -pin u_mem data_out[14]
load net mem_data_out[15] -attr @rip data_out[15] -pin u_alu inB[15] -pin u_ir data_in[15] -pin u_mem data_out[15]
load net mem_data_out[16] -attr @rip data_out[16] -pin u_alu inB[16] -pin u_ir data_in[16] -pin u_mem data_out[16]
load net mem_data_out[17] -attr @rip data_out[17] -pin u_alu inB[17] -pin u_ir data_in[17] -pin u_mem data_out[17]
load net mem_data_out[18] -attr @rip data_out[18] -pin u_alu inB[18] -pin u_ir data_in[18] -pin u_mem data_out[18]
load net mem_data_out[19] -attr @rip data_out[19] -pin u_alu inB[19] -pin u_ir data_in[19] -pin u_mem data_out[19]
load net mem_data_out[1] -attr @rip data_out[1] -pin u_alu inB[1] -pin u_ir data_in[1] -pin u_mem data_out[1]
load net mem_data_out[20] -attr @rip data_out[20] -pin u_alu inB[20] -pin u_ir data_in[20] -pin u_mem data_out[20]
load net mem_data_out[21] -attr @rip data_out[21] -pin u_alu inB[21] -pin u_ir data_in[21] -pin u_mem data_out[21]
load net mem_data_out[22] -attr @rip data_out[22] -pin u_alu inB[22] -pin u_ir data_in[22] -pin u_mem data_out[22]
load net mem_data_out[23] -attr @rip data_out[23] -pin u_alu inB[23] -pin u_ir data_in[23] -pin u_mem data_out[23]
load net mem_data_out[24] -attr @rip data_out[24] -pin u_alu inB[24] -pin u_ir data_in[24] -pin u_mem data_out[24]
load net mem_data_out[25] -attr @rip data_out[25] -pin u_alu inB[25] -pin u_ir data_in[25] -pin u_mem data_out[25]
load net mem_data_out[26] -attr @rip data_out[26] -pin u_alu inB[26] -pin u_ir data_in[26] -pin u_mem data_out[26]
load net mem_data_out[27] -attr @rip data_out[27] -pin u_alu inB[27] -pin u_ir data_in[27] -pin u_mem data_out[27]
load net mem_data_out[28] -attr @rip data_out[28] -pin u_alu inB[28] -pin u_ir data_in[28] -pin u_mem data_out[28]
load net mem_data_out[29] -attr @rip data_out[29] -pin u_alu inB[29] -pin u_ir data_in[29] -pin u_mem data_out[29]
load net mem_data_out[2] -attr @rip data_out[2] -pin u_alu inB[2] -pin u_ir data_in[2] -pin u_mem data_out[2]
load net mem_data_out[30] -attr @rip data_out[30] -pin u_alu inB[30] -pin u_ir data_in[30] -pin u_mem data_out[30]
load net mem_data_out[31] -attr @rip data_out[31] -pin u_alu inB[31] -pin u_ir data_in[31] -pin u_mem data_out[31]
load net mem_data_out[3] -attr @rip data_out[3] -pin u_alu inB[3] -pin u_ir data_in[3] -pin u_mem data_out[3]
load net mem_data_out[4] -attr @rip data_out[4] -pin u_alu inB[4] -pin u_ir data_in[4] -pin u_mem data_out[4]
load net mem_data_out[5] -attr @rip data_out[5] -pin u_alu inB[5] -pin u_ir data_in[5] -pin u_mem data_out[5]
load net mem_data_out[6] -attr @rip data_out[6] -pin u_alu inB[6] -pin u_ir data_in[6] -pin u_mem data_out[6]
load net mem_data_out[7] -attr @rip data_out[7] -pin u_alu inB[7] -pin u_ir data_in[7] -pin u_mem data_out[7]
load net mem_data_out[8] -attr @rip data_out[8] -pin u_alu inB[8] -pin u_ir data_in[8] -pin u_mem data_out[8]
load net mem_data_out[9] -attr @rip data_out[9] -pin u_alu inB[9] -pin u_ir data_in[9] -pin u_mem data_out[9]
load net opcode[0] -attr @rip opcode[0] -pin u_alu opcode[0] -pin u_ctrl opcode[0] -pin u_ir opcode[0]
load net opcode[1] -attr @rip opcode[1] -pin u_alu opcode[1] -pin u_ctrl opcode[1] -pin u_ir opcode[1]
load net opcode[2] -attr @rip opcode[2] -pin u_alu opcode[2] -pin u_ctrl opcode[2] -pin u_ir opcode[2]
load net operand[0] -attr @rip operand[0] -pin u_addr_mux ir_addr[0] -pin u_ir operand[0] -pin u_pc pc_in[0]
load net operand[10] -attr @rip operand[10] -pin u_addr_mux ir_addr[10] -pin u_ir operand[10] -pin u_pc pc_in[10]
load net operand[11] -attr @rip operand[11] -pin u_addr_mux ir_addr[11] -pin u_ir operand[11] -pin u_pc pc_in[11]
load net operand[12] -attr @rip operand[12] -pin u_addr_mux ir_addr[12] -pin u_ir operand[12] -pin u_pc pc_in[12]
load net operand[13] -attr @rip operand[13] -pin u_addr_mux ir_addr[13] -pin u_ir operand[13] -pin u_pc pc_in[13]
load net operand[14] -attr @rip operand[14] -pin u_addr_mux ir_addr[14] -pin u_ir operand[14] -pin u_pc pc_in[14]
load net operand[15] -attr @rip operand[15] -pin u_addr_mux ir_addr[15] -pin u_ir operand[15] -pin u_pc pc_in[15]
load net operand[16] -attr @rip operand[16] -pin u_addr_mux ir_addr[16] -pin u_ir operand[16] -pin u_pc pc_in[16]
load net operand[17] -attr @rip operand[17] -pin u_addr_mux ir_addr[17] -pin u_ir operand[17] -pin u_pc pc_in[17]
load net operand[18] -attr @rip operand[18] -pin u_addr_mux ir_addr[18] -pin u_ir operand[18] -pin u_pc pc_in[18]
load net operand[19] -attr @rip operand[19] -pin u_addr_mux ir_addr[19] -pin u_ir operand[19] -pin u_pc pc_in[19]
load net operand[1] -attr @rip operand[1] -pin u_addr_mux ir_addr[1] -pin u_ir operand[1] -pin u_pc pc_in[1]
load net operand[20] -attr @rip operand[20] -pin u_addr_mux ir_addr[20] -pin u_ir operand[20] -pin u_pc pc_in[20]
load net operand[21] -attr @rip operand[21] -pin u_addr_mux ir_addr[21] -pin u_ir operand[21] -pin u_pc pc_in[21]
load net operand[22] -attr @rip operand[22] -pin u_addr_mux ir_addr[22] -pin u_ir operand[22] -pin u_pc pc_in[22]
load net operand[23] -attr @rip operand[23] -pin u_addr_mux ir_addr[23] -pin u_ir operand[23] -pin u_pc pc_in[23]
load net operand[24] -attr @rip operand[24] -pin u_addr_mux ir_addr[24] -pin u_ir operand[24] -pin u_pc pc_in[24]
load net operand[25] -attr @rip operand[25] -pin u_addr_mux ir_addr[25] -pin u_ir operand[25] -pin u_pc pc_in[25]
load net operand[26] -attr @rip operand[26] -pin u_addr_mux ir_addr[26] -pin u_ir operand[26] -pin u_pc pc_in[26]
load net operand[27] -attr @rip operand[27] -pin u_addr_mux ir_addr[27] -pin u_ir operand[27] -pin u_pc pc_in[27]
load net operand[28] -attr @rip operand[28] -pin u_addr_mux ir_addr[28] -pin u_ir operand[28] -pin u_pc pc_in[28]
load net operand[29] -attr @rip operand[29] -pin u_addr_mux ir_addr[29] -pin u_ir operand[29] -pin u_pc pc_in[29]
load net operand[2] -attr @rip operand[2] -pin u_addr_mux ir_addr[2] -pin u_ir operand[2] -pin u_pc pc_in[2]
load net operand[30] -attr @rip operand[30] -pin u_addr_mux ir_addr[30] -pin u_ir operand[30] -pin u_pc pc_in[30]
load net operand[31] -attr @rip operand[31] -pin u_addr_mux ir_addr[31] -pin u_ir operand[31] -pin u_pc pc_in[31]
load net operand[3] -attr @rip operand[3] -pin u_addr_mux ir_addr[3] -pin u_ir operand[3] -pin u_pc pc_in[3]
load net operand[4] -attr @rip operand[4] -pin u_addr_mux ir_addr[4] -pin u_ir operand[4] -pin u_pc pc_in[4]
load net operand[5] -attr @rip operand[5] -pin u_addr_mux ir_addr[5] -pin u_ir operand[5] -pin u_pc pc_in[5]
load net operand[6] -attr @rip operand[6] -pin u_addr_mux ir_addr[6] -pin u_ir operand[6] -pin u_pc pc_in[6]
load net operand[7] -attr @rip operand[7] -pin u_addr_mux ir_addr[7] -pin u_ir operand[7] -pin u_pc pc_in[7]
load net operand[8] -attr @rip operand[8] -pin u_addr_mux ir_addr[8] -pin u_ir operand[8] -pin u_pc pc_in[8]
load net operand[9] -attr @rip operand[9] -pin u_addr_mux ir_addr[9] -pin u_ir operand[9] -pin u_pc pc_in[9]
load net pc_out[0] -attr @rip pc_out[0] -port pc_out[0] -pin u_addr_mux pc_addr[0] -pin u_pc pc_out[0]
load net pc_out[10] -attr @rip pc_out[10] -port pc_out[10] -pin u_addr_mux pc_addr[10] -pin u_pc pc_out[10]
load net pc_out[11] -attr @rip pc_out[11] -port pc_out[11] -pin u_addr_mux pc_addr[11] -pin u_pc pc_out[11]
load net pc_out[12] -attr @rip pc_out[12] -port pc_out[12] -pin u_addr_mux pc_addr[12] -pin u_pc pc_out[12]
load net pc_out[13] -attr @rip pc_out[13] -port pc_out[13] -pin u_addr_mux pc_addr[13] -pin u_pc pc_out[13]
load net pc_out[14] -attr @rip pc_out[14] -port pc_out[14] -pin u_addr_mux pc_addr[14] -pin u_pc pc_out[14]
load net pc_out[15] -attr @rip pc_out[15] -port pc_out[15] -pin u_addr_mux pc_addr[15] -pin u_pc pc_out[15]
load net pc_out[16] -attr @rip pc_out[16] -port pc_out[16] -pin u_addr_mux pc_addr[16] -pin u_pc pc_out[16]
load net pc_out[17] -attr @rip pc_out[17] -port pc_out[17] -pin u_addr_mux pc_addr[17] -pin u_pc pc_out[17]
load net pc_out[18] -attr @rip pc_out[18] -port pc_out[18] -pin u_addr_mux pc_addr[18] -pin u_pc pc_out[18]
load net pc_out[19] -attr @rip pc_out[19] -port pc_out[19] -pin u_addr_mux pc_addr[19] -pin u_pc pc_out[19]
load net pc_out[1] -attr @rip pc_out[1] -port pc_out[1] -pin u_addr_mux pc_addr[1] -pin u_pc pc_out[1]
load net pc_out[20] -attr @rip pc_out[20] -port pc_out[20] -pin u_addr_mux pc_addr[20] -pin u_pc pc_out[20]
load net pc_out[21] -attr @rip pc_out[21] -port pc_out[21] -pin u_addr_mux pc_addr[21] -pin u_pc pc_out[21]
load net pc_out[22] -attr @rip pc_out[22] -port pc_out[22] -pin u_addr_mux pc_addr[22] -pin u_pc pc_out[22]
load net pc_out[23] -attr @rip pc_out[23] -port pc_out[23] -pin u_addr_mux pc_addr[23] -pin u_pc pc_out[23]
load net pc_out[24] -attr @rip pc_out[24] -port pc_out[24] -pin u_addr_mux pc_addr[24] -pin u_pc pc_out[24]
load net pc_out[25] -attr @rip pc_out[25] -port pc_out[25] -pin u_addr_mux pc_addr[25] -pin u_pc pc_out[25]
load net pc_out[26] -attr @rip pc_out[26] -port pc_out[26] -pin u_addr_mux pc_addr[26] -pin u_pc pc_out[26]
load net pc_out[27] -attr @rip pc_out[27] -port pc_out[27] -pin u_addr_mux pc_addr[27] -pin u_pc pc_out[27]
load net pc_out[28] -attr @rip pc_out[28] -port pc_out[28] -pin u_addr_mux pc_addr[28] -pin u_pc pc_out[28]
load net pc_out[29] -attr @rip pc_out[29] -port pc_out[29] -pin u_addr_mux pc_addr[29] -pin u_pc pc_out[29]
load net pc_out[2] -attr @rip pc_out[2] -port pc_out[2] -pin u_addr_mux pc_addr[2] -pin u_pc pc_out[2]
load net pc_out[30] -attr @rip pc_out[30] -port pc_out[30] -pin u_addr_mux pc_addr[30] -pin u_pc pc_out[30]
load net pc_out[31] -attr @rip pc_out[31] -port pc_out[31] -pin u_addr_mux pc_addr[31] -pin u_pc pc_out[31]
load net pc_out[3] -attr @rip pc_out[3] -port pc_out[3] -pin u_addr_mux pc_addr[3] -pin u_pc pc_out[3]
load net pc_out[4] -attr @rip pc_out[4] -port pc_out[4] -pin u_addr_mux pc_addr[4] -pin u_pc pc_out[4]
load net pc_out[5] -attr @rip pc_out[5] -port pc_out[5] -pin u_addr_mux pc_addr[5] -pin u_pc pc_out[5]
load net pc_out[6] -attr @rip pc_out[6] -port pc_out[6] -pin u_addr_mux pc_addr[6] -pin u_pc pc_out[6]
load net pc_out[7] -attr @rip pc_out[7] -port pc_out[7] -pin u_addr_mux pc_addr[7] -pin u_pc pc_out[7]
load net pc_out[8] -attr @rip pc_out[8] -port pc_out[8] -pin u_addr_mux pc_addr[8] -pin u_pc pc_out[8]
load net pc_out[9] -attr @rip pc_out[9] -port pc_out[9] -pin u_addr_mux pc_addr[9] -pin u_pc pc_out[9]
load net rd -pin u_ctrl rd -pin u_mem rd
netloc rd 1 2 4 700 10 NJ 10 NJ 10 1600
load net rst -port rst -pin u_acc rst -pin u_ctrl rst -pin u_ir rst -pin u_pc reset
netloc rst 1 0 6 20 350 NJ 350 NJ 350 NJ 350 1310 310 1680
load net sel -pin u_addr_mux sel -pin u_ctrl sel
netloc sel 1 1 5 350 410 NJ 410 NJ 410 NJ 410 1640
load net wr -pin u_ctrl wr -pin u_mem wr
netloc wr 1 2 4 680 290 NJ 290 1330J 250 1600
load netBundle @acc_out 32 acc_out[31] acc_out[30] acc_out[29] acc_out[28] acc_out[27] acc_out[26] acc_out[25] acc_out[24] acc_out[23] acc_out[22] acc_out[21] acc_out[20] acc_out[19] acc_out[18] acc_out[17] acc_out[16] acc_out[15] acc_out[14] acc_out[13] acc_out[12] acc_out[11] acc_out[10] acc_out[9] acc_out[8] acc_out[7] acc_out[6] acc_out[5] acc_out[4] acc_out[3] acc_out[2] acc_out[1] acc_out[0] -autobundled
netbloc @acc_out 1 2 5 720 270 1030 310 1290J 330 1660J 370 2030
load netBundle @pc_out 32 pc_out[31] pc_out[30] pc_out[29] pc_out[28] pc_out[27] pc_out[26] pc_out[25] pc_out[24] pc_out[23] pc_out[22] pc_out[21] pc_out[20] pc_out[19] pc_out[18] pc_out[17] pc_out[16] pc_out[15] pc_out[14] pc_out[13] pc_out[12] pc_out[11] pc_out[10] pc_out[9] pc_out[8] pc_out[7] pc_out[6] pc_out[5] pc_out[4] pc_out[3] pc_out[2] pc_out[1] pc_out[0] -autobundled
netbloc @pc_out 1 1 6 330 390 NJ 390 NJ 390 NJ 390 NJ 390 2050
load netBundle @mem_addr 32 mem_addr[31] mem_addr[30] mem_addr[29] mem_addr[28] mem_addr[27] mem_addr[26] mem_addr[25] mem_addr[24] mem_addr[23] mem_addr[22] mem_addr[21] mem_addr[20] mem_addr[19] mem_addr[18] mem_addr[17] mem_addr[16] mem_addr[15] mem_addr[14] mem_addr[13] mem_addr[12] mem_addr[11] mem_addr[10] mem_addr[9] mem_addr[8] mem_addr[7] mem_addr[6] mem_addr[5] mem_addr[4] mem_addr[3] mem_addr[2] mem_addr[1] mem_addr[0] -autobundled
netbloc @mem_addr 1 2 1 660 150n
load netBundle @alu_out 32 alu_out[31] alu_out[30] alu_out[29] alu_out[28] alu_out[27] alu_out[26] alu_out[25] alu_out[24] alu_out[23] alu_out[22] alu_out[21] alu_out[20] alu_out[19] alu_out[18] alu_out[17] alu_out[16] alu_out[15] alu_out[14] alu_out[13] alu_out[12] alu_out[11] alu_out[10] alu_out[9] alu_out[8] alu_out[7] alu_out[6] alu_out[5] alu_out[4] alu_out[3] alu_out[2] alu_out[1] alu_out[0] -autobundled
netbloc @alu_out 1 4 2 1350 270 NJ
load netBundle @opcode 3 opcode[2] opcode[1] opcode[0] -autobundled
netbloc @opcode 1 1 4 330J 90 NJ 90 1010 150 NJ
load netBundle @operand 32 operand[31] operand[30] operand[29] operand[28] operand[27] operand[26] operand[25] operand[24] operand[23] operand[22] operand[21] operand[20] operand[19] operand[18] operand[17] operand[16] operand[15] operand[14] operand[13] operand[12] operand[11] operand[10] operand[9] operand[8] operand[7] operand[6] operand[5] operand[4] operand[3] operand[2] operand[1] operand[0] -autobundled
netbloc @operand 1 1 5 350 190 640J 310 1010J 330 1270J 350 1760
load netBundle @mem_data_out 32 mem_data_out[31] mem_data_out[30] mem_data_out[29] mem_data_out[28] mem_data_out[27] mem_data_out[26] mem_data_out[25] mem_data_out[24] mem_data_out[23] mem_data_out[22] mem_data_out[21] mem_data_out[20] mem_data_out[19] mem_data_out[18] mem_data_out[17] mem_data_out[16] mem_data_out[15] mem_data_out[14] mem_data_out[13] mem_data_out[12] mem_data_out[11] mem_data_out[10] mem_data_out[9] mem_data_out[8] mem_data_out[7] mem_data_out[6] mem_data_out[5] mem_data_out[4] mem_data_out[3] mem_data_out[2] mem_data_out[1] mem_data_out[0] -autobundled
netbloc @mem_data_out 1 0 4 40 330 NJ 330 NJ 330 990
levelinfo -pg 1 0 160 460 820 1130 1470 1860 2070
pagesize -pg 1 -db -bbox -sgen -70 0 2210 420
show
fullfit
#
# initialize ictrl to current module RISC_CPU work:RISC_CPU:NOFILE
ictrl init topinfo |
