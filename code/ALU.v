
module ALU(
  input [31:0] A,B,
  input [2:0] sel,
  output [31:0] ALUResult,
  output ZF,SF,
  output reg CF
);

reg [32:0] R;
always@(*) begin
  case(sel)
   3'b000 : {CF,R} = A + B ;
   3'b001 : {CF,R} = A<<B ;
   3'b010 : {CF,R} = A - B ;
   3'b100 : {CF,R} = A ^ B ;
   3'b101 : {CF,R} = A>>B ;
   3'b110 : {CF,R} = A | B ;
   3'b111 : {CF,R} = A & B ;
   default : {CF,R} = 0;
  endcase  
end

assign ALUResult = R[31:0] ;
assign ZF = ~(|ALUResult);
assign SF =  ALUResult[31];

endmodule
