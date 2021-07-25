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
reg [4:0] counter; //(5 bit para representar o clk atual em um dado estado)

//STATE PARAMETERS

parameter State_Reset       =       6'b000000;
parameter State_Fetch       =       6'b000001;
parameter State_Decode      =       6'b000010;
parameter State_Overflow    =       6'b000011;
parameter State_Opcode404   =       6'b000100;
parameter State_Div0        =       6'b000101;

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
parameter State_Jal         =       6'b100111;

//Opcodes (istruction type)
parameter Op_Type_r         =       6'b000000;
parameter Op_Addi           =       6'b001000;
parameter Op_Addiu          =       6'b001001;
parameter Op_Beq            =       6'b000100;
parameter Op_Bne            =       6'b000101;
parameter Op_Ble            =       6'b000110;
parameter Op_Bgt            =       6'b000111;
parameter Op_Sllm           =       6'b000001;
parameter Op_Lb             =       6'b100000;
parameter Op_Lh             =       6'b100001;
parameter Op_Lui            =       6'b001111;
parameter Op_Lw             =       6'b100011;
parameter Op_Sb             =       6'b101000;
parameter Op_Sh             =       6'b101001;
parameter Op_Slti           =       6'b001010; 
parameter Op_Sw             =       6'b101011;
parameter Op_J              =       6'b000010;
parameter Op_Jal            =       6'b000011;

//Funct of type R
parameter Funct_Add         =       6'b100000;
parameter Funct_And         =       6'b100100;
parameter Funct_Div         =       6'b011010;
parameter Funct_Mult        =       6'b011000;
parameter Funct_Jr          =       6'b001000;
parameter Funct_Mfhi        =       6'b010000;
parameter Funct_Mflo        =       6'b010010; 
parameter Funct_Sll         =       6'b000000;
parameter Funct_Sllv        =       6'b000100;
parameter Funct_Slt         =       6'b101010;
parameter Funct_Sra         =       6'b000011;
parameter Funct_Srav        =       6'b000111;
parameter Funct_Srl         =       6'b000010;
parameter Funct_Sub         =       6'b100010;
parameter Funct_Break       =       6'b001101; 
parameter Funct_RTE         =       6'b010011;
parameter Funct_Addm        =       6'b000101;

initial begin
    //setar variaveis e coisas, uma ideia é colocar reset igual a 1
end

