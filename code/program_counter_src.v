
module pc_src(
	input ZF,
	input SF,
	input branch,
	input [2:0] funct3,
	output reg PCSrc
);

wire BEQ, BNQ, BLT;
    always @(*) begin
        case (funct3)
            3'b000:  PCSrc <= branch & ZF; 
            3'b001:  PCSrc <= branch & ~ZF; 
            3'b100:  PCSrc <= branch & SF; 
            default: PCSrc <= 1'b0;
        endcase
    end


    assign BEQ = branch & ZF; 
    assign BNQ = branch & ~ZF; 
    assign BLT = branch & SF; 



endmodule

