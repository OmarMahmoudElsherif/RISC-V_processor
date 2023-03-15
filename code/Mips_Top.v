
module Mips_Top (
	input clk,
	input Asyn_Reset
);

// Mips Instruction address and data.
wire [31:0] PC,Mips_Inst_data;

// Data Memory
wire [9:0]Data_mem;


//Control Unit Signals
//reg [6:0] Mips_op;
wire Mips_PCSrc;
wire Mips_ResultSrc;
wire Mips_MemWrite;
wire [2:0] Mips_AluCntrl;
wire Mips_AluSrc;
wire Mips_Branch;
wire [1:0] Mips_ImmSrc;
wire [1:0] Mips_ALUOP;
wire Mips_RegWrite;

// Sign Extend
wire [31:0]Mips_ImmExt;

// ALU
wire [31:0]Mips_RD1,Mips_RD2,Mips_SrcB,Mips_AluResult;

// Flags
wire Mips_ZF,Mips_SF,Mips_CF;

// Data Memory
wire [31:0] Mips_DataMem_RD;

// Register File
wire [31:0] Mips_RV_WD3;


// Main Decoder (control Unit)

main_decoder Mips_maindecoder (
	.op(Mips_Inst_data[6:0]),
	.ResultSrc(Mips_ResultSrc),
	.MemWrite(Mips_MemWrite),
	.AluSrc(Mips_AluSrc),
	.ImmSrc(Mips_ImmSrc),
	.RegWrite(Mips_RegWrite),
	.Alu_op(Mips_ALUOP),
	.Branch(Mips_Branch)
);

// ALU Decoder

alu_decoder Mips_ALU_Decoder (
	.alu_op(Mips_ALUOP),
	.funct3(Mips_Inst_data[14:12]),
	.funct7(Mips_Inst_data[30]),
	.op5(Mips_Inst_data[5]),
	.alu_control(Mips_AluCntrl)
);

// Sign Extend
sign_extend Mips_signExtend(
    .ImmExt(Mips_ImmExt),
    .ImmSrc(Mips_ImmSrc),
    .Instr(Mips_Inst_data)
);

//Mux for SrcB

mux_2x1 SrcB_mux_2x1(
	.in1(Mips_RD2),
	.in2(Mips_ImmExt),
	.sel(Mips_AluSrc),
	.out(Mips_SrcB)
);

// ALU 
ALU Mips_ALU(
  .A(Mips_RD1),
  .B(Mips_SrcB),
  .sel(Mips_AluCntrl),
  .ALUResult(Mips_AluResult),
  .ZF(Mips_ZF),
  .SF(Mips_SF),
  .CF(Mips_CF)
);

// PCSrc calculations
pc_src Mips_PCSrc_module(
	.ZF(Mips_ZF),
	.SF(Mips_SF),
	.branch(Mips_Branch),
	.funct3(Mips_Inst_data[14:12]),
	.PCSrc(Mips_PCSrc)
);

// PC unit
pc Mips_pc_module (
	.ImmExt(Mips_ImmExt),
	.clk(clk),
	.Async_reset(Asyn_Reset),
	.load(1'b1),
	.PCSrc(Mips_PCSrc),
	.pc(PC)
);

// Instruction Memory
inst_mem Mips_Inst_memory (
	.address(PC),
	.Instr(Mips_Inst_data)
);

// Data Memory 
data_memory Mips_data_Memory(
	.A(Mips_AluResult), 
	.clk(clk),
	.WE(Mips_MemWrite), 	
	.WD(Mips_RD2), 	
	.RD(Mips_DataMem_RD)
);


// Final Output Mux
mux_2x1 Result_mux(
	.in1(Mips_AluResult),
	.in2(Mips_DataMem_RD),
	.sel(Mips_ResultSrc),
	.out(Mips_RV_WD3)
);

// Register File
RV Mips_registerFile(
	.WD3(Mips_RV_WD3),  
	.A1(Mips_Inst_data[19:15]),
	.A2(Mips_Inst_data[24:20]),
	.A3(Mips_Inst_data[11:7]),
	.WE3(Mips_RegWrite),
	.clk(clk),
	.Async_reset(Asyn_Reset),
	.RD1(Mips_RD1),
	.RD2(Mips_RD2)
);




endmodule
