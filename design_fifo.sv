// ================ RTL First In First Out ================ //

/* ================ About First in First Out ==============
https://semiconductorclub.com/what-is-fifo-synchronous-fifo-asynchronous-fifo/
============================================================ */

module FIFO # (parameter DEPTH = 16 , WIDTH = 32)( input clk ,
                                                input rst ,
                                                input wr_en ,
                                                input rd_en ,
                                                input [WIDTH-1 : 0] data_in ,
                                                output reg [WIDTH-1 : 0] data_out ,
                                                output reg full,
                                                output reg empty);
  //This is memory register where data in store during write operation which is 32 bit memory array which can store 8 elements in it.
  reg [WIDTH-1 : 0] memory [DEPTH - 1 : 0];
  
  // This calculate the bits required for DEPTH here DEPTH is 8 hence 3 bits will be required hence log2(8) = 3
  parameter DEPTH_LOG = $clog2(DEPTH); 
  
   // THis is write & read Pointer which store four bit [3:0] where 4th bit is used weather fifo is full or not where as lower 3 bits are used for indexing puropse 
  reg [DEPTH_LOG : 0] wr_pointer;
  reg [DEPTH_LOG : 0] rd_pointer; 
  
  initial begin 
    $display("DEPTH log : %0d" , DEPTH_LOG);
  end
  
  
  /* ===================== Using Counter ====================== */
  // Uncomment this to used count based 
  /* always @ (posedge clk or rst) begin
    if(rst == 0 ) begin
      wr_pointer = 0;
      rd_pointer = 0;
      count = 0;
    end
    else 
      case ({wr_en , rd_en})
        2'b00: count <= count;
        2'b01 : count <= count - 1;
        2'b10 : count <= count + 1;
        2'b11 : count <= count;
      endcase */
  
  //Write Operation 
  always @ (posedge clk or rst) begin
    if(rst == 0) begin
      wr_pointer = 0;
    end
    else if(!full && wr_en) begin
      memory[wr_pointer[DEPTH_LOG - 1 : 0]] <= data_in;
      wr_pointer <= wr_pointer + 1;
    end
  end
  
  //Read Operation 
  always @ (posedge clk or rst) begin 
    if(rst == 0) begin
      rd_pointer = 0;
    end 
    else if(!empty && rd_en) begin
      data_out <= memory[rd_pointer[DEPTH_LOG - 1 : 0]];
      rd_pointer <= rd_pointer + 1;
    end
  end
  
// Condition for Empty and Full based on pointer 
  assign empty = (rd_pointer == wr_pointer);
  assign full = (rd_pointer == {~wr_pointer[DEPTH_LOG] , wr_pointer[DEPTH_LOG - 1:0]});
  
  /* This condition is used in Counter based fifo */
  //Uncomment below 2 line to used based on counter and comment Condition based on pointer  
  /* assign full = (count == DEPTH);
  assign empty = (count == 0); */ 
  
endmodule