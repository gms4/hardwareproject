module cpu (

    input wire clk,
    input wire reset

);

    //Control Wires  (mux)
    wire            Mux_WD_Memory_selector;
    wire            Mux_High_selector;
    wire            Mux_Low_selector;
    wire            Mux_Extend_selector;
    wire            Mux_B_selector;
    wire            Mux_Entrada_selector;
    wire            Mux_N_selector;
    wire[1:0]       Mux_A_selector;
    wire[1:0]       Mux_ALU1_selector; 
    wire[1:0]       Mux_ALU2_selector;  
    wire[1:0]       Mux_PC_selector;
    wire[1:0]       Mux_WR_Registers_selector;
    wire[2:0]       Mux_Address_selector;  
    wire[2:0]       Mux_WD_Registers_selector;

    //Control Wires  (Registers)
    wire            PC_Load;
    wire            Adress_RG_Load;
    wire            EPC_Load;
    wire            MDR_Load;
    wire            IR_Load;
    wire            High_Load;
    wire            Low_Load;
    wire            A_Load;
    wire            B_Load;
    wire            ALUOut_Load;

    //Control Wires  (Outros)
    wire            Store_Size_selector;
    wire [1:0]      Load_Size_selector;
    wire [2:0]      ULA_selector;
    wire [2:0]      Shift_selector;
    wire            Memory_WR;
    wire            Reg_WR;
    wire            PCWrite;
    wire            IsBEQ;              
    wire            IsBNE;
    wire            IsBLE;
    wire            IsBGT;
    wire            GT;
    wire            LT;
    wire            ZERO;
    wire            Reset_out;

    //Control Wires (Mult)
    wire            MultInit;
    wire            MultStop;

    //Data Wires (Registradores)
    wire [31:0]     PC_Out; 
    wire [31:0]     PC_Out;
    wire [31:0]     Adress_RG_Out;
    wire [31:0]     EPC_Out;
    wire [31:0]     MDR_Out;
    wire [31:0]     IR_Out;
    wire [31:0]     High_Out;
    wire [31:0]     Low_Out;
    wire [31:0]     A_Out;
    wire [31:0]     B_Out;
    wire [31:0]     ALUOut_Out;

    //Data Wires (Mux)
    wire [31:0]     Mux_PC_Out;
    wire [31:0]     Mux_Address_Out;  
    wire [31:0]     Mux_WD_Memory_Out;
    wire [4:0]      Mux_WR_Registers_Out;
    wire [31:0]     Mux_WD_Registers_Out;
    wire [31:0]     Mux_High_Out;
    wire [31:0]     Mux_Low_Out;
    wire [15:0]     Mux_Extend_Out;
    wire [31:0]     Mux_A_Out;
    wire [31:0]     Mux_B_Out;
    wire [31:0]     Mux_Entrada_Out;
    wire [4:0]      Mux_N_Out;
    wire [31:0]     Mux_ALU1_Out; 
    wire [31:0]     Mux_ALU2_Out;  
    wire [31:0]     Mux_PC_Out;

    //Data Wires (Outros)
    wire [31:0]     Store_Size_Out;
    wire [31:0]     Memory_Out;
    wire [5:0]      OPCODE;
    wire [4:0]      RS;
    wire [4:0]      RT;
    wire [15:0]     IMMEDIATE;
    wire [15:0]     Load_Size_OutDown;
    wire [31:0]     Load_Size_OutUp;
    wire [31:0]     The_Box_Out;
    wire [31:0]     The_Box2_Out;
    wire [31:0]     RegDesloc_Out;
    wire [31:0]     Sign_Extend1_32_Out;
    wire [31:0]     Read_Data1_Out;
    wire [31:0]     Read_Data2_Out;
    wire [31:0]     Mult_High_Out;
    wire [31:0]     Div_High_Out;
    wire [31:0]     Mult_Low_Out;
    wire [31:0]     Div_Low_Out;
    wire [31:0]     Sign_Extend16_32_Out;
    wire [31:0]     Shift_Left32_32_Out;
    wire [31:0]     Shift_Left26_28_Out;
    wire [31:0]     ALU_Result;


    Registrador PC_(
        clk,
        Reset_out,
        PC_Load,
        Mux_PC_Out,
        PC_Out
    );

    mux_Address mux_address_(
        Mux_Address_selector,
        PC_Out,
        ALUOut_Out,
        Mux_Address_Out
    );

    mux_WD_Memory mux_wd_MEM_(
        Mux_WD_Memory_selector,
        B_Out,
        Store_Size_Out,
        Mux_WD_Memory_Out
    );

    store_size store_size_(
        Store_Size_selector,
        MDR_Out,
        B_Out,
        Store_Size_Out
    );

    Registrador address_RG_(
        clk,
        Reset_out,
        Adress_RG_Load,
        PC_Out,
        Mux_Address_Out
    );

    Memoria MEM_(
        Mux_Address_Out,
        clk,
        Memory_WR,
        Mux_WD_Memory_Out,
        Memory_Out
    );

    Registrador mdr_(
        clk,
        Reset_out,
        MDR_Load,
        Memory_Out,
        MDR_Out
    );

    Registrador EPC_(
        clk,
        Reset_out,
        EPC_Load,
        Adress_RG_Out,
        EPC_out
    );

    Instr_Reg IR_(
        clk,
        Reset_out,
        IR_Load,
        Memory_Out,
        OPCODE,
        RS,
        RT,
        IMMEDIATE
    );


    load_size load_size_(

        Load_Size_selector,
        MDR_Out,
        Load_Size_OutDown,
        Load_Size_OutUp
    );

    the_box2 the_box2_(

       RS,
       RT,
       IMMEDIATE,
       The_Box2_Out

    );

    mux_WR_Registers mux_wr_reg_(
       
       Mux_WR_Registers_selector,
       RT,
       IMMEDIATE,
       Mux_WR_Registers_Out

    );

    mux_WD_Registers mux_wd_reg_(

       Mux_WD_Registers_selector,
       Load_Size_OutUp,
       ALUOut_Out,
       Low_Out,
       High_Out,
       RegDesloc_Out,
       Sign_Extend1_32_Out,
       Mux_WD_Registers_Out

    );

    Registrador high_(

        clk,
        Reset_out,
        High_Load,
        Mux_High_Out,
        High_Out

    );

    Registrador low_(

        clk,
        Reset_Out,
        Low_Load,
        Mux_Low_Out,
        Low_Out

    );

    Banco_reg registers_(

        clk,
        Reset_Out,
        Reg_WR,
        RT,
        RS,
        Mux_WR_Registers_Out,
        Mux_WD_Registers_Out,
        Read_Data1_Out,
        Read_Data2_Out

    );

    mux_High mux_high_(
        
        Mux_High_selector,
        Mult_High_Out,
        Div_High_Out,
        Mux_High_Out

    );

    mux_Low mux_low_(

        Mux_Low_selector,
        Mult_Low_Out,
        Div_Low_Out,
        Mux_Low_Out

    );

    mux_Extend mux_extend_(

        Mux_Extend_selector,
        Load_Size_OutDown,
        IMMEDIATE,
        Mux_Extend_Out

    );

    controller controller_(

       GT,
       ZERO,
       PCWrite,
       IsBEQ,
       IsBNE,
       IsBLE,
       IsBGT,
       PC_Load

    );

    mux_A mux_a_(

       Mux_A_selector,
       Memory_Out,
       Read_Data1_Out,
       Read_Data2_Out,
       Mux_A_Out

    );

    mux_B mux_b_(

        Mux_B_selector,
        Read_Data2_Out,
        Memory_Out,
        Mux_B_Out

    );

    RegDesloc reg_desloc_(
  
        clk,
        Reset_Out,
        Shift_selector,
        Mux_N_Out,
        Mux_Entrada_Out,
        RegDesloc_Out

    );

    mult mult_(   
        A_Out,
        B_Out,
        clk,
        Reset_Out,
        MultInit,
        MultStop,
        Mult_High_Out,
        Mult_Low_Out        
    );
        

    div div_(



    );

    sign_extend sign_extend_(

        Mux_Extend_Out,
        Sign_Extend16_32_Out

    );

    Registrador A_(

        clk,
        Reset_Out,
        A_Load,
        Mux_A_Out,
        A_Out

    );

     Registrador B_(

        clk,
        Reset_Out,
        B_Load,
        Mux_B_Out,
        B_Out

    );

    mux_Entrada mux_entrada_(

        Mux_Entrada_selector,
        A_Out,
        B_Out,
        Mux_Entrada_Out

    );

    mux_N mux_n_(

        Mux_N_selector,
        B_Out,
        IMMEDIATE,
        Mux_N_Out

    );

    shift_left32_32 shift_left32_32_(

        Sign_Extend16_32_Out,
        Shift_Left32_32_Out

    );

    shift_left26_28 shift_left26_28_(

        The_Box_Out,
        Shift_Left26_28_Out

    );

    mux_ALU1 Mux_ALU1_(

        Mux_ALU1_selector,
        PC_Out,
        A_Out,
        Mux_ALU1_Out

    );

    mux_ALU2 Mux_ALU2_(

        Mux_ALU2_selector,
        B_Out,
        Sign_Extend16_32_Out,
        Shift_Left32_32_Out,
        Mux_ALU2_Out

    );

    the_box the_box_(

        Shift_Left26_28_Out,
        PC_Out,
        The_Box_Out

    );

    sign_extend1_32 sign_extend1_32_(

        LT,
        Sign_Extend1_32_Out

    );

    Registrador ALUOut_(

        clk,
        Reset_Out,
        ALUOut_Load,
        ALU_Result,
        ALUOut_Out

    );

    mux_PC mux_PC_(

        Mux_PC_selector,
        EPC_Out,
        ALU_Result,
        ALUOut_Out,
        The_Box_Out,
        Mux_PC_Out

    );





endmodule