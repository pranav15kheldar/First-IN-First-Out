class fifo_generator;
    fifo_transaction fifoTras; //Created transaction class handle
    mailbox gen2driver; // Mailbox to send data from generator to driver 
    function  new(mailbox gen2driver);
        this.gen2driver = gen2driver;
    endfunction

    constraint rd_en_c
    {
        fifoTras.wr_en ^ fifoTras.rd_en == 1;
    }
    task main();
        repeat(10) begin
            fifoTras = new();  // Object Created For Transcation 
            fifoTras.randomize(); // Randomize 
            $display(" ***************** Data Generated In Generator *******************");
            $display("Data in : %0d , Write Enable : %0d Reset : %0d" , fifoTras.data_in , fifoTras.wr_en , fifoTras.rst);
            gen2driver.put(fifoTras); // Put the data in mailbox to send to driver
        end
    endtask
endclass