
module RV(
input [31:0] WD3,  // Data input
input [4:0] A1, //A1 is the register address from which the data are read through the output port RD1
input [4:0] A2,  //A2 is corresponding to the register address of output port RD2.
input [4:0] A3, // Write address
input WE3,  // write Enable 
input clk,
input Async_reset,
output reg [31:0] RD1,
output reg [31:0] RD2
);

reg [31:0] Registerfile [0:31];
integer i;

//Reading Asynchronously 
always@ (A1,A2) begin
RD1 <= Registerfile[A1];
RD2 <= Registerfile[A2];
end

// Synchronous Write
always @(posedge clk or negedge Async_reset) begin
	if(!Async_reset)   // active low
		for(i=0;i<32;i=i+1)
			 Registerfile[i] <= 0;   // clear all register file
	else if (WE3==1) begin
		Registerfile[A3] <= WD3;		
	end
	else begin
	RD1 <= RD1;
	RD2 <= RD2;
	end

end

endmodule
