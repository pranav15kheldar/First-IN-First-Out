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
            gen2driver.get(fifoTras_of_driver);
            // Reset 
            vir_fifoInterface.rst <= 0;
            @ (posedge vir_fifoInterface.clk);
            vir_fifoInterface.rst <= 1;
            vir_fifoInterface.wr_en <= fifoTras_of_driver.wr_en; // Write enable send to interface 
            //Read
            vir_fifoInterface.rd_en <= fifoTras_of_driver.rd_en;
            vir_fifoInterface.data_in <= fifoTras_of_driver.data_in; // Data in is send to interface 
            fifoTras_of_driver.data_out <= vir_fifoInterface.data_out; // data out is taken From interface
            fifoTras_of_driver.full <= vir_fifoInterface.full; // Full Signal is taken From Interface 
            //Full 
            fifoTras_of_driver.full <= vir_fifoInterface.full;
            //Empty
           fifoTras_of_driver.empty <= vir_fifoInterface.empty;
            $display("*************************** Values at Driver *************************** ");
            $display("Data in : %d , Write Enable :%0d Read Enable :%0d, Data out %0d" , fifoTras_of_driver.data_in , fifoTras_of_driver.wr_en, fifoTras_of_driver.rd_en ,fifoTras_of_driver.data_out);
        end
    endtask
endclass