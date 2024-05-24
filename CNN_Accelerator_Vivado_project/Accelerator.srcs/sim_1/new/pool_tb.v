`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/24 21:15:15
// Design Name: 
// Module Name: pool_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/24 21:14:47
// Design Name: 
// Module Name: conv_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module  pool_tb( );
// 定义常量
localparam CLK_PERIOD = 1000; // 时钟周期为1MHz，即1ns

// 信号声明
reg clk;
reg rst_n;
reg  [15:0] io_inAct_0   ;
reg  [15:0] io_inAct_1   ;
reg  [15:0] io_inAct_2   ;
reg  [15:0] io_inAct_3   ;
wire  valid;
wire  [15:0] io_outSum_0  ;


reg                 start;
reg              act_done;
reg              io_Max_MeanValid;
wire             Sum_valid;
reg              refresh;

    always #(CLK_PERIOD/2) clk=~clk;
    initial begin
        clk=1;
        rst_n=1;
        refresh=0;
        start=1'd0;
        io_inAct_0   =0;
        io_inAct_1   =0;
        io_inAct_2   =0;
        io_inAct_3   =0;
        io_Max_MeanValid=0;
        act_done =0;
        #CLK_PERIOD rst_n=0;
        #CLK_PERIOD;
        #CLK_PERIOD rst_n=1;

        #CLK_PERIOD start=1'd1;
        #CLK_PERIOD  start=1'd1;
        #CLK_PERIOD 
         io_inAct_0 = 4;
         io_inAct_1 = 8;
         io_inAct_2 = 12;
         io_inAct_3 = 16;
        #CLK_PERIOD 
         io_inAct_0 = 3;
         io_inAct_1 = 7;
         io_inAct_2 = 11;
         io_inAct_3 = 15;
        #CLK_PERIOD 
         io_inAct_0 = 2;
         io_inAct_1 = 6;
         io_inAct_2 = 10;
         io_inAct_3 = 14;
         #CLK_PERIOD 
         io_inAct_0 = 20;
         io_inAct_1 = 60;
         io_inAct_2 = 100;
         io_inAct_3 = 140;
        #CLK_PERIOD 
         io_inAct_0 = 1;
         io_inAct_1 = 5;
         io_inAct_2 = 9;
         io_inAct_3 = 13;
        start=0;
        #(10*CLK_PERIOD)
          start=0;
          
          refresh=1;
          io_Max_MeanValid=1;
        #CLK_PERIOD start=1'd0;
        #CLK_PERIOD 
         io_inAct_0 = 4;
         io_inAct_1 = 8;
         io_inAct_2 = 12;
         io_inAct_3 = 16;
        #CLK_PERIOD 
         io_inAct_0 = 3;
         io_inAct_1 = 7;
         io_inAct_2 = 11;
         io_inAct_3 = 15;
        #CLK_PERIOD 
         io_inAct_0 = 2;
         io_inAct_1 = 6;
         io_inAct_2 = 10;
         io_inAct_3 = 14;
         #CLK_PERIOD 
         io_inAct_0 = 20;
         io_inAct_1 = 60;
         io_inAct_2 = 100;
         io_inAct_3 = 140;
        #CLK_PERIOD 
         io_inAct_0 = 1;
         io_inAct_1 = 5;
         io_inAct_2 = 9;
         io_inAct_3 = 13;
         
        #CLK_PERIOD
          start=0;
        
    end
       
Pooling_Array_Control #(
    .DATA_WIDTH(16),
    .PARA_WIDTH(8),
    .POOL_KERNEL_SIZE(4) 
)pool_0(
  .clk           (clk),
  .rstn         (rst_n),
  .Pool_Kernel_Size ( 2  ),
  .Pool_Whole_Size(  4  ),
  .io_inAct      ({192'd0,{io_inAct_3,io_inAct_2,io_inAct_1,io_inAct_0}}),
  .start           (start),
  .io_Max_MeanValid(io_Max_MeanValid),
  .io_outSum       (io_outSum_0),
  .pool_finish      (    ),
  .out_valid       (valid)
);


endmodule



