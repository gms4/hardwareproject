module cpu (

    input wire clk,
    input wire reset

);

//control wires

    wire        PC_load;
    wire        MEM_w;
    wire        EPC_load;
    wire        IR_load;
    wire        high_load; 
    wire        low_load;
    wire [2:0]  mux_address_selector;
    wire        mux_wd_MEM_selector;
    wire        address_RG_load;
    wire        mdr_load;
    wire        store_size_selector;
    wire [1:0]  mux_wr_reg_selector;
    wire [2:0]  mux_wd_reg_selector;
    wire        reg_wr;
    wire        mux_high_selector;
    wire        mux_low_selector;
    wire        mux_extend_selector;
    wire        gt;
    wire        zero;
    wire        isBEQ;
    wire        isBNE;
    wire        isBLE;
    wire        isBGT;

//data wires

    wire [31:0] ALUout;
    wire [31:0] PC_out;
    wire [31:0] MEM_out;
    wire [5:0]  OPCODE;
    wire [4:0]  RS;
    wire [4:0]  RT;
    wire [15:0] IMMEDIATE;
    wire [31:0] mux_address_out;
    wire [31:0] store_size_out;
    wire [31:0] B_out;
    wire [31:0] mux_wd_MEM_out;
    wire [31:0] MDR_out;
    wire [31:0] address_RG_out;
    wire [31:0] EPC_out;
    wire [15:0] load_size_to_mux_extend;
    wire [31:0] load_size_to_mux_WD_reg;
    wire [25:0] the_box2_out;
    wire [4:0]  mux_wr_reg_out;
    wire [31:0] low_out;
    wire [31:0] high_out;
    wire [31:0] RegDesloc_out;
    wire [31:0] sign_extend1_32_out;
    wire [31:0] mux_wd_reg_out;
    wire [31:0] mux_high_out;
    wire [31:0] mux_low_out;
    wire [31:0] read_data1_out;
    wire [31:0] read_data2_out;
    wire [31:0] mult_high_out;
    wire [31:0] div_high_out;
    wire [31:0] mult_low_out;
    wire [31:0] div_low_out;
    wire [15:0] mux_extend_out;


    Registrador PC_(

         clk,
         reset,
         PC_load,
         ALUout,
         PC_out

    );

    Mux_Address mux_address_(

         mux_address_selector,
         PC_out,
         ALUout,
         mux_address_out

    );

    Mux_WD_Memory mux_wd_MEM_(

        mux_wd_MEM_selector,
        B_out,
        store_size_out,
        mux_wd_MEM_out

    );

    store_size store_size_(
        
        store_size_selector,
        MDR_out,
        B_out,
        store_size_out

    );

    Registrador address_RG_(

         clk,
         reset,
         address_RG_load,
         PC_out,
         address_RG_out

    );


    Memoria MEM_(
        
        mux_address_out,
        clk,
        MEM_w,
        mux_wd_MEM_out,
        MEM_out

    );

    Registrador mdr_(

         clk,
         reset,
         mdr_load,
         MEM_out,
         MDR_out

    );

    Registrador EPC_(

         clk,
         reset,
         EPC_load,
         address_RG_out,
         EPC_out

    );


    Instr_Reg IR_(
       
       clk,
       reset,
       IR_load,
       MEM_out,
       OPCODE,
       RS,
       RT,
       IMMEDIATE

    );


    load_size load_size_(
       
       load_size_selector,
       MDR_out,
       load_size_to_mux_extend,
       load_size_to_mux_WD_reg

    );

    the_box2 the_box2_(
       
       RS,
       RT,
       IMMEDIATE,
       the_box2_out

    );

    mux_WR_Registers mux_wr_reg_(
       
       mux_wr_reg_selector,
       RT,
       IMMEDIATE,
       mux_wr_reg_out

    );

    mux_WD_Registers mux_wd_reg_(

       mux_wd_reg_selector,
       load_size_to_mux_WD_reg,
       ALUout,
       Low_out,
       High_out,
       RegDesloc_out,
       sign_extend1_32_out,
       mux_wd_reg_out

    );

    Registrador high_(

        clk,
        reset,
        high_load,
        mux_high_out,
        high_out

    );

    Registrador low_(

        clk,
        reset,
        low_load,
        mux_low_out,
        low_out

    );

    Banco_reg registers_(

        clk,
        reset,
        reg_wr,
        RT,
        RS,
        mux_wr_reg_out,
        mux_wd_reg_out,
        read_data1_out,
        read_data2_out

    );

    mux_High mux_high_(
        
        mux_high_selector,
        mult_high_out,
        div_high_out,
        mux_high_out

    );

    mux_Low mux_low_(

        mux_low_selector,
        mult_low_out,
        div_low_out,
        mux_low_out

    );

    mux_Extend mux_extend_(

        mux_extend_selector,
        load_size_to_mux_extend,
        IMMEDIATE,
        mux_extend_out

    );

    controller controller_(

       gt,
       zero,
       pc_write,
       isBEQ,
       isBNE,
       isBLE,
       isBGT,
       PC_load

    );

    