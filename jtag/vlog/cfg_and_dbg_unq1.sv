//
//--------------------------------------------------------------------------------
//          THIS FILE WAS AUTOMATICALLY GENERATED BY THE GENESIS2 ENGINE        
//  FOR MORE INFORMATION: OFER SHACHAM (CHIP GENESIS INC / STANFORD VLSI GROUP)
//    !! THIS VERSION OF GENESIS2 IS NOT FOR ANY COMMERCIAL USE !!
//     FOR COMMERCIAL LICENSE CONTACT SHACHAM@ALUMNI.STANFORD.EDU
//--------------------------------------------------------------------------------
//
//  
//	-----------------------------------------------
//	|            Genesis Release Info             |
//	|  $Change: 11904 $ --- $Date: 2013/08/03 $   |
//	-----------------------------------------------
//	
//
//  Source file: /Users/rdaly/CGRAGenerator/hardware/generator_z/jtag/Template/src/digital/cfg_and_dbg.svp
//  Source template: cfg_and_dbg
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter SC_CFG_IFC_REF 	= Data structure of type cfg_ifc
// Parameter SC_CFG_OPCODES 	= Data structure of type HASH
// Parameter TC_CFG_BUS 	= no
// Parameter SC_CFG_BUS 	= yes
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Command Line input (priority=4):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From XML input (priority=3):
//
//		---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
//
//	From Config File input (priority=2):
//
// ---------------- End Pre-Generation Pramameters Status Report ----------------

/* *****************************************************************************
 * File: cfg_and_dbg.vp
 * Author: Ofer Shacham
 * 
 * Description:
 * This module is used as the top of the JTAG accessed logic. It contains the 
 * tap as well as controllers for the boundary scan register and optionally
 * controllers for a reg-file chain which can be either on system clock or/and 
 * on JTAG clock.
 * 
 * The cfg and dbg module assumes that upon reads, the user knows that he/she
 * needs to wait for the data to arrive from the reg-file array, and would
 * add delay cycles as needed between loading the instruction and address to 
 * reading the data. 
 * 
 * REQUIRED GENESIS PARAMETERS:
 * ----------------------------
 * For the sys-clock domain ports
 * * SC_CFG_IFC_REF - An instance of the cfg_ifc (used as reference)
 * * SC_CFG_BUS - on/off or yes/no switch for the system clock domain config bus
 * * SC_CFG_OPCODES - Interpretation of the opcode. Must contain the following feilds:
 *    * nop - value of cfg2rf_op for a no-op (default is 0)
 *    * read - value of cfg2rf_op for a read operation (default is 1)
 *    * write - value of cfg2rf_op for a write operation (default is 2)
 *    * bypass - value of cfg2rf_op for bypassing the control signals (default is 3)
 * 
 * For the tck domain ports
 * * TC_CFG_IFC_REF - An instance of the cfg_ifc (used as reference)
 * * TC_CFG_BUS - on/off or yes/no switch for the jtag tck domain config bus
 * * TC_CFG_OPCODES - Interpretation of the opcode. Must contain the following feilds:
 *    * nop - value of cfg2rf_op for a no-op (default is 0)
 *    * read - value of cfg2rf_op for a read operation (default is 1)
 *    * write - value of cfg2rf_op for a write operation (default is 2)
 *    * bypass - value of cfg2rf_op for bypassing the control signals (default is 3)
 * 
 * 
 * Inputs:
 * -------
 * 
 * Outputs:
 * --------
 * 
 * Change bar:
 * -----------
 * Date          Author   Description
 * Mar 28, 2010  shacham  init version  --  
 * May 24, 2010  shacham  Replaced config bus signals and parameters with an 
 *			  interface. 
 * Apr 18, 2012  shacham  clean up of names and genesis syntactic sugar
 * May 20, 2014  jingpu   fixed legacy verilog syntax and fix idcode
 * ****************************************************************************/

