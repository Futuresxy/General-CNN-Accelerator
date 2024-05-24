`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/24 16:45:20
// Design Name: 
// Module Name: Pooling_Array_Control
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


module Pooling_Array_Control#(
    parameter DATA_WIDTH=8,
    parameter PARA_WIDTH=8,
    parameter POOL_KERNEL_SIZE=4 
)(
  input                                     clk,
  input                                     rstn,
  input                                     refresh,
  input   [PARA_WIDTH-1           :0   ]    Pool_Kernel_Size,    
  input  [POOL_KERNEL_SIZE*POOL_KERNEL_SIZE*DATA_WIDTH-1:0] io_inAct,
  input                                    start,
  input                                    io_Max_MeanValid,
  output [DATA_WIDTH-1:0]                  io_outSum,
  output reg                                  pool_finish,
  output reg                               out_valid
);
// 定义状态参数

parameter IDLE = 4'b0001;
parameter LOAD_ACT = 4'b0010;
parameter LOAD_ACT_DONE = 4'b0100;
parameter CALCULATE_DONE = 4'b1000;

reg valid;
wire finish;
reg [3:0] state;
reg [7:0] wait_pipeline_acttransfer_counter;//等待脉动阵列运行完毕
reg [7:0] wait_pipeline_outtransfer_counter;

assign finish=(state==CALCULATE_DONE);

always @(posedge clk) begin
  if (!rstn||refresh) begin
    pool_finish<=0;
  end else begin
    pool_finish<=finish;
    end 
end
always @(posedge clk ) begin
  if (!rstn||refresh) begin
    out_valid<=0;
  end else begin
    out_valid<=valid;
    end 
end

// 状态寄存器初始化
always @(posedge clk ) begin
  if (!rstn||refresh) begin
    state <= IDLE; // 复位时状态为IDLE
    wait_pipeline_acttransfer_counter<=0;
  end else begin
    case (state)
      IDLE: begin
        if (start==1'd1) begin
          state <= LOAD_ACT; // 如果收到启动信号1，则进入LOAD_WEIGHT状态
          end
        else begin
          state <= IDLE; // 如果未收到启动信号0，则保持 IDLE状态
          end 
      end
      LOAD_ACT: begin
        if (start==1'd0) begin
          state <= LOAD_ACT_DONE; // 如果激励数据导入完成了，则进入LOAD_ACT_DONE状态
        end
        else begin
            state <= LOAD_ACT;
        end
      end
      LOAD_ACT_DONE: begin
        wait_pipeline_acttransfer_counter<=wait_pipeline_acttransfer_counter+1;
       if(wait_pipeline_acttransfer_counter==Pool_Kernel_Size*Pool_Kernel_Size-2)begin
         state <= CALCULATE_DONE; // 返回到IDLE状态
         wait_pipeline_acttransfer_counter<=0;
        end
       else begin
       state <= LOAD_ACT_DONE;
       end
      end
      CALCULATE_DONE: begin
        state <= IDLE;
      end
      default: begin
        state <= IDLE;
        end
         
    endcase
  end
end





//控制激励的传递打拍子
genvar i;
generate

for ( i=0 ;i<POOL_KERNEL_SIZE*POOL_KERNEL_SIZE ;i=i+1 ) begin:Pool_Data
    reg [(i+1)*DATA_WIDTH-1:0] reg_Act;
always @(posedge clk ) begin:Pool_pipeDelay
  if (!rstn||refresh) begin
   reg_Act    <=   0;
  end else begin
   reg_Act    <=   reg_Act>>>DATA_WIDTH;
     if(i==0) 
     reg_Act[(i+1)*DATA_WIDTH-1:(i)*DATA_WIDTH]<=io_inAct[(i+1)*DATA_WIDTH-1:(i)*DATA_WIDTH];
    else 
     reg_Act[(i)*DATA_WIDTH-1:(i-1)*DATA_WIDTH]<=io_inAct[(i+1)*DATA_WIDTH-1:(i)*DATA_WIDTH];
    
  end
end
end
endgenerate


wire [POOL_KERNEL_SIZE*POOL_KERNEL_SIZE*DATA_WIDTH-1:0] wire_inAct   ;

genvar j;
generate
    for (j = 0; j < POOL_KERNEL_SIZE*POOL_KERNEL_SIZE; j=j+1)
		begin: Pool_windowdata
          assign wire_inAct[(j+1)*DATA_WIDTH-1:(j*DATA_WIDTH)] = Pool_Data[j].reg_Act[DATA_WIDTH-1:0];  
        end
       
endgenerate



always @(posedge clk ) begin
  if (!rstn||refresh) begin
   valid    <=   0;
   wait_pipeline_outtransfer_counter<=0;
  end else begin
    if(state==LOAD_ACT||state==LOAD_ACT_DONE)begin
      wait_pipeline_outtransfer_counter<=(wait_pipeline_outtransfer_counter<Pool_Kernel_Size*Pool_Kernel_Size)?wait_pipeline_outtransfer_counter+1:wait_pipeline_outtransfer_counter;
      if(wait_pipeline_outtransfer_counter==Pool_Kernel_Size*Pool_Kernel_Size)    
       valid<=1'd1;
     else
       valid<=1'd0;
    end
    else begin
       valid<=1'd0;
       wait_pipeline_outtransfer_counter<=0;
    end
  end
end
Pooling_SystolicArray#(
    .DATA_WIDTH(DATA_WIDTH),
    .PARA_WIDTH (PARA_WIDTH),
    .POOL_KERNEL_SIZE(POOL_KERNEL_SIZE) 
) Pool_0(
  .clk             (clk),
  .rstn            (rstn),
  .refresh       (refresh),
  .Pool_Kernel_Size(Pool_Kernel_Size),
  .io_inAct        (wire_inAct),
  .io_outSum       (io_outSum),
  .io_Max_MeanValid(io_Max_MeanValid)
);
endmodule
