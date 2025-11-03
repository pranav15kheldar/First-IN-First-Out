class fifo_test;
    virtual fifo_interface vir_inf_test;
    fifo_enviroment env_Of_test;
    function  new(virtual fifo_interface vir_inf_test);
        this.vir_inf_test = vir_inf_test;
        env_Of_test = new(vir_inf_test);
    endfunction

    task run();
        fork
            env_Of_test.run();
        join
    endtask
endclass