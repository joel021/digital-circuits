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
// alterado por: Joel Pires
`timescale 10 us / 1 ns
`default_nettype none

module fsm(
    input wire clk,
    input wire reset,
    input wire [2:0] key,        // Lista de entradas da FSM
    output logic up, pause    // Lista de saídas da FSM
    );

   //states encoding
   //enum { CountingUp, CountingDown, PausingUp, PausingDown, ResumingUp, ResumingDown, PausedUp, PausedDown} state, next_state;
   typedef enum logic [2:0] { CountingUp=3'b000, CountingDown=3'b001, PausingUp=3'b010, PausingDown = 3'b011, ResumingUp = 3'b100, ResumingDown = 3'b101, PausedUp = 3'b110, PausedDown=3'b111} state_type;
   state_type state, next_state;
   
   //enum { CountingUp=3'b000, CountingDown=3'b001, PausingUp=3'b010, PausingDown = 3'b011, ResumingUp = 3'b100, ResumingDown = 3'b101, PausedUp = 3'b110, PausedDown=3'b111} state, next_state;

   // states elements: current state and next state
   always @(posedge clk)
      if (reset)
         state <= next_state;
      else
         state <= CountingUp;

   always @(*)
      case (state)
            CountingUp: next_state <= (~key[2]) ? PausingUp : 
							(~key[1]) ? CountingDown : CountingUp;
							
            PausingUp: next_state <= (~key[2]) ? PausingUp : PausedUp; // while the key2 is not turned off, do not do transaction. 
				
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

   //output logic
   always @(*)     
      case (state)
            CountingUp: {up,pause} <= 2'b10;
            PausingUp: {up,pause} <= 2'b11;
            PausedUp: {up,pause} <= 2'b11;
				ResumingUp: {up,pause} <= 2'b10;
				CountingDown: {up,pause} <= 2'b00;
				ResumingDown: {up,pause} <= 2'b00;
				PausingDown: {up,pause} <= 2'b01;
				PausedDown: {up,pause} <= 2'b01;
           default: {up,pause} <= 2'b10;
      endcase

endmodule