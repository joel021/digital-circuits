// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : <seu nome aqui> <seu email>
// File   : controller.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Module Purpose:
//		Unidade de controle para o processador RISC231-M1
// -----------------------------------------------------------------------------
// Entradas: 
// 	enable : sinal de controle de escrita
// 	op     : opcode da instrução
// 	func   : função para instruções R-type
//    Z      : flag zero vinda da ALU
// -----------------------------------------------------------------------------					
// Saidas:
// 	pcsel  : seletor do multiplexador de PC.
//    wasel  : seletor do multiplexador do endereço de escrita no register file
//    sext   : controle do sign extend (0 zero-extends, 1 sign-extends)
//    bsel   : seletor do multiplexador da entrada B da ALU
//    wdsel  : seletor do multiplexador de dados de escrita no register file
//    alufn  : função a ser executada pela ALU
//    wr     : write enable da memória de dados
//    werf   : write enable do register file
//    asel   : seletor do multiplexador da entrada A da ALU
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps
`default_nettype none
`include "opcode.svh"

module controller(
   // NÃO MODIFICAR
   input  wire enable,
   input  wire [5:0] op, 
   input  wire [5:0] func,
   input  wire Z,
   output wire [1:0] pcsel,
   output wire [1:0] wasel, 
   output wire sext,
   output wire bsel,
   output wire [1:0] wdsel, 
   output logic [4:0] alufn, 	   // vai virar um wire
   output wire wr,
   output wire werf, 
   output wire [1:0] asel
   ); 

   // MODIFIQUE o código abaixo preenchendo as partes que faltam
   assign pcsel = ((op == 6'b0) & (func == `JR)) ? 2'b11 //R-type
               : (op == `J || op == `JAL) ? 2'b10 // J-type
               : (op == `BEQ) ? {1'b0,Z} //I-type
               : (op == `BNE) ? {1'b0,~Z} //I-type
               : 2'b0;

  logic [9:0] controls;                // vai virar um conjunt de wires
  wire _werf_, _wr_;                   // precisa de uma AND com o enable para "congelar" o processador
  assign werf = _werf_ & enable;       // desativa as escritas no registrador quando o processador está desativado
  assign wr = _wr_ & enable;           // destiva a escrita na memória quando o processador está desativado 
 
  assign {_werf_, wdsel[1:0], wasel[1:0], asel[1:0], bsel, sext, _wr_} = controls[9:0];

  initial controls <= 10'b 0_xx_xx_xx_x_0_0;

  always@(*)
     case(op)                                       // instruções não-tipo-R 
         `LW: controls <= 10'b 1_10_01_00_1_1_0;     // LW
         `SW: controls <= 10'b 0_xx_xx_00_1_1_1;                         // SW
         `ADDI: controls <= 10'b 1_01_01_00_1_1_0;                                        // ADDI
         `ADDIU: controls <= 10'b 1_01_01_00_1_1_0;                                      // ADDIU
         `SLTI: controls <= 10'b 1_01_01_00_1_1_0;     // SLTI
         `SLTIU: controls <= 10'b 1_01_01_00_1_1_0; //sext can be equals 1 too in this case.
         `ORI: controls <= 10'b 1_01_01_00_1_0_0;   // ORI
         `LUI: controls <= 10'b 1_01_01_10_1_1_0;
         `ANDI: controls <= 10'b 1_01_01_00_1_0_0;
         `XORI: controls <= 10'b 1_01_01_00_1_0_0; //sext = 0
         `BEQ: controls <= 10'b 0_xx_xx_00_0_1_0;
         `BNE: controls <= 10'b 0_xx_xx_00_0_1_0;
         `J: controls <= 10'b 0_xx_xx_xx_x_0_0;
         `JAL: controls <= 10'b 1_00_10_xx_x_0_0; // set ext = 0 as default
         `RTYPE:

            if (func == `SLL || func == `SRA || func == `SRL) begin
               controls <= 10'b 1_01_00_01_0_0_0;
            end else if (func == `JR) begin
               controls <= 10'b 0_xx_xx_xx_x_0_0;
            end else begin
               controls <= 10'b 1_01_00_00_0_0_0;
            end

         default: controls <= 10'b 0_xx_xx_xx_x_0_0;         // instrução desconhecida, desative a escrita no registrador e na memória
      endcase
    
   aludec alu_decoder (
      .funct(func),
      .opcode(op),
      .alufn(alufn)
   );
    
endmodule
