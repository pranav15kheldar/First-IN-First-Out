class fifo_driver;
    virtual fifo_interface vir_fifoInterface;
    fifo_transaction fifoTras_of_driver;
    mailbox gen2driver;

    function new(mailbox gen2driver , virtual fifo_interface vir_fifoInterface);
        this.gen2driver = gen2driver;
        this.vir_fifoInterface = vir_fifoInterface;
    endfunction
    
    task main();
        forever begin
            @ (posedge vir_fifoInterface.clk);
            vir_fifoInterface.data_in <= fifoTras_of_driver.data_in;
            fifoTras_of_driver.data_out <= vir_fifoInterface.data_out;
            $display("*************************** Values at Driver *************************** ");
            $display("Data in : %d Data out %d" , fifoTras_of_driver.data_in , fifoTras_of_driver.data_out);
        end
    endtask
endclass