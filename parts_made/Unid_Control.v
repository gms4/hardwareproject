module Unid_Control (

//INPUT PORTS
input wire          clk,
input wire          Reset_In,
input wire [5:0]    Opcode,
input wire [5:0]    Funct,
input wire          Overflow,
input wire          Zero_Div,

//OUTPUT PORTS
//Muxs (até 2 entradas)
output reg          Mux_WD_Memory,
output reg          Mux_High,
output reg          Mux_Low,
output reg          Mux_Extend,
output reg          Mux_B,
output reg          Mux_Entrada,
output reg          Mux_N,

//Muxs (até 4 entradas)
output reg [1:0]    Mux_A,               //3 entradas
output reg [1:0]    Mux_ALU1,            //3 entradas
output reg [1:0]    Mux_ALU2,            //4 entradas
output reg [1:0]    Mux_PC,              //4 entradas
output reg [1:0]    Mux_WR_Registers,    //4 entradas

//Muxs (até 8 entradas)
output reg [2:0]    Mux_Address,         //5 entradas
output reg [2:0]    Mux_WD_Registers,    //7 entradas

//Registers
output reg          Adress_RG_Load,
output reg          EPC_Load,
output reg          MDR_Load,
output reg          IR_Load,
output reg          High_Load,
output reg          Low_Load,
output reg          A_Load,
output reg          B_Load,
output reg          ALUOut_Load,

//Write and Read Controllers
output reg [1:0]    Store_Size,
output reg [1:0]    Load_Size,
output reg          Memory_WR,
output reg          Reg_WR,

//Controlador Controllers
output reg          PCWrite,
output reg          IsBEQ,              //Antigo PCWriteCond
output reg          IsBNE,
output reg          IsBLE,
output reg          IsBGT,

//Special Controllers
output reg [2:0]    ULA,
output reg [2:0]    Shift,
output reg          Reset_Out
);

//VARIABLES

reg [5:0] states; //(6 bits para representar o estado atual)
reg [2:0] counter; // a qtd de bits sera definida pelo addm, mult e div

//STATE PARAMETERS

parameter State_Fetch       =       6'b000000;
parameter State_Decode      =       6'b000001;
parameter State_Overflow    =       6'b000010;
parameter State_Opcode404   =       6'b000011;
parameter State_Div0        =       6'b000100;
parameter State_Reset       =       6'b000101;

parameter State_Add         =       6'b000110;
parameter State_And         =       6'b000111;
parameter State_Div         =       6'b001000;
parameter State_Mult        =       6'b001001;
parameter State_Jr          =       6'b001010;
parameter State_Mfhi        =       6'b001011;
parameter State_Mflo        =       6'b001100;
parameter State_Sll         =       6'b001101;
parameter State_Sllv        =       6'b001110;
parameter State_Slt         =       6'b001111;
parameter State_Sra         =       6'b010000;
parameter State_Srav        =       6'b010001;
parameter State_Srl         =       6'b010010;
parameter State_Sub         =       6'b010011;
parameter State_Break       =       6'b010100;
parameter State_RTE         =       6'b010101;
parameter State_Addm        =       6'b010110;

parameter State_Addi        =       6'b010111;
parameter State_Addiu       =       6'b011000;
parameter State_Beq         =       6'b011001;
parameter State_Bne         =       6'b011010;
parameter State_Ble         =       6'b011011;
parameter State_Bgt         =       6'b011100; 
parameter State_Sllm        =       6'b011101;
parameter State_Lb          =       6'b011110;
parameter State_Lh          =       6'b011111;
parameter State_Lui         =       6'b100000;
parameter State_Lw          =       6'b100001;
parameter State_Sb          =       6'b100010;
parameter State_Sh          =       6'b100011;
parameter State_Slti        =       6'b100100;
parameter State_Sw          =       6'b100101;

parameter State_J           =       6'b100110;
parameter State_Jal         =       6'b100111 ;