// ACTUAL GENESIS2 PARAMETERIZATIONS
// SC_CFG_BUS (_GENESIS2_INHERITANCE_PRIORITY_) = yes
//
// SC_CFG_IFC_REF (_GENESIS2_INHERITANCE_PRIORITY_) = 
//	InstancePath:global_controller.jtag_controller.sc_jtag2gc_ifc (cfg_ifc_unq1)
//
// SC_CFG_OPCODES (_GENESIS2_INHERITANCE_PRIORITY_) = 
//	{ adv_clk=>13, bypass=>3, global_reset=>10, nop=>0, rd_TST=>9, rd_analog_reg=>21, rd_delay_sel_reg=>19, rd_rd_delay_reg=>17, 
//	  read=>2, read_stall=>12, sys_clk_on=>15, wr_A050=>7, wr_analog_reg=>20, wr_delay_sel_reg=>18, wr_rd_delay_reg=>16, wr_to_TST=>8, 
//	  write=>1, write_stall=>11 }
//
// TC_CFG_BUS (_GENESIS2_INHERITANCE_PRIORITY_) = no
//
// TC_CFG_IFC_REF (_GENESIS2_DECLARATION_PRIORITY_) = 
//
// TC_CFG_OPCODES (_GENESIS2_DECLARATION_PRIORITY_) = 
//	{ bypass=>3, nop=>0, read=>1, write=>2 }
//


