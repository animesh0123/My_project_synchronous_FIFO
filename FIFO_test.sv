module tb;
  parameter size=8;
  parameter  DEPTH=16;
  parameter ptr_size=4;
  reg clk,rst,wr_en,r_en;
  reg[size-1:0] wr_data;
  reg[size-1:0] r_data;
  wire full,empty;
  //reg[size-1:0]mem[DEPTH-1:0];
  //reg[ptr_size-1:0] wr_ptr,r_ptr;
  //reg wr_flg,r_flg;
  
  fifo fo(clk,rst,wr_data,r_data,empty,full,wr_en,r_en);
  
  initial begin 
    clk=0;
    rst=0;
    wr_en=0;
    r_en=0;
    #5 rst=1;
  end
  
  always #10 clk= ~clk;
  
  task write(integer count);
   // wr_en=1;
    repeat (count)begin
      wr_en=1;
      wr_data=$random;
      @(posedge clk);
    end
    wr_en=0; 
  endtask
  
  task read(integer count);
    r_en=1;
    repeat (count) begin
      @(posedge clk);
    end
      r_en=0;
  endtask   
  
  initial begin
    write(4);
    read(4);
    write(3);
    read(3);  
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #1000 $finish;
  end
endmodule // addd end module
    
    
  
  
  
