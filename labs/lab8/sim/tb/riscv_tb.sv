`timescale 1ns / 1ps

module riscv_tb;

   `define ALU_ADDU 5'b 0_xx_0_1 //add
   `define ALU_SUBU 5'b 1_xx_0_1 //sub
   `define ALU_SLT  5'b 1_x0_1_1 //less than
   `define ALU_SLTU 5'b 1_01_1_1 //less than unsigned
   `define ALU_AND  5'b x_00_0_0
   `define ALU_OR   5'b x_01_0_0
   `define ALU_XOR  5'b x_10_0_0
   `define ALU_LUI  5'b x_00_1_0 //shift left (B << A)
   `define ALU_SLL  5'b x_00_1_0 
   `define ALU_SRL  5'b x_10_1_0 //shift right logical
   `define ALU_SRA  5'b x_11_1_0 //shift right arithmatic
   `define ALU_NOR  5'b x_11_0_0
   `define ALU_XXX  5'b xxxxx

   // Inputs
   logic clk;
   logic reset;
   logic enable = 1'b1;
   
   // Signals inside top-level module uut
   wire [31:0] pc_plus        = uut.risc231_m1.dp.pc_plus;
   wire [31:0] new_pc_mux     = uut.risc231_m1.dp.inst_rd.new_pc_mux;
   wire [31:0] BT             = uut.risc231_m1.dp.inst_rd.BT;
   wire [31:0] JT             = uut.risc231_m1.dp.inst_rd.JT;
   wire [31:0] J              = uut.risc231_m1.dp.inst_rd.J;
   wire [31:0] pc             = uut.pc;                     // PC
   wire [31:0] instr          = uut.instr;                  // instr vinda da memória de instr
   wire [31:0] mem_addr       = uut.mem_addr;               // endereço enviado para a memória de dados
   wire        mem_wr         = uut.mem_wr;                 // write enable para a memória de dados
   wire [31:0] mem_readdata   = uut.mem_readdata;           // dado lido da memória de dados
   wire [31:0] mem_writedata  = uut.mem_writedata;          // dado enviado para escrita na memória de dados

   // Sinais dentro do módulo uut.risc231_m1
   wire        werf           = uut.risc231_m1.werf;              // WERF = write enable para o register file
   wire  [4:0] alufn          = uut.risc231_m1.alufn;             // função da ALU
   wire        Z              = uut.risc231_m1.Z;                 // flag Zero

   // Sinais dentro do módulo uut.risc231_m1.dp (datapath)
   wire [31:0] ReadData1      = uut.risc231_m1.dp.ReadData1;       // Reg[rs]
   wire [31:0] ReadData2      = uut.risc231_m1.dp.ReadData2;       // Reg[rt]
   wire [31:0] alu_result     = uut.risc231_m1.dp.alu_result;      // saída da ALU
   wire [4:0]  reg_writeaddr  = uut.risc231_m1.dp.reg_writeaddr;   // registrador de destino
   wire [31:0] reg_writedata  = uut.risc231_m1.dp.reg_writedata;   // dado a ser escrito no register file
   wire [31:0] signImm        = uut.risc231_m1.dp.signImm;         // imediado sign-/zero-extended
   wire [31:0] aluA           = uut.risc231_m1.dp.aluA;            // operando A da ALU
   wire [31:0] aluB           = uut.risc231_m1.dp.aluB;            // operando B da ALU

   // Sinais dentro do módulo uut.risc231_m1.c (controller)
   wire [1:0] pcsel           = uut.risc231_m1.c.pcsel;
   wire [1:0] wasel           = uut.risc231_m1.c.wasel;
   wire sext                  = uut.risc231_m1.c.sext;
   wire bsel                  = uut.risc231_m1.c.bsel;
   wire [1:0] wdsel           = uut.risc231_m1.c.wdsel;
   wire wr                    = uut.risc231_m1.c.wr;
   wire [1:0] asel            = uut.risc231_m1.c.asel;


   // Instancia a Unit Under Test (UUT)
   top #(
      .Dbits(32),                            // tamanho da palavra do processador
      .Nreg(32),                             // quantidade de registradores
      .imem_size(64),                        // tamanho da imem, deve ser >= # de instruções no programa
      .imem_init("../tests/full_imem.mem"),  // nome do arquivo com o programa a ser carregado na memória de instruções
      .dmem_size(64),                        // tamanho da dmem, deve ser >= # de palavras em dados do programa + tamanho da pilha
      .dmem_init("../tests/full_dmem.mem")   // nome do arquivo com o conteúdo inicial da memória de dados
   ) uut (
      .clk(clk), 
      .reset(reset),
      .enable(enable)
   );

   initial begin
      // Inicializa as entradas
      clk = 1'b0;
      reset = 1'b0;
      enable = 1'b1;
      #70.5 enable = 1'b0;
      #5  enable = 1'b1;
   end

   initial begin
      #0.5 clk = 0;
      forever
         #0.5 clk = ~clk;
   end

   initial begin
      #90 $finish;
   end

   initial begin
        $monitor("#%02d {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h%h, 32'h%h, 32'h%h, 1'b%b, 32'h%h, 32'h%h, 1'b%b, 5'b%b, 1'b%b, 32'h%h, 32'h%h, 32'h%h, 5'h%h, 32'h%h, 32'h%h, 32'h%h, 32'h%h, 2'b%b, 2'b%b, 1'b%b, 1'b%b, 2'b%b, 1'b%b, 2'b%b};",
        $time, pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel);
   
   end

endmodule