module cfg_and_dbg_unq1
  (
   // Signals for a system clked configuration bus
   cfg_ifc_unq1.cfgOut sc_cfgReq,
   cfg_ifc_unq1.cfgIn sc_cfgRep,

   // system clock and reset
   input                                logic Clk,
   input             	                logic Reset,
   
   // Signals for a jtag clked configuration bus
 
   // Signals for the Boundary Scan Register
    output 				logic bsr_tdi,
    output 				logic bsr_sample,
    output 				logic bsr_intest,
    output 				logic bsr_extest,
    output 				logic bsr_update_en,
    output 				logic bsr_capture_en,
    output 				logic bsr_shift_dr,
    input 				logic bsr_tdo,

    //Is global controller running on sys clk? or still on test clk?
    input	 logic sys_clk_activated,


    input        logic  tms,          	// JTAG Test Mode Select
    input        logic  tck,          	// JTAG Test Clock
    input        logic  trst_n,         // JTAG Test Reset
    input        logic  tdi,          	// JTAG Test Data Input
    output       logic  tdo,	      	// JTAG Test Data Output
    output       logic  tdo_en	        // JTAG Test Data Output
    );

   // reset signal for jtag domain registers
   logic 	  test_logic_reset;
   

   // Signals comming from the tap for the special instructions
   // for the sys-clock config bus
   // sc_cfg_data
   logic 	  sc_cfg_data_capture_dr;		
   logic 	  sc_cfg_data_shift_dr;			
   logic 	  sc_cfg_data_update_dr;		
   logic 	  sc_cfg_data_tdo;
   // sc_cfg_inst				
   logic 	  sc_cfg_inst_capture_dr;		
   logic 	  sc_cfg_inst_shift_dr;			
   logic 	  sc_cfg_inst_update_dr;		
   logic 	  sc_cfg_inst_tdo;
   // sc_cfg_addr				
   logic 	  sc_cfg_addr_capture_dr;		
   logic 	  sc_cfg_addr_shift_dr;			
   logic 	  sc_cfg_addr_update_dr;		
   logic 	  sc_cfg_addr_tdo;

   // for the jtag-clock config bus

   // Instantiate the Test Access Port (TAP)
   tap_unq1 tap 
     (
      // JTAG signals
      .tms(tms),
      .tck(tck),
      .trst_n(trst_n),
      .tdi(tdi),
      .tdo(tdo),
      .tdo_en(tdo_en),
      
      // sc_cfg_data
      .sc_cfg_data_capture_dr(sc_cfg_data_capture_dr),		
      .sc_cfg_data_shift_dr(sc_cfg_data_shift_dr),			
      .sc_cfg_data_update_dr(sc_cfg_data_update_dr),		
      .sc_cfg_data_tdo(sc_cfg_data_tdo),
				
      // sc_cfg_inst				
      .sc_cfg_inst_capture_dr(sc_cfg_inst_capture_dr),		
      .sc_cfg_inst_shift_dr(sc_cfg_inst_shift_dr),			
      .sc_cfg_inst_update_dr(sc_cfg_inst_update_dr),		
      .sc_cfg_inst_tdo(sc_cfg_inst_tdo),
      						
      // sc_cfg_addr				
      .sc_cfg_addr_capture_dr(sc_cfg_addr_capture_dr),		
      .sc_cfg_addr_shift_dr(sc_cfg_addr_shift_dr),			
      .sc_cfg_addr_update_dr(sc_cfg_addr_update_dr),		
      .sc_cfg_addr_tdo(sc_cfg_addr_tdo),
      						
      .test_logic_reset(test_logic_reset),

      
      // BSR interface
      .bsr_extest(bsr_extest),
      .bsr_intest(bsr_intest),
      .bsr_sample(bsr_sample),
      .bsr_capture_en(bsr_capture_en),
      .bsr_shift_dr(bsr_shift_dr),
      .bsr_update_en(bsr_update_en),
      .bsr_tdo(bsr_tdo)
      );
   


   /************ Logic for controlling the system-clock config bus ************/
   // Since this cfg interface is all on the system clock, life is more
   // interesting. We need to cross domains by qualifying the output signals.
   // * Since outputs are only considered when the instruction is meanningful--
   //   we'll qualify the sc_cfgReq.op by creating a qualified update signal.
   // * JTAG only samples the input after the read completed. We already
   // assumed (see header) that the frequency of jtag ops is lower then it takes
   // to go through the chain of reg-files.
   /***************************************************************************/
   // shift in/out the instuction
   logic [4:0] sc_inst;
   flop_unq1 sc_inst_reg 
     (.dout(sc_inst),	.din({tdi, sc_inst[4:1]}),
      .Clk(tck),	.en(sc_cfg_inst_shift_dr),      .Reset(test_logic_reset));

   // Qualify the instruction
   logic [3:0] inst_update_qual;
   logic       inst_update_qualified;
   assign inst_update_qualified = ((sys_clk_activated & inst_update_qual==4'b1110) | (!sys_clk_activated & inst_update_qual[3]==1)) ? 1'b1:1'b0;
   flop_unq2 inst_update_reg 
     (.dout(inst_update_qual),	.din({sc_cfg_inst_update_dr, inst_update_qual[3:1]}),
      .Clk(Clk),	.Reset(Reset));
   

   // assign transaction to the bus on update (pulse)
   assign 			   sc_cfgReq.op = (inst_update_qualified) ? 
						   sc_inst : 5'd0;
   // assign tdo with instruction always
   assign 			   sc_cfg_inst_tdo = sc_inst[0];
   //*******

   
   //*******
   // shift in/out the address
   logic [31:0] sc_addr;
   flop_unq3  sc_addr_reg 
     (.dout(sc_addr),	.din({tdi, sc_addr[31:1]}),
      .Clk(tck),	.en(sc_cfg_addr_shift_dr),      .Reset(test_logic_reset));

   // assign bus / tdo with address (always)
   assign 			     sc_cfgReq.addr = sc_addr;
   assign 			     sc_cfg_addr_tdo = sc_addr[0];
   //*******


   //*******
   // register for the received data until the jtag interface asks for it
   logic [31:0] sc_data_rd;
   logic 			   sc_data_rd_en;
   assign 			   sc_data_rd_en = (sc_cfgRep.op == 5'd3)? 
						   1'b1: 1'b0;
   flop_unq3 sc_data_rd_reg 
     (.dout(sc_data_rd),	.din(sc_cfgRep.data),
      .Clk(Clk),	.en(sc_data_rd_en),      
      .Reset(Reset));
   //*******

   
   //*******
   // shift in/out the data
   logic [31:0] sc_data;
   logic [31:0] sc_data_nxt;
   assign 			     sc_data_nxt = (sc_cfg_data_capture_dr) ? 
						    sc_data_rd : {tdi, sc_data[31:1]};
   
   flop_unq3 sc_data_reg 
     (.dout(sc_data),	.din(sc_data_nxt),
      .Clk(tck),	.en(sc_cfg_data_shift_dr | sc_cfg_data_capture_dr),      
      .Reset(test_logic_reset));

   // assign bus / tdo with data (always)
   assign 			     sc_cfgReq.data = sc_data;
   assign sc_cfg_data_tdo = sc_data[0];
   //*******

   
   /***************************************************************************/

   

endmodule // cfg_and_dbg_unq1
