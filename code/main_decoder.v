

module main_decoder(
	input [6:0] op,
	output reg ResultSrc,
	output reg MemWrite,
	output reg AluSrc,
	output reg [1:0] ImmSrc,
	output reg RegWrite,
	output reg [1:0] Alu_op,
	output reg Branch
);

always@(*) begin

	case(op) 
	7'b000_0011 : begin
		      RegWrite <=1;
		      ImmSrc <= 2'b00;
		      AluSrc <= 1;
                      MemWrite <= 0;
                      ResultSrc <= 1;
		      Branch <= 0;
		      Alu_op <= 2'b00;
 	end
	7'b010_0011 : begin
		      RegWrite <=0;
		      ImmSrc <= 2'b01;
		      AluSrc <= 1;
                      MemWrite <= 1;
                      ResultSrc <= 1'bx	;
		      Branch <= 0;
		      Alu_op <= 2'b00;
 	end

	7'b011_0011 : begin
		      RegWrite <=1;
		      ImmSrc <= 2'bxx;
		      AluSrc <= 0;
                      MemWrite <= 0;
                      ResultSrc <= 0;
		      Branch <= 0;
		      Alu_op <= 2'b10;
 	end

	7'b001_0011 : begin
		      RegWrite <=1;
		      ImmSrc <= 2'b00;
		      AluSrc <= 1;
                      MemWrite <= 0;
                      ResultSrc <= 0;
		      Branch <= 0;
		      Alu_op <= 2'b10;
 	end

	7'b110_0011 : begin
		      RegWrite <=0;
		      ImmSrc <= 2'b10;
		      AluSrc <= 0;
                      MemWrite <= 0;
                      ResultSrc <= 1'bx;
		      Branch <= 1;
		      Alu_op <= 2'b01;
 	end

	default : 
		begin
		      RegWrite <=0;
		      ImmSrc <= 2'b00;
		      AluSrc <= 0;
                      MemWrite <= 0;
                      ResultSrc <= 0;
		      Branch <= 0;
		      Alu_op <= 2'b00;
	end

	endcase


end

endmodule

