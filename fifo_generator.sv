class fifo_generator;
    fifo_transaction fifoTras; //Created transaction class handle
    mailbox gen2driver; // Mailbox to send data from generator to driver 
    function  new(mailbox gen2driver);
        this.gen2driver = gen2driver;
    endfunction

    task main();
        repeat(10) begin
            fifoTras = new();  // Object Created For Transcation 
            fifoTras.randomize(); // Randomize 
            $display(" ***************** Data Generated In Generator *******************");
            $display("Data in : %d" , fifoTras.data_in);
            gen2driver.put(fifoTras); // Put the data in mailbox to send to driver
        end
    endtask
endclass