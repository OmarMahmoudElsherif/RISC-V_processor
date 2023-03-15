

module alu_decoder (
	input [1:0] alu_op,
	input [2:0]funct3,
	input funct7,
	input op5,
	output reg [2:0] alu_control
);
always@(*) begin
	
	case(alu_op) 
	2'b00: alu_control <= 3'b000; //add
	2'b01: begin
		case(funct3) 
		3'b000 : alu_control <= 3'b010; //sub
		3'b001 : alu_control <= 3'b010; //sub
		3'b100 : alu_control <= 3'b010; //sub
		default: alu_control<= 3'b000;
		endcase
	end
	
	2'b10 : begin
		case(funct3) 
		3'b000 : begin
			if({op5,funct7} != 2'b11) alu_control <= 000; //add
			else 	alu_control <= 3'b010; //sub
		end

		3'b001 : alu_control <= 3'b001; //Shift left
		3'b100 : alu_control <= 3'b100; //XOR
		3'b101 : alu_control <= 3'b101; //Shift right
		3'b110 : alu_control <= 3'b110; //
		3'b111 : alu_control <= 3'b111; //AND
		default: alu_control<= 3'b000;
		endcase
	end
	
	default: alu_control <= 000; //default value.

	endcase



end

endmodule
