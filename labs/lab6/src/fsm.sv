// -----------------------------------------------------------------------------
// Universidade Federal do Recôncavo da Bahia
// -----------------------------------------------------------------------------
// Autor  	: joaocarlos joaocarlos@ufrb.edu.br
// Arquivo	: lab7_fsm_template.sv
// Editor 	: Visual Studio Code, tab size (3)
// -----------------------------------------------------------------------------
// Descrição:
//    Modelo de implementação de FSM em SystemVerilog
// -----------------------------------------------------------------------------
// Entradas: 
// 	  clk : clock da FSM
//      RESET : sinal de reset da FSM
// 	  inputs : especifique os sinais de entrada
// -----------------------------------------------------------------------------
// Saidas:
// 	  outputs : especifique os sinais de saída
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps
`default_nettype none

module fsm(
    input wire clk,
    input wire [2:0] key,        // Lista de entradas da FSM
    output logic up, pause    // Lista de saídas da FSM
                                          // As saídas devem ser sintetizadas como lógica combinacional!
    );


   // A próxima linha é o nossa codificação de estados
   // Aqui usamos o comando enum da SystemVerilog. Você enumera os estados e o compilador decide o padrão de codificação

   enum { CountingUp, CountingDown, PausingUp, PausingDown, ResumingUp, ResumingDown, PausedUp, PausedDown} state, next_state;

   // -- OU --   
   // Você pode especificar a codificação de estados

   //enum { STATE0=2'b00, STATE1=2'b01, STATE2=2'b10, ... etc. } state, next_state;



   // Instancia os elementos de armazenamento de estado (flip-flops)
   always @(posedge clk)
      state <= next_state;

   // Defina a lógica de próximo estado => combinatória
   // Cada clausula deve ser uma expressão condicional
   // ou um "if" com um "else"
    always @(*)     
      case (state)
            CountingUp: next_state <= (~key[2]) ? PausingUp : 
							(~key[1]) ? CountingDown : CountingUp;
							
            PausingUp: next_state <= (key[2]) ? PausedUp : PausingUp; // while the key2 is not turned off, do not do transaction. 
				
				CountingDown: next_state <= (~key[2]) ? PausingDown :
								(~key[0]) ? CountingUp : CountingDown;
								
				PausingDown: next_state <= (~key[2]) ? PausingDown : PausedDown;
				
				PausedDown: next_state <= (~key[2]) ? ResumingDown :
												(~key[0]) ? PausedUp : PausedDown;
												
				ResumingDown: next_state <= (~key[2]) ? ResumingDown : CountingDown;
				
				
				ResumingUp: next_state <= (~key[2]) ? ResumingUp : CountingUp;
				
				PausedUp: next_state <= (~key[1]) ? PausedDown : 
												(~key[2]) ? ResumingUp : PausedUp;
				
            default: next_state <= CountingUp;
      endcase



   // Defina a lógica de saída => combinatória
   // Cada clausula deve ser uma expressão condicional
   // ou um "if" com um "else"
    always @(*)     
      case (state)
            CountingUp: {up,pause} <= 2'b10;
            PausingUp: {up,pause} <= 2'b01;
            PausedUp: {up,pause} <= 2'b01;
				ResumingUp: {up,pause} <= 2'b10;
				CountingDown: {up,pause} <= 2'b00;
				ResumingDown: {up,pause} <= 2'b00;
				PausingDown: {up,pause} <= 2'b01;
				PausedDown: {up,pause} <= 2'b01;
           default: {up,pause} <= 2'b10;
      endcase

endmodule