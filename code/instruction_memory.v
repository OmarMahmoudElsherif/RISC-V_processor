	

module inst_mem (
	input [31:0] address,
	output [31:0] Instr
);

parameter Mem_data_width = 32;
parameter Mem_add_width = 64; // 64 entries
reg [Mem_data_width-1:0] Inst_Memory [0: Mem_add_width-1];


//Fibonacii code

/*assign Inst_Memory[0] = 32'h00004033;
assign Inst_Memory[1] = 32'h00000093;
assign Inst_Memory[2] = 32'h00100113;
assign Inst_Memory[3] = 32'h00100193;
assign Inst_Memory[4] = 32'h00100213;
assign Inst_Memory[5] = 32'h00000293;


assign Inst_Memory[6] = 32'h00a00313;
assign Inst_Memory[7] = 32'h00000393;
assign Inst_Memory[8] = 32'h00418c63;
assign Inst_Memory[9] = 32'h00110133;
assign Inst_Memory[10] = 32'h404181b3;
assign Inst_Memory[11] = 32'h00229393;
*/

initial begin
$readmemh("programcode.txt", Inst_Memory);	// Filling memory with our Code instructions
end

assign Instr = Inst_Memory[address[31:2]];


endmodule