always @(posedge clk ) begin
    //RESET
    if (Reset_In == 1'b1) begin
        if (states != State_Reset) begin
            Adress_RG_Load      =   1'b0;
            EPC_Load            =   1'b0;
            MDR_Load            =   1'b0;
            IR_Load             =   1'b0;
            High_Load           =   1'b0;
            Low_Load            =   1'b0;
            A_Load              =   1'b0;
            B_Load              =   1'b0;
            ALUOut_Load         =   1'b0;
            Memory_WR           =   1'b0;
            Reg_WR              =   1'b0;
            PCWrite             =   1'b0;
            IsBEQ               =   1'b0;
            IsBNE               =   1'b0;
            IsBLE               =   1'b0;
            IsBGT               =   1'b0;
            Reset_Out           =   1'b1;        ////

            //next state
            states = State_Reset;
        end else begin
            Mux_WR_Registers    =   2'b001;      ////
            Mux_WD_Registers    =   3'b000;      ////
            Adress_RG_Load      =   1'b0;
            EPC_Load            =   1'b0;
            MDR_Load            =   1'b0;        
            IR_Load             =   1'b0;
            High_Load           =   1'b0;        
            Low_Load            =   1'b0;
            A_Load              =   1'b0;
            B_Load              =   1'b0;
            ALUOut_Load         =   1'b0;
            Memory_WR           =   1'b0;
            Reg_WR              =   1'b1;        ////
            PCWrite             =   1'b0;
            IsBEQ               =   1'b0;
            IsBNE               =   1'b0;
            IsBLE               =   1'b0;
            IsBGT               =   1'b0;
            Reset_Out           =   1'b0;

            //next state
            states = State_Fetch;
            counter = 5'b00000;
        end 
    end else begin
        case (states)
            //FETCH
            State_Fetch: begin
                if (counter == 5'b00000 || counter == 5'b00001 || counter == 5'b00010) begin
                    Mux_Address         =   3'b000; ////
                    Mux_ALU1            =   2'b00; ////
                    Mux_ALU2            =   2'b01; ////
                    ULA                 =   3'b001; ////
                    Adress_RG_Load      =   1'b1; ////
                    EPC_Load            =   1'b0;
                    MDR_Load            =   1'b0;
                    IR_Load             =   1'b0;
                    High_Load           =   1'b0;
                    Low_Load            =   1'b0;
                    A_Load              =   1'b0;
                    B_Load              =   1'b0;
                    ALUOut_Load         =   1'b1; ////
                    Memory_WR           =   1'b0;
                    Reg_WR              =   1'b0;
                    PCWrite             =   1'b0;
                    IsBEQ               =   1'b0;
                    IsBNE               =   1'b0;
                    IsBLE               =   1'b0;
                    IsBGT               =   1'b0;
                    Reset_Out           =   1'b0;

                    //next state
                    states = State_Fetch;
                    counter = counter + 5'b00001;
                end else if (counter == 5'b00011) begin
                    Mux_PC              =   2'b10; ////
                    Adress_RG_Load      =   1'b0;
                    EPC_Load            =   1'b0;
                    MDR_Load            =   1'b0;
                    IR_Load             =   1'b1; ////
                    High_Load           =   1'b0;
                    Low_Load            =   1'b0;
                    A_Load              =   1'b0;
                    B_Load              =   1'b0;
                    ALUOut_Load         =   1'b0;
                    Memory_WR           =   1'b0;
                    Reg_WR              =   1'b0;
                    PCWrite             =   1'b1; ////
                    IsBEQ               =   1'b0;
                    IsBNE               =   1'b0;
                    IsBLE               =   1'b0;
                    IsBGT               =   1'b0;
                    Reset_Out           =   1'b0;
                    //next state
                    states = State_Decode;
                    counter = 5'b00000;
                    end
            end 

            //DECODE
            State_Decode: begin
                if (counter == 5'b00000) begin
                    Mux_Extend          =   1'b1; ////
                    Mux_ALU1            =   2'b00; ////
                    Mux_ALU2            =   2'b00; ////
                    ULA                 =   3'b001; ////
                    Adress_RG_Load      =   1'b0;
                    EPC_Load            =   1'b0;
                    MDR_Load            =   1'b0;
                    IR_Load             =   1'b0;
                    High_Load           =   1'b0;
                    Low_Load            =   1'b0;
                    A_Load              =   1'b0;
                    B_Load              =   1'b0;
                    ALUOut_Load         =   1'b1; ////
                    Memory_WR           =   1'b0;
                    Reg_WR              =   1'b0;
                    PCWrite             =   1'b0;
                    IsBEQ               =   1'b0;
                    IsBNE               =   1'b0;
                    IsBLE               =   1'b0;
                    IsBGT               =   1'b0;
                    Reset_Out           =   1'b0;

                    //next state
                    states = State_Fetch;
                    counter = counter + 5'b00001;
                end else if (counter == 5'b00001) begin
                    Mux_A               =   2'b01; ////
                    Mux_B               =   1'b0; ////
                    Adress_RG_Load      =   1'b0;
                    EPC_Load            =   1'b0;
                    MDR_Load            =   1'b0;
                    IR_Load             =   1'b0;
                    High_Load           =   1'b0;
                    Low_Load            =   1'b0;
                    A_Load              =   1'b1; ////
                    B_Load              =   1'b1; ////
                    ALUOut_Load         =   1'b0;
                    Memory_WR           =   1'b0;
                    Reg_WR              =   1'b0;
                    PCWrite             =   1'b0;
                    IsBEQ               =   1'b0;
                    IsBNE               =   1'b0;
                    IsBLE               =   1'b0;
                    IsBGT               =   1'b0;
                    Reset_Out           =   1'b0;
                    //next state
                    counter = 5'b00000;
                    //criar case com tds os opcodes e funct
                end
            end

            //OVERFLOW
            State_Overflow: begin
            end

            //OPCODE INEXISTENTE
            State_Opcode404: begin
            end

            //DIVISAO POR 0
            State_Div0: begin
            end
            
            //ADD 
            State_Add: begin
            end

            //AND
            State_And: begin
            end

            //DIV
            State_Div: begin
            end

            //MULT
            State_Mult: begin
            end
            
            //JR
            State_Jr: begin
            end

            //MFHI
            State_Mfhi: begin
            end

            //MFLO
            State_Mflo: begin
            end

            //SLL
            State_Sll: begin
            end

            //SLLV
            State_Sllv: begin
            end

            //SLT
            State_Slt: begin
            end

            //SRA
            State_Sra: begin
            end
            
            //SRAV
            State_Srav: begin
            end

            //SRL
            State_Srl: begin
            end

            //SUB
            State_Sub: begin
            end

            //BREAK
            State_Break: begin
            end

            //RTE
            State_RTE: begin
            end

            //ADDM
            State_Addm: begin
            end

            //ADDI
            State_Addi: begin
            end

            //ADDIU
            State_Addiu: begin
            end

            //BEQ
            State_Beq: begin
            end

            //BNE
            State_Bne: begin
            end

            //BLE
            State_Ble: begin
            end
            
            //BGT
            State_Bgt: begin
            end

            //SLLM
            State_Sllm: begin
            end

            //LB
            State_Lb: begin
            end

            //LH
            State_Lh: begin
            end

            //LUI
            State_Lui: begin
            end

            //LW
            State_Lw: begin
            end

            //SB
            State_Sb: begin
            end

            //SH
            State_Sh: begin
            end

            //SLTI
            State_Slti: begin
            end

            //SW
            State_Sw: begin
            end

            //J
            State_J: begin
            end

            //JAL
            State_Jal: begin
                
            end
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

/* BASE CONTROLLERS
//Registers
Adress_RG_Load = 1'b0;
EPC_Load  = 1'b0;
MDR_Load  = 1'b0;
IR_Load  = 1'b0;
High_Load  = 1'b0;
Low_Load  = 1'b0;
A_Load  = 1'b0;
B_Load  = 1'b0;
ALUOut_Load = 1'b0;

//Write and Read Controllers
Memory_WR = 1'b0;
Reg_WR = 1'b0;

//Controlador Controllers
PCWrite = 1'b0;
IsBEQ = 1'b0;              //Antigo PCWriteCond
IsBNE = 1'b0;
IsBLE = 1'b0;
IsBGT = 1'b0;

//Special Controllers
Reset_Out = 1'b0;
*/

/* OTHER CONTROLLERS
//Muxs
***** 1 bit *****
Mux_WD_Memory,
Mux_High,
Mux_Low,
Mux_Extend,
Mux_B,
Mux_Entrada,
Mux_N,
***** 2 bits *****
Mux_A,               
Mux_ALU1,            
Mux_ALU2,            
Mux_PC,              
Mux_WR_Registers,    
***** 3 bits *****
Mux_Address,         
Mux_WD_Registers,    

//Write and Read Controllers
Store_Size,
Load_Size,

//Special Controllers
ULA,
Shift,
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
