`timescale 1ns / 1ps
// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Author : João Bittencourt
// File   : alu_tb.sv
// Editor : Sublime Text 3, tab size (3)
// -----------------------------------------------------------------------------
// Description:
//      Módulo de teste para a ALU do Lab2b
// -----------------------------------------------------------------------------

`default_nettype none

module alu_tb;

   localparam width = 8;

   // Entradas
   logic [width-1:0] A;
   logic [width-1:0] B;
   logic [4:0] ALUfn;

   // Saídas
   wire [width-1:0] R;
   wire FlagN, FlagC, FlagV, FlagZ;

   // Instancia a Unit Under Test (UUT)
   alu #(width) uut (.A(A), .B(B), .R(R), .ALUfn(ALUfn),
      .FlagN(FlagN), .FlagC(FlagC), .FlagV(FlagV), .FlagZ(FlagZ)
        );
   
   initial begin
      // Inicializa as Entradas
      A = 0;
      B = 0;
      ALUfn = 0;

      // Espera 2 ns
      #2;
        
      // Adicione os estímulos aqui
      // Entrada mudam a cada 1 ns, indo de 000 até 111

      `define ADD 5'b0xx01
      `define SUB 5'b1xx01
      `define SLL 5'bx0010
      `define SRL 5'bx1010
      `define SRA 5'bx1110
      `define AND 5'bx0000
      `define OR  5'bx0100
      `define XOR 5'bx1000
      `define NOR 5'bx1100

      #1 {A, B, ALUfn} = {8'd_10, 8'd_20, `ADD};            // 10 + 20
      #1 {A, B, ALUfn} = {8'd_100, 8'd_30, `ADD};           // 100 + 30
      #1 {A, B, ALUfn} = {8'd_10, 8'd_20, `SUB};            // 10 - 20      
      #1 {A, B, ALUfn} = {8'd_1, 8'd_1, `SUB};              // 1 - 1
      #1 {A, B, ALUfn} = {8'd_2, 8'd_20, `SLL};             // 20 << 2
      #1 {A, B, ALUfn} = {8'd_2, 8'd_20, `SRL};             // 20 >> 2
      #1 {A, B, ALUfn} = {8'd_1, 8'h_FE, `SRA};             // -2 >>> 1
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `AND};  // and
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `OR};   // or
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `XOR};  // xor
      #1 {A, B, ALUfn} = {8'b11110000, 8'b00111100, `NOR};  // nor
                                
      // Espere outros 5 ns, e então finalize a simulação
      #5 $finish;
   end
      
endmodule

