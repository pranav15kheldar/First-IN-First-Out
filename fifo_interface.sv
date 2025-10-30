interface fifo_interface();
    logic clk ,
    logic rst ,
    logic wr_en ,
    logic rd_en ,
    logic [WIDTH-1 : 0] data_in ,
    logic reg [WIDTH-1 : 0] data_out ,
    logic reg full,
    logic reg empt
endinterface