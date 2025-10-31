class fifo_transaction #(parameter WIDTH = 32);
    logic wr_en;
    logic rd_en;
    rand logic [WIDTH-1 : 0] data_in;
    logic [WIDTH-1 : 0] data_out;
    logic full;
    logic empt;
endclass