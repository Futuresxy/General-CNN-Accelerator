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

module conv_tb( );
// 定义常量
localparam CLK_PERIOD = 10; // 时钟周期为100MHz，

// 信号声明
reg clk;
reg rst_n;
parameter DATA_WIDTH = 8;
reg   [DATA_WIDTH-1:0] io_inAct_0   ;
reg   [DATA_WIDTH-1:0] io_inAct_1   ;
reg   [DATA_WIDTH-1:0] io_inAct_2   ;
reg   [DATA_WIDTH-1:0] io_inAct_3   ;
reg   [DATA_WIDTH-1:0] io_inWeight_0;
reg   [DATA_WIDTH-1:0] io_inWeight_1;
reg   [DATA_WIDTH-1:0] io_inWeight_2;
reg   [DATA_WIDTH-1:0] io_inWeight_3;
wire  [4*DATA_WIDTH-1:0] io_outSum_0  ;
wire  [4*DATA_WIDTH-1:0] io_outSum_1  ;
wire  [4*DATA_WIDTH-1:0] io_outSum_2  ;
wire  [4*DATA_WIDTH-1:0] io_outSum_3  ;
reg    refresh;
reg [ 1:0]       start;
reg              act_done;
wire             Sum_valid;


    	// 时钟信号 100MHz
	always #5 clk <= ~clk; 
    initial begin
        clk<=1;
        rst_n<=1;
        start<=2'd0;
        refresh<=0;
        io_inAct_0   <=0;
        io_inAct_1   <=0;
        io_inAct_2   <=0;
        io_inAct_3   <=0;
        io_inWeight_0<=0;
        io_inWeight_1<=0;
        io_inWeight_2<=0;
        io_inWeight_3<=0;
        act_done <=0;
        #CLK_PERIOD rst_n<=0;
        #CLK_PERIOD;
        #CLK_PERIOD rst_n<=1;

        #CLK_PERIOD start<=2'd1;
         io_inWeight_0<=13;
         io_inWeight_1<=14;
         io_inWeight_2<=15;
         io_inWeight_3<=16;
        #CLK_PERIOD
         io_inWeight_0<=9;
         io_inWeight_1<=10;
         io_inWeight_2<=11;
         io_inWeight_3<=12;  
        #CLK_PERIOD
         io_inWeight_0<=5;
         io_inWeight_1<=6;
         io_inWeight_2<=7;
         io_inWeight_3<=8;
          
        #CLK_PERIOD
         io_inWeight_0<=1;
         io_inWeight_1<=2;
         io_inWeight_2<=3;
         io_inWeight_3<=4;
        #CLK_PERIOD     
         start<=2'd0; 
       #CLK_PERIOD     
         start<=2'd2;
        #CLK_PERIOD 
         io_inAct_0 <= 1;
         io_inAct_1 <= 2;
         io_inAct_2 <= 3;
         io_inAct_3 <= 4;
        #CLK_PERIOD 
         io_inAct_0 <= 5;
         io_inAct_1 <= 6;
         io_inAct_2 <= 7;
         io_inAct_3 <= 8;
        #CLK_PERIOD 
         io_inAct_0 <= 9;
         io_inAct_1 <= 10;
         io_inAct_2 <= 11;
         io_inAct_3 <= 12;
         act_done<=1;
        #CLK_PERIOD 
         io_inAct_0 <= 13;
         io_inAct_1 <= 14;
         io_inAct_2 <= 15;
         io_inAct_3 <= 16;          
         
          start<=0;
         
//        #CLK_PERIOD 
//         io_inAct_0 <= 1;
//         io_inAct_1 <= 2;
//         io_inAct_2 <= 3;
//         io_inAct_3 <= 4;
//        #CLK_PERIOD 
//         io_inAct_0 <= 5;
//         io_inAct_1 <= 6;
//         io_inAct_2 <= 7;
//         io_inAct_3 <= 8;
//        #CLK_PERIOD 
//         io_inAct_0 <= 9;
//         io_inAct_1 <= 10;
//         io_inAct_2 <= 11;
//         io_inAct_3 <= 12;
//        #CLK_PERIOD 
//         io_inAct_0 <= 13;
//         io_inAct_1 <= 14;
//         io_inAct_2 <= 15;
//         io_inAct_3 <= 16;
//        #(CLK_PERIOD*1)

         
        #(CLK_PERIOD*25)start<=0;
        act_done<=0;
    //     refresh<<=1;
        #(CLK_PERIOD)
          //       refresh<<=0;
        #CLK_PERIOD start<=2'd1;
         io_inWeight_0<=13;
         io_inWeight_1<=14;
         io_inWeight_2<=15;
         io_inWeight_3<=16;
        #CLK_PERIOD
         io_inWeight_0<=9;
         io_inWeight_1<=10;
         io_inWeight_2<=11;
         io_inWeight_3<=12;  
        #CLK_PERIOD
         io_inWeight_0<=5;
         io_inWeight_1<=6;
         io_inWeight_2<=7;
         io_inWeight_3<=8;
          
        #CLK_PERIOD
         io_inWeight_0<=1;
         io_inWeight_1<=2;
         io_inWeight_2<=3;
         io_inWeight_3<=4;
        #CLK_PERIOD     
         start<=2'd2; 
//        #CLK_PERIOD     
//         start<=2'd0;
//       #CLK_PERIOD     
//         start<=2'd2;
        #CLK_PERIOD 
         io_inAct_0 <= 1;
         io_inAct_1 <= 2;
         io_inAct_2 <= 3;
         io_inAct_3 <= 4;
        #CLK_PERIOD 
         io_inAct_0 <= 5;
         io_inAct_1 <= 6;
         io_inAct_2 <= 7;
         io_inAct_3 <= 8;
        #CLK_PERIOD 
         io_inAct_0 <= 9;
         io_inAct_1 <= 10;
         io_inAct_2 <= 11;
         io_inAct_3 <= 12;
        #CLK_PERIOD 
         io_inAct_0 <= 13;
         io_inAct_1 <= 14;
         io_inAct_2 <= 15;
         io_inAct_3 <= 16;
       #(CLK_PERIOD*1)
          act_done<=1;
          start<=0;
    end
       
Conv_Array_Control #(
    .DATA_WIDTH      (8 ),
    .PARA_WIDTH      (8),
    .CONV_KERNEL_SIZE(4),
    .CONV_KERNEL_NUM (4)
)
convtb(
  .clk        (clk),
  .rstn      (rst_n),
  .refresh    (refresh),
  .Conv_Kernel_Size( 2 ),
  .Conv_Kernel_Num( 4 ),
  .io_inAct   ({ 40'd0 ,{io_inAct_3,io_inAct_2,io_inAct_1,io_inAct_0}}   ),
  .io_inWeight ({8'd0,{io_inWeight_3,io_inWeight_2,io_inWeight_1,io_inWeight_0}}),
  .conv_finish(   ),
  .start        (start),// 0 for normal  1 for  load weight  3 for load weight down  2 for start comput  
  .act_done     (act_done),
  .io_outSum  ({io_outSum_3,io_outSum_2,io_outSum_1,io_outSum_0}),
  .Sum_valid    (Sum_valid)


);
endmodule


