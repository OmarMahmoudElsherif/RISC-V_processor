
module pc (
	input [31:0] ImmExt,
	input clk,
	input Async_reset,
	input load,
	input PCSrc,
	output reg [31:0] pc
);

reg [31:0] PC_next;

always@(*) begin
	if(PCSrc) 
		PC_next <= pc + ImmExt;
	else
		PC_next <= pc + 4; 
end

always@(posedge clk or negedge Async_reset) begin
	if(!Async_reset) begin  // active low reset
		pc <= 0;
	end
	else if(load==1 && Async_reset) begin
		pc <= PC_next;
	end
	else
		pc <= pc;   // to prevent unintentional latch
end

endmodule

