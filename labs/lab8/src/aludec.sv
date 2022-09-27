// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : aludec.v
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Decodificar a operação a ser realizada na ALU
// -----------------------------------------------------------------------------
// Entradas: 
//    opcode: os 6 bits mais significativos da instrução
//    funct : a função, no caso de instruções do tipo-R
// -----------------------------------------------------------------------------
// Saidas:
// 	aluop: A função escolhida para ser mapeada na ALU
// -----------------------------------------------------------------------------
`timescale 1ns / 1ps
`default_nettype none
`include "opcode.svh"
`include "aluop.svh"

module aludec(
   input  wire  [5:0] funct, opcode,
   output logic [4:0] alufn
);

   always @(*)
      case(opcode)                        // instruções não-tipo-R
         `LW: alufn <= `alu_ADD;                             // LW
         `SW: alufn <= `alu_ADD;                             // SW
         `ADDI: alufn <= `alu_ADD;                           // ADDI
         `ADDIU: alufn <= `alu_ADD;      // ADDIU
         `SLTI: alufn <= `alu_LT;
         `SLTIU: alufn <= `alu_LTU;
         `ORI: alufn <= `alu_OR;
         `LUI: alufn <= `alu_Lshift;
         `ANDI: alufn <= `alu_AND;
         `XORI: alufn <= `alu_XOR;
         `BEQ: alufn <= `alu_SUB;
         `BNE: alufn <= `alu_SUB;
         `RTYPE: 
            case(funct)                      // Tipo-R
               `ADD: alufn <= `alu_ADD;
               `ADDU:   alufn <= `alu_ADD; // ADD e ADDU
               `SUB:    alufn <= `alu_SUB; // SUB
               `AND: alufn <= `alu_AND;
               `OR: alufn <= `alu_OR;
               `XOR: alufn <= `alu_XOR;
               `NOR: alufn <= `alu_NOR;
               `SLT: alufn <= `alu_LT;
               `SLTU: alufn <= `alu_LTU;
               `SLL: alufn <= `alu_Lshift;
               `SLLV: alufn <= `alu_Lshift;
               `SRA: alufn <= `alu_Rsshift;
               `SRL: alufn <= `alu_Rshift;
               default: alufn <= 5'b xxxxx; // função desconhecida
            endcase
         default: alufn <= 5'b xxxxx;    // para todas as outras instruções, alufn é um don't-care.
    endcase
endmodule
