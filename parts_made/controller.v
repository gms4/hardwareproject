module controller (

       input  wire gt,
       input  wire zero,
       input  wire pc_write,
       input  wire isBEQ,
       input  wire isBNE,
       input  wire isBGT,
       input  wire isBLE,
       output wire data_out

);

/*

pc_write ------------------------------------------\
                                                    |
zero  ----&                                         |
isBEQ ----&---out1-----||\                          |
                          |                         |-----data_out--->
zero  -~>-&               |---out5---\              |
isBNE ----&---out2-----||/            |             |
                                      |             |
gt --~>---&                           |---out7-----/
isBLE ----&---out3-----||\            |
                          |           |
gt -------&               |---out6---/
isBGT ----&---out4-----||/

*/

    assign data_out = (zero && isBEQ) || (!zero && isBNE) || !gt && isBLE || (gt && isBGT) || (pc_write);

endmodule