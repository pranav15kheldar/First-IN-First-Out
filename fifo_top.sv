module fifo_top ();
    import fifo_package::*;
    fifo_interface inf_test();
    fifo_test tt;
    FIFO F1(
        .clk(inf_test.clk),
        .rst(inf_test.rst),
        .wr_en(inf_test.wr_en),
        .rd_en(inf_test.rd_en),
        .data_in(inf_test.data_in),
        .data_out(inf_test.data_out),
        .full(inf_test.full),
        .empty(inf_test.empty)
    );

    initial begin
        inf_test.clk = 0;
        forever #5 inf_test.clk = ~inf_test.clk;
    end

    initial begin
        tt = new(inf_test);
        tt.run();
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        #200;
        $finish;
    end
endmodule