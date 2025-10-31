interface fifo_interface #(parameter WIDTH = 32 ) ;
    logic clk;
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [WIDTH-1 : 0] data_in;
    logic [WIDTH-1 : 0] data_out;
    logic full;
    logic empt;
endinterface