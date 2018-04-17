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
//  Source file: /Users/rdaly/CGRAGenerator/hardware/generator_z/global_controller/analog_regfile.vp
//  Source template: analog_regfile
//
// --------------- Begin Pre-Generation Parameters Status Report ---------------
//
//	From 'generate' statement (priority=5):
// Parameter num_regs 	= 16
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

/********************************************************************
Control Registers for analog stuff in CGRA
********************************************************************/

// data_width (_GENESIS2_DECLARATION_PRIORITY_) = 32
//
// num_regs (_GENESIS2_INHERITANCE_PRIORITY_) = 16
//
// addr_width (_GENESIS2_DECLARATION_PRIORITY_) = 32
//

module analog_regfile (
addr,
data_in,
wr_en,
r0,
r1,
r2,
r3,
r4,
r5,
r6,
r7,
r8,
r9,
r10,
r11,
r12,
r13,
r14,
r15,
clk,
reset
);

input clk;
input reset;
input wr_en;
input [31:0] addr;
input [31:0] data_in;
output reg [31:0] r0;
output reg [31:0] r1;
output reg [31:0] r2;
output reg [31:0] r3;
output reg [31:0] r4;
output reg [31:0] r5;
output reg [31:0] r6;
output reg [31:0] r7;
output reg [31:0] r8;
output reg [31:0] r9;
output reg [31:0] r10;
output reg [31:0] r11;
output reg [31:0] r12;
output reg [31:0] r13;
output reg [31:0] r14;
output reg [31:0] r15;

always @ (posedge clk or posedge reset) begin
	if(reset==1) begin
		r0 <= 32'b0;
		r1 <= 32'b0;
		r2 <= 32'b0;
		r3 <= 32'b0;
		r4 <= 32'b0;
		r5 <= 32'b0;
		r6 <= 32'b0;
		r7 <= 32'b0;
		r8 <= 32'b0;
		r9 <= 32'b0;
		r10 <= 32'b0;
		r11 <= 32'b0;
		r12 <= 32'b0;
		r13 <= 32'b0;
		r14 <= 32'b0;
		r15 <= 32'b0;
	end //if reset
	else if(wr_en == 1) begin
		case(addr)
			32'd0: begin
				r0 <= data_in;
			end
			32'd1: begin
				r1 <= data_in;
			end
			32'd2: begin
				r2 <= data_in;
			end
			32'd3: begin
				r3 <= data_in;
			end
			32'd4: begin
				r4 <= data_in;
			end
			32'd5: begin
				r5 <= data_in;
			end
			32'd6: begin
				r6 <= data_in;
			end
			32'd7: begin
				r7 <= data_in;
			end
			32'd8: begin
				r8 <= data_in;
			end
			32'd9: begin
				r9 <= data_in;
			end
			32'd10: begin
				r10 <= data_in;
			end
			32'd11: begin
				r11 <= data_in;
			end
			32'd12: begin
				r12 <= data_in;
			end
			32'd13: begin
				r13 <= data_in;
			end
			32'd14: begin
				r14 <= data_in;
			end
			32'd15: begin
				r15 <= data_in;
			end
		endcase

	end //else	
end //always


endmodule
