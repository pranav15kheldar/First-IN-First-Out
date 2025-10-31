class fifo_enviroment;
    mailbox gen2driver;
    fifo_driver driver_env;
    fifo_generator generator_env;
    fifo_transaction transaction_env;
    virtual fifo_interface vir_inf_of_env;

    function  new(virtual fifo_interface vir_inf_of_env);
        this.vir_inf_of_env = vir_inf_of_env;
        gen2driver = new();
        driver_env = new(gen2driver , vir_inf_of_env);
        generator_env = new(gen2driver);
        transaction_env = new();
    endfunction

    task run();
        fork
            generator_env.main();
            driver_env.main();
        join
    endtask
endclass