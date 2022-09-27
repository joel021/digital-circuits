`timescale 1ns / 1ps
`default_nettype none

module datapath #(
    parameter Nreg = 32,
    parameter Dbits = 32
) (
    input wire clk, reset, enable, sext, bsel, werf,
    input wire [Dbits-1:0] instr,
    input wire [1:0] pcsel, wasel, wdsel, asel,
    input wire [4:0] alufn,
    input wire [Dbits-1 : 0] mem_readdata,
    
    output wire Z,
    output wire [Dbits-1:0] mem_addr, mem_writedata, pc
);

    wire [Dbits-1:0] alu_result;
    wire [Dbits-1:0] ReadData1, ReadData2;
    wire [$clog2(Nreg)-1 : 0] ReadAddr1, ReadAddr2;
    wire [Dbits-1:0] BT, J, reg_writedata;

    wire [Dbits-1:0] new_pc, current_pc, pc_plus;

// ----------- INSTRUCTION READER ----------------------------
    assign J = { { current_pc[31:28], instr[25:0]}, 2'b00 }; // address to jump, on JUMP instruction
    assign pc = current_pc;
    assign pc_plus = current_pc + 32'd4;
    
    mux4 #(Dbits) new_pc_mux (.in0(pc_plus), .in1(BT), .in2(J), .in3(ReadData1), .sel(pcsel), .out(new_pc));
    synchronous_R program_counter (.clk(clk), 
                                    .reset(reset),
                                    .enable(enable),
                                    .input_v(new_pc),
                                    .output_v(current_pc));
    
// ------ FINISH INSTRUCTION READER ------------------------------


/// ----- REGISTER DECODER   ------------------------
  
    wire [$clog2(Dbits)-1:0] reg_writeaddr; // address to write data in the Register File

    mux4 #(5) reg_waddr_mux (.in0( instr[15:11]), .in1(instr[20:16]), .in2(5'b11111), .in3(5'b11011), .sel(wasel), .out(reg_writeaddr));
/*
    assign reg_writeaddr =  (wasel == 2'b01) ? instr[20:16] :
                            (wasel == 2'b10) ?  5'b11111:
                            (wasel == 2'b11) ? 5'b11011 : instr[15:11]; // x, z or 0 -> 0 position
*/
    register_file #(.Nloc(Nreg), .Dbits(Dbits)) reg_f  (.clk(clk),
                                                    .wr(werf), 
                                                    .ReadAddr1(instr[25:21]), 
                                                    .ReadAddr2(instr[20:16]), 
                                                    .WriteAddr(reg_writeaddr), 
                                                    .WriteData(reg_writedata), 
                                                    .ReadData1(ReadData1), 
                                                    .ReadData2(ReadData2));

// ----- FINISH REGISTER DECODER --------------------


// ----- EXECUTION MODEL ----------------------------
    
    wire [Dbits-1:0] aluA, aluB, signImm;

    // A value selector mux
    mux4 #(Dbits) A_mux (.in0(ReadData1), .in1({{(Dbits-5){1'b0}}, instr[10:6]}), .in2({{(Dbits-5){1'b0}}, 5'b10000}), .in3({(Dbits){1'b0}}), .sel(asel), .out(aluA));
    /*
    assign aluA =   (asel == 2'b01) ? {{(Dbits-5){1'b0}}, instr[10:6]} :
                    (asel == 2'b10) ? {{(Dbits-5){1'b0}}, 5'b10000}: ReadData1; //x,z or 0 -> 0 position
    */

    mux2 #(Dbits) signImm_mux (.in0({{16{1'b0}}, instr[15:0]}), .in1( {{16{instr[15]}}, instr[15:0]}), .sel(sext), .out(signImm));
    /*
    assign signImm = (sext) ? {{16{instr[15]}}, instr[15:0]} : {{16{1'b0}}, instr[15:0]} ; // sext block
    assign aluB = (bsel == 1'b1) ? signImm : ReadData2; //B selector mux
    */
    mux2 #(Dbits) B_mux (.in0(ReadData2), .in1(signImm), .sel(bsel), .out(aluB));
    alu #(.N(Dbits)) aluu (.A(aluA),
                            .B(aluB),
                            .R(alu_result), 
                            .ALUfn(alufn), 
                            .FlagZ(Z));

    assign BT = pc_plus + (signImm << 2);

// -------- FINISH EXECUTION MODEL ---------------------


/// --- WRITE REGISTER MUX ----------
    /*
    assign reg_writedata =  (wdsel == 2'b01) ? alu_result:
                            (wdsel == 2'b10) ? mem_readdata:
                            pc_plus; // xx, zz, 00 or 11 -> 0 position 
    */
    mux4 #(Dbits) reg_wd_mux (.in0(pc_plus), .in1(alu_result), .in2(mem_readdata), .in3({Dbits{1'b0}}), .sel(wdsel), .out(reg_writedata));

    assign mem_addr = alu_result;

    assign mem_writedata = ReadData2;

endmodule