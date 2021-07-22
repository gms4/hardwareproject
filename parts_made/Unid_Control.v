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
output reg [1:0]    Mux_A, //3 entradas
output reg [1:0]    Mux_ALU1, //3 entradas
output reg [1:0]    Mux_ALU2, //4 entradas
output reg [1:0]    Mux_PC, //4 entradas
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
output reg          IsBEQ, //Antigo PCWriteCond
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
//Opcodes (istruction type)
parameter Type_r =   6'b000000;
parameter Addi   =   6'b001000;
parameter Addiu  =   6'b001001;
parameter Beq    =   6'b000100;
parameter Bne    =   6'b000101;
parameter Ble    =   6'b000110;
parameter Bgt    =   6'b000111;
parameter Sllm   =   6'b000001;
parameter Lb     =   6'b010100;
parameter Lh     =   6'b010101;
parameter Lui    =   6'b001111;
parameter Lw     =   6'b010111;
parameter Sb     =   6'b011100;
parameter Sh     =   6'b011101;
parameter Slti   =   6'b001010; 
parameter Sw     =   6'b101011;
parameter J      =   6'b000010;
parameter Jal    =   6'b000011;

//Funct of type R
parameter Add    =   6'b010100;
parameter And    =   6'b011000;
parameter Div    =   6'b011010;
parameter Mult   =   6'b010010;
parameter Jr     =   6'b001000;
parameter Mfhi   =   6'b001010;
parameter Mflo   =   6'b001100; 
parameter Sll    =   6'b000000;
parameter Sllv   =   6'b000100;
parameter Slt    =   6'b101010;
parameter Sra    =   6'b000011;
parameter Srav   =   6'b000111;
parameter Srl    =   6'b000010;
parameter Sub    =   6'b010110;
parameter Break  =   6'b001101; 
parameter RTE    =   6'b001110; //TIVEMOS QUE MODIFICAR, SENAO FICARIA IDENTICO AO BREAK
parameter Addm   =   6'b000101;

always @(posedge clk ) begin
    
end


endmodule

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