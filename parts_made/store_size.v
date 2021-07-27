module store_size (

    input  wire [31:0] mdr,
    input  wire [31:0] b,
    output reg  [31:0] data_out

);

wire aux;

assign aux = b[0]; //bit menos significativo: 0 = byte, 1 = halfword

always @ (*) begin
        if (aux == 0) begin //byte
            data_out = {mdr[31:8], b[7:0]};
        end
        else begin //halfword
            data_out = {mdr[31:16], b[15:0]};
        end
    end

endmodule 
