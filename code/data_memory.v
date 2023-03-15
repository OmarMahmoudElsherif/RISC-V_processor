

module data_memory (
	input [31:0] A, // read/write port
	input clk,
	input WE, 	// write enable
	input [31:0] WD, 	// write data
	output [31:0] RD	// Read data
);


parameter Mem_data_width = 32;
parameter Mem_add_width = 64; // 64 entries
reg [Mem_data_width-1:0] Data_Memory [0: Mem_add_width-1];

// Read Asynchronous
//always@(A) begin
assign RD = Data_Memory[A];
//end

// Write Asynchronous
always@(posedge clk) begin
	if(WE==1)
		Data_Memory[A] <= WD;
end


endmodule

