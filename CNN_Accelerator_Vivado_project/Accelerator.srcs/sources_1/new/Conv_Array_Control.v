`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/24 05:26:07
// Design Name: 
// Module Name: Conv_Array_Control
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
module Conv_Array_Control#(
    parameter DATA_WIDTH=8,
    parameter RESULT_DATA_WIDTH=32,
    parameter PARA_WIDTH=32,
    parameter CONV_KERNEL_SIZE=2,
    parameter CONV_KERNEL_NUM=8
)(
  input         clk,
  input         rstn,
  input         refresh,
  input   [PARA_WIDTH-1                    :0]         Conv_Kernel_Size,
  input   [PARA_WIDTH-1                    :0]         Conv_Kernel_Num,
  input  [CONV_KERNEL_SIZE*CONV_KERNEL_SIZE*DATA_WIDTH-1  :0] io_inAct,
  input  [CONV_KERNEL_NUM*DATA_WIDTH-1  :0]                   io_inWeight,
  output [CONV_KERNEL_NUM*RESULT_DATA_WIDTH-1 :0]                  io_outSum,
  output      wire                                                conv_finish,
  input  [ 1:0]       start,
  input               act_done,
  output reg          Sum_valid  


);

// 定义状态参数

parameter IDLE = 5'b00001;
parameter LOAD_WEIGHT = 5'b000010;
parameter LOAD_ACT = 5'b00100;
parameter LOAD_ACT_DONE = 5'b01000;
parameter CALCULATE_DONE = 5'b10000;
reg [4:0] state;
reg [7:0] wait_pipeline_acttransfer_counter;//等待脉动阵列运行完毕
reg [7:0] wait_pipeline_outtransfer_counter;
reg  reg_inwtValid;
reg          reg_Sum_valid ;
reg          reg_Sum_valid1 ;
wire [CONV_KERNEL_NUM*DATA_WIDTH-1  :0]                  wire_inWeight;
reg finish;
wire [RESULT_DATA_WIDTH-1:0] Wait_Longer_side;

assign Wait_Longer_side=  Conv_Kernel_Size*Conv_Kernel_Size+CONV_KERNEL_NUM;
assign wire_inWeight=(state==LOAD_WEIGHT)?io_inWeight:0;
//assign finish =   state==CALCULATE_DONE;
always @(posedge clk ) begin
  if (!rstn||refresh) begin
       finish<=0;
  end else begin
     if(state==CALCULATE_DONE)
        finish<=1;
      else 
        finish<=0;
end
end

assign conv_finish=finish;
//always @(posedge clk ) begin
//  if (!rstn||refresh) begin
//       conv_finish<=0;
//  end else begin
//     conv_finish<=finish;
//end
//end


// 状态寄存器初始化
always @(posedge clk  ) begin
  if (!rstn||refresh) begin
    state <= IDLE; // 复位时状态为IDLE
    wait_pipeline_acttransfer_counter<=0;
  end else begin
    case (state)
      IDLE: begin
        if (start==2'd1) begin
          state <= LOAD_WEIGHT; // 如果收到启动信号1，则进入LOAD_WEIGHT状态
          end
        else if(start==2'd2) begin
          state <= LOAD_ACT; // 如果收到启动信号2，则进入计算状态
          end
        else begin
          state <= IDLE; // 如果未收到启动信号0，则保持 IDEL状态
          end 
      end
      LOAD_WEIGHT: begin
        if (start==2'd2) begin
           state <= LOAD_ACT;
        end
        else if(start==2'd1)begin
            state <=LOAD_WEIGHT;
       end  else begin
            state <= IDLE; // 如果重量准备好，则进入IDEL状态
        end
      end
      LOAD_ACT: begin
        if (act_done==1'd1) begin
          state <= LOAD_ACT_DONE; // 如果激励数据导入完成了，则进入LOAD_ACT_DONE状态
        end
        else begin
            state <= LOAD_ACT;
        end
      end
      LOAD_ACT_DONE: begin
        wait_pipeline_acttransfer_counter<=wait_pipeline_acttransfer_counter+1;
       if(wait_pipeline_acttransfer_counter==Wait_Longer_side-1)begin
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

//控制权重有效的传递
always @(posedge clk ) begin
  if (!rstn||refresh) begin
    reg_inwtValid<=1'd0;
  end else begin
     if(start==2'd1)
       reg_inwtValid<=1'd1;
     else
       reg_inwtValid<=1'd0;
    end
  end

//控制激励的传递打拍子
genvar i;
generate

for ( i=0 ;i<CONV_KERNEL_SIZE*CONV_KERNEL_SIZE ;i=i+1 ) begin:Conv_Data
    reg [(i+1)*DATA_WIDTH-1:0] reg_Act;
always @(posedge clk  ) begin:Conv_pipeDelay
  if (!rstn||refresh) begin
   reg_Act    <=   0;
  end else begin
      reg_Act    <=   reg_Act>>>DATA_WIDTH;
     reg_Act[(i+1)*DATA_WIDTH-1:(i)*DATA_WIDTH]<=io_inAct[(i+1)*DATA_WIDTH-1:(i)*DATA_WIDTH];
    
  end
end
end
endgenerate



//生成输入的激励
wire [CONV_KERNEL_SIZE*CONV_KERNEL_SIZE*DATA_WIDTH-1:0] wire_inAct   ;

genvar j;
generate
    for (j = 0; j < CONV_KERNEL_SIZE*CONV_KERNEL_SIZE; j=j+1)
		begin: Conv_windowdata
          assign wire_inAct[(j+1)*DATA_WIDTH-1:(j*DATA_WIDTH)] = Conv_Data[j].reg_Act[DATA_WIDTH-1:0];  
        end
       
endgenerate




wire [CONV_KERNEL_NUM*RESULT_DATA_WIDTH-1 :0]    wire_outSum;
//控制输出结果的传递打拍子
genvar k;
generate

for ( k=0 ;k<CONV_KERNEL_NUM-1 ;k=k+1 ) begin:Conv_Answer
    reg [(CONV_KERNEL_NUM-k-1)*RESULT_DATA_WIDTH-1:0] reg_outsum;
always @(posedge clk  ) begin:Conv_Answer_pipeDelay
  if (!rstn||refresh) begin
      reg_outsum    <=   0;
  end else begin
      reg_outsum    <=   reg_outsum>>>(RESULT_DATA_WIDTH);
      reg_outsum[(CONV_KERNEL_NUM-k-1)*RESULT_DATA_WIDTH-1:(CONV_KERNEL_NUM-k-2)*RESULT_DATA_WIDTH]<=wire_outSum[(k+1)*RESULT_DATA_WIDTH-1:(k)*RESULT_DATA_WIDTH];
    
  end
end
end
endgenerate



//生成结果的激励

genvar n;
generate
    for (n = 0; n < CONV_KERNEL_NUM; n=n+1)
		begin: Conv_Answer_windowdata
        if(n==CONV_KERNEL_NUM-1)
          assign io_outSum[(n+1)*RESULT_DATA_WIDTH-1:(n*RESULT_DATA_WIDTH)] = n<Conv_Kernel_Num?wire_outSum[CONV_KERNEL_NUM*RESULT_DATA_WIDTH-1:(CONV_KERNEL_NUM-1)*RESULT_DATA_WIDTH]:0;  
        else
          assign io_outSum[(n+1)*RESULT_DATA_WIDTH-1:(n*RESULT_DATA_WIDTH)] =  n<Conv_Kernel_Num?Conv_Answer[n].reg_outsum[RESULT_DATA_WIDTH-1:0]:0;  
        end
       
endgenerate



//控制输出结果的有效
always @(posedge clk ) begin
  if (!rstn||refresh) begin
    reg_Sum_valid<=1'd0;
    wait_pipeline_outtransfer_counter<=0;
  end else begin
    if(state==LOAD_ACT||state==LOAD_ACT_DONE)begin
      wait_pipeline_outtransfer_counter<=(wait_pipeline_outtransfer_counter<Wait_Longer_side-1)?wait_pipeline_outtransfer_counter+1:wait_pipeline_outtransfer_counter;
      if(wait_pipeline_outtransfer_counter==Wait_Longer_side-1)    
       reg_Sum_valid<=1'd1;
     else
       reg_Sum_valid<=1'd0;
    end
    else begin
       reg_Sum_valid<=1'd0;
       wait_pipeline_outtransfer_counter<=0;
    end
  end
end

// 为了对应输出结果需要打两个拍子，一个是输出结果存mem，一个是打牌一起输出valid 打拍
always @(posedge clk ) begin
  if (!rstn||refresh) begin
    Sum_valid<=0;
    reg_Sum_valid1<=0;
  end else begin
     Sum_valid<=reg_Sum_valid;
//     reg_Sum_valid1<=reg_Sum_valid;
  end
end




Conv_SystolicArray#(
    .DATA_WIDTH      (DATA_WIDTH      ),
    .PARA_WIDTH      (PARA_WIDTH    ),
    .RESULT_DATA_WIDTH(RESULT_DATA_WIDTH),
    .CONV_KERNEL_SIZE(CONV_KERNEL_SIZE),
    .CONV_KERNEL_NUM (CONV_KERNEL_NUM )
)Conv_Array_0(
  .clk                (clk),
  .rstn               (rstn),
  .refresh            (refresh),
  .Conv_Kernel_Size(Conv_Kernel_Size),
  .Conv_Kernel_Num(Conv_Kernel_Num),
  .io_inAct           (wire_inAct  ),
  .io_inWeight        (wire_inWeight ),
  .io_outSum          (wire_outSum ),
  .io_inwtValid       (reg_inwtValid)
);

endmodule