//Opcodes (istruction type)
parameter Type_r            =       6'b000000;
parameter Addi              =       6'b001000;
parameter Addiu             =       6'b001001;
parameter Beq               =       6'b000100;
parameter Bne               =       6'b000101;
parameter Ble               =       6'b000110;
parameter Bgt               =       6'b000111;
parameter Sllm              =       6'b000001;
parameter Lb                =       6'b100000;
parameter Lh                =       6'b100001;
parameter Lui               =       6'b001111;
parameter Lw                =       6'b100011;
parameter Sb                =       6'b101000;
parameter Sh                =       6'b101001;
parameter Slti              =       6'b001010; 
parameter Sw                =       6'b101011;
parameter J                 =       6'b000010;
parameter Jal               =       6'b000011;

//Funct of type R
parameter Add               =       6'b100000;
parameter And               =       6'b100100;
parameter Div               =       6'b011010;
parameter Mult              =       6'b011000;
parameter Jr                =       6'b001000;
parameter Mfhi              =       6'b010000;
parameter Mflo              =       6'b010010; 
parameter Sll               =       6'b000000;
parameter Sllv              =       6'b000100;
parameter Slt               =       6'b101010;
parameter Sra               =       6'b000011;
parameter Srav              =       6'b000111;
parameter Srl               =       6'b000010;
parameter Sub               =       6'b100010;
parameter Break             =       6'b001101; 
parameter RTE               =       6'b010011;
parameter Addm              =       6'b000101;


initial begin
    //setar variaveis e coisas, uma ideia é colocar reset igual a 1
end

always @(posedge clk ) begin
    if (Reset_In == 1'b1) begin
        states = State_Reset;
    end else begin
        case (states)
            : 
            //fazer aqui um case com tds os states e o default ira ser o erro de opcode inexistente
            default: 
        endcase
    end

    //if reset
    //else if tratamento de excecoes //nao sera mais assim
    //else case (com opcode)
        //instruction tipo R
            //devem ter um case com funct
        //instruction tipo I
        //instruction tipo J
    
end


endmodule
/*
//Muxs
output reg          Mux_WD_Memory,
output reg          Mux_High,
output reg          Mux_Low,
output reg          Mux_Extend,
output reg          Mux_B,
output reg          Mux_Entrada,
output reg          Mux_N,
output reg [1:0]    Mux_A,               //3 entradas
output reg [1:0]    Mux_ALU1,            //3 entradas
output reg [1:0]    Mux_ALU2,            //4 entradas
output reg [1:0]    Mux_PC,              //4 entradas
output reg [1:0]    Mux_WR_Registers,    //4 entradas
output reg [2:0]    Mux_Address,         //5 entradas
output reg [2:0]    Mux_WD_Registers,    //7 entradas

//Registers
output reg          Adress_RG_Load,
output reg          EPC_Load,
output reg          MDR_Load,
output reg          IR_Load,
output reg          High_Load,
output reg          Low_Load,
output reg          A_Load,
output reg          B_Load,
output reg          ALUOut_Load,

//Write and Read Controllers
output reg [1:0]    Store_Size,
output reg [1:0]    Load_Size,
output reg          Memory_WR,
output reg          Reg_WR,

//Controlador Controllers
output reg          PCWrite,
output reg          IsBEQ,              //Antigo PCWriteCond
output reg          IsBNE,
output reg          IsBLE,
output reg          IsBGT,

//Special Controllers
output reg [2:0]    ULA,
output reg [2:0]    Shift,
output reg          Reset_Out
*/

/*
Add 
And
Div
Mult
Jr
Mfhi
Mflo
Sll
Sllv
Slt
Sra
Srav
Srl
Sub
Break
RTE
Addm

Addi
Addiu
Beq
Bne
Ble
Bgt
Sllm
Lb
Lh
Lui
Lw
Sb
Sh
Slti
Sw

J
Jal
*/
//no decode vamos colocar qual é o estado a partir do opcode e do funct, então depois fazemos um case com o estado para descobrir o que fazer
