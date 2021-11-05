// Code your design here
module fifo(clk,rst,wr_data,r_data,empty,full,wr_en,r_en);
  parameter size=8;
  parameter  DEPTH=16;
  parameter ptr_size=4;
  input clk,rst,wr_en,r_en;
  input[size-1:0] wr_data;
  output reg[size-1:0] r_data;
  output reg full,empty;
  
  reg[size-1:0]mem[DEPTH-1:0];
  
  reg[ptr_size-1:0] wr_ptr,r_ptr;
  reg wr_flg,r_flg;
  
  
  always@(posedge clk or negedge rst)begin
    if(!rst)begin
      r_data<=0;
      empty<=0;
      full<=0;
      r_ptr<=0;
      wr_ptr<=0;
      wr_flg<=0;
      r_flg<=0;
    end
    
    else if(wr_en==1) begin
        if(!full) begin
        mem[wr_ptr]<=wr_data;
        wr_ptr<=wr_ptr+1;
          if(wr_ptr==DEPTH-1)
            wr_flg=~wr_flg;
        end
      end
      
      else if(r_en==1) begin
        if(!empty) begin
          r_data<=mem[r_ptr];
          r_ptr<=r_ptr+1;
          if(r_ptr==DEPTH-1)
            r_flg=~r_flg;
        end
       end
  end // add a end here
    
      always@(*) begin
        if(wr_ptr==r_ptr && wr_flg!=r_flg)
          full=1;
        else if(wr_ptr==r_ptr && wr_flg==r_flg)
          empty=1;      
        else begin
          full=0;
          empty=0;
        end                       
      end 
    endmodule
 

      
   
  
    
      
      
    
    
