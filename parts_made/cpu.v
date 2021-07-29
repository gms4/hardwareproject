module cpu (

    input wire clk,
    input wire reset

);

//control wires

    wire        PC_load;
    wire        MEM_w;
    wire        EPC_load;
    wire        IR_load;

    wire        muxWR;

    wire [2:0]  mux_address_selector;
    wire        mux_wd_MEM_selector;
    wire        address_RG_load;
    wire        mdr_load;
    wire        store_size_selector;

//data wires

    wire [31:0] ALUout_to_PC;
    wire [31:0] PC_out;
    wire [31:0] MEM_out;
    wire [5:0]  OPCODE;
    wire [4:0]  RS;
    wire [4:0]  RT;
    wire [15:0] IMMEDIATE;
    wire [4:0]  WR_in;
    wire [31:0] ALUout_to_muxaddress;
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

    Registrador PC_(

         clk,
         reset,
         PC_load,
         ALUout_to_PC,
         PC_out

    );

    Mux_Address mux_address_(

         mux_address_selector,
         PC_out,
         ALUout_to_muxaddress,
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

       
       
    );

    mux_WR_Registers muxWR_(
       
       muxWR, //selector
       RT,
       IMMEDIATE[15:11],
       WR_in,
       
    );