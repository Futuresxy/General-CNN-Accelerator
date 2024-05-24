`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/10 17:51:23
// Design Name: 
// Module Name: CNN_Accelerator
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

module CNN_Accelerator #(
    parameter DATA_WIDTH         =8,//数据位宽
    parameter PARA_WIDTH         =8,// 参数位宽
    parameter CONV_KERNEL_SIZE   =2,//卷积核大小长
    parameter CONV_KERNEL_NUM    =4,//卷积核个数
    parameter POOL_KERNEL_SIZE   =2,//池化核大小长
    parameter POOL_KERNEL_NUM    =1,//池化核个数
    parameter FULLCON_INPUT_SIZE =100,//全连接层输入大小
    parameter FULLCON_OUTPUT_SIZE=8//全连接层输出大小
)
(
    input wire clk,
    input wire rstn,

    input wire cnn_start,
    input wire [4:0] select_mode,//00000 :idel  00001:conv 00010:relu 00100:pool 01000fullcon 10000:conv+relu
    input  [ PARA_WIDTH-1  :    0  ]      Conv_Kernel_Size   ,
    input  [ PARA_WIDTH-1  :    0  ]      Conv_Kernel_Num    ,
    input  [ PARA_WIDTH-1  :    0  ]      Pool_Kernel_Size   ,
    input  [ PARA_WIDTH-1  :    0  ]      Pool_Kernel_Num    ,
    input  [ PARA_WIDTH-1  :    0  ]      FULLCON_Input_Size ,
    input  [ PARA_WIDTH-1  :    0  ]      FULLCON_Output_Size,
    input wire image_tvalid,
    input wire image_tlast,
    output wire image_tready,
    input wire signed [CONV_KERNEL_NUM*CONV_KERNEL_NUM*DATA_WIDTH-1:0] image_tdata,
    input wire [(CONV_KERNEL_NUM*CONV_KERNEL_NUM*DATA_WIDTH/8)-1 : 0] image_tkeep,
    input wire [(CONV_KERNEL_NUM*CONV_KERNEL_NUM*DATA_WIDTH/8)-1 : 0] image_tstrb,
    
    input wire weight_tvalid, 
    input wire weight_tlast,                      
    output wire weight_tready,
    input wire signed [CONV_KERNEL_NUM*DATA_WIDTH-1:0] weight_tdata,
    input wire [(CONV_KERNEL_NUM*DATA_WIDTH/8)-1 : 0] weight_tkeep,
    input wire [(CONV_KERNEL_NUM*DATA_WIDTH/8)-1 : 0] weight_tstrb,
    
    input wire weightfc_tvalid,
    input wire weightfc_tlast,                      
    output wire weightfc_tready,
    input wire signed [FULLCON_OUTPUT_SIZE*DATA_WIDTH-1:0] weightfc_tdata,
    input wire [(DATA_WIDTH/8)-1 : 0] weightfc_tkeep,
    input wire [(DATA_WIDTH/8)-1 : 0] weightfc_tstrb,
    
    input wire result_tready,
    output wire result_tvalid,
    output wire signed [FULLCON_OUTPUT_SIZE*2*DATA_WIDTH-1:0] result_tdata,
    output wire [(FULLCON_OUTPUT_SIZE*2*DATA_WIDTH/8)-1 : 0] result_tkeep,
    output wire [(FULLCON_OUTPUT_SIZE*2*DATA_WIDTH/8)-1 : 0] result_tstrb,
   
    output wire cnn_done,
    output wire [3:0] cnn_cnt
);

reg  [4:0] state;
parameter IDLE =5'b00000;
parameter CONV =5'b00001;
parameter RELU =5'b00010;
parameter POOL_Max =5'b00100;
parameter POOL_Mean =5'b00101;
parameter FULLCON =5'b01000;
parameter CONV_RELU =5'b10000;

//State machine
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      state<=IDLE;
    end
    else begin
         case (select_mode)
            IDLE: 
            state<=IDLE;
            CONV: 
            state<=CONV;
            RELU: 
            state<=RELU;
            POOL_Mean: 
            state<=POOL_Mean;
            POOL_Max: 
            state<=POOL_Max;            
            FULLCON: 
            state<=FULLCON;
            CONV_RELU: 
            state<=CONV_RELU;
            default: 
            state<=IDLE; 
         endcase
    end
end

//卷积激励输入
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        CONV_Act<=0;
    end
    else begin
        if(image_tready&&image_tvalid)
        begin
          CONV_Act<=image_tdata;
        end
        else begin
            CONV_Act<=0;
        end

    end

end

//卷积权重输入
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        CONV_Weight<=0;
    end
    else begin
        if(weight_tready&&weight_tvalid)
            CONV_Weight<=weight_tdata;
        else begin
            CONV_Weight<=0;
        end
    end


end


//卷积输入结束标志
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        CONV_Load_Act<=0;
    end
    else begin
        if(CONV_State==WAIT_DONE)
            CONV_Load_Act<=1;
        else begin
             CONV_Load_Act<=0;
        end

    end


end

reg  [4:0] CONV_State;
parameter CONV_NONE =5'b11111;
parameter CONV_IDLE =5'b00000;
parameter LOAD_WEIGHT =5'b00001;
parameter LOAD_ACT_IDLE =5'b00010;
parameter LOAD_ACT =5'b00100;
parameter WAIT_DONE =5'b01000;
parameter CONV_DONE =5'b10000;
//Conv  State machine
always @(posedge clk or negedge rstn) begin
    if(!rstn||CONV_Refresh)begin
      CONV_State<=CONV_NONE;
      CONV_Start_Control<=0;
      CONV_Image_Ready<=0;
      CONV_Weight_Ready<=0;
    end
    else begin
        if(~(state==CONV||state==CONV_RELU))begin
          CONV_State<=CONV_NONE;
        end
        else begin
            if(cnn_start==1&&CONV_State==CONV_NONE)
            begin
              CONV_State<=CONV_IDLE;
            end
         else  begin
         case (CONV_State)
            CONV_IDLE:begin 
            CONV_Start_Control<=0; 
            if(weight_tvalid==1)//fifo  准备好了
               CONV_State<=LOAD_WEIGHT;
            else if(image_tvalid==1)
              CONV_State<=LOAD_ACT_IDLE;
            end
            LOAD_WEIGHT: begin
              CONV_Weight_Ready<=1;          
              if(weight_tlast==1)
              begin
                 CONV_State<=LOAD_ACT_IDLE;  
                 CONV_Start_Control<=0;             
              end
              else begin
                CONV_State<=LOAD_WEIGHT;
                CONV_Start_Control<=1;
              end
            end
            LOAD_ACT_IDLE: begin
               if(image_tvalid==1)begin
                   CONV_State<=LOAD_ACT;
               end
               else begin
                   CONV_State<=LOAD_ACT_IDLE;
                   CONV_Start_Control<=0;
               end
            end
            LOAD_ACT: begin
                          
              if(image_tvalid==0)
              begin
                 CONV_State<=WAIT_DONE; 

                 CONV_Image_Ready<=0;               
              end
              else begin
                 CONV_State<=LOAD_ACT;
                 CONV_Start_Control<=2;
                 CONV_Image_Ready<=1;
              end
              end
            WAIT_DONE: begin
                   CONV_Start_Control<=0;
                    if(CONV_Finish==1)
                        CONV_State<=CONV_DONE;
                    else begin
                        CONV_State<=WAIT_DONE;
                       end
            end
            CONV_DONE: 
              CONV_State<=CONV_NONE;
            CONV_NONE:
               CONV_State<=CONV_NONE;
            default: 
            CONV_State<=CONV_NONE; 
         endcase
         end
                 end
    end
end
//refresh
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      CONV_Refresh<=0;
    end
    else begin
       if(state==IDLE)
           CONV_Refresh<=1;
       else
          CONV_Refresh<=0;
     end
 end   

reg   [CONV_KERNEL_SIZE*CONV_KERNEL_SIZE*DATA_WIDTH-1:0]  CONV_Act;
reg   [CONV_KERNEL_NUM*DATA_WIDTH-1:0]  CONV_Weight;
reg   [1:0]                             CONV_Start_Control;
reg                                     CONV_Load_Act;
reg                                     CONV_Image_Ready;
reg                                     CONV_Weight_Ready;
reg                                     CONV_Refresh;
wire [CONV_KERNEL_NUM*2*DATA_WIDTH-1:0] CONV_Outsum;
wire                                    CONV_Outsum_Valid;
wire                                    CONV_Finish;

assign  image_tready=CONV_Image_Ready||POOL_Image_Ready;

assign  weight_tready=CONV_Weight_Ready||FULLCON_Act_Ready;
  





Conv_Array_Control #(
    .DATA_WIDTH      (DATA_WIDTH ),
    .PARA_WIDTH      (PARA_WIDTH),
    .CONV_KERNEL_SIZE(CONV_KERNEL_SIZE),
    .CONV_KERNEL_NUM (CONV_KERNEL_NUM )
)
CONV_00(
  .clk          (clk           ),
  .rstn         (rstn          ),
  .refresh      (CONV_Refresh  ),
  .Conv_Kernel_Size(Conv_Kernel_Size),
  .Conv_Kernel_Num (Conv_Kernel_Num ),
  .io_inAct     (CONV_Act      ),
  .io_inWeight  (CONV_Weight   ),
  .conv_finish  (CONV_Finish   ),
  .start        (CONV_Start_Control   ),// 0 for normal  1 for  load weight  3 for load weight down  2 for start comput  
  .act_done     (CONV_Load_Act ),
  .io_outSum    (CONV_Outsum        ),
  .Sum_valid    (CONV_Outsum_Valid  )


);

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        RELU_Act<=0;
        RELU_Valid<=0;
    end
    else begin
        if(state==CONV_RELU)begin
            RELU_Act<=CONV_Outsum;
            RELU_Valid<=CONV_Outsum_Valid;
            end
        else if(state==RELU)begin
            RELU_Act<=weight_tdata;
            RELU_Valid<=weight_tready&weight_tvalid; 
        end
        else begin
            RELU_Act<=0;
            RELU_Valid<=0; 
            end
             
        end

    end

//refresh
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      RELU_Refresh<=0;
    end
    else begin
       if(state==IDLE)
           RELU_Refresh<=1;
       else
          RELU_Refresh<=0;
     end
 end  

reg   [CONV_KERNEL_NUM*2*DATA_WIDTH-1:0]  RELU_Act;
reg                                     RELU_Valid;
reg                                     RELU_Refresh;
wire [CONV_KERNEL_NUM*2*DATA_WIDTH-1:0] RELU_Outsum;
wire                                    RELU_Outsum_Valid;


Relu_Array_Control#(   
    .Data_width( 2*DATA_WIDTH),
    .Relu_Num (  CONV_KERNEL_NUM ) 
)RELU_00(
  .clk       (  clk     ) ,
  .rstn      (  rstn     ) ,
  .refresh   (  RELU_Refresh     ) ,
  .io_inAct  (  RELU_Act     )  ,
  .io_invalid(  RELU_Valid     )  ,
  .io_outSum (  RELU_Outsum     )  ,
  .out_valid (  RELU_Outsum_Valid     )  
);


reg              POOL_Start_Control;
reg  [3:0] POOL_State;
parameter POOL_NONE      =4'b1111;
parameter POOL_IDLE      =4'b0000;
parameter POOL_LOAD_ACT  =4'b0001;
parameter POOL_WAIT_DONE =4'b0010;
parameter POOL_DONE      =4'b0100;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        POOL_State<=POOL_NONE;
        POOL_Start_Control<=0;
        POOL_Image_Ready<=0;
    end
    else begin
        if(~(state==POOL_Max||state==POOL_Mean))begin
          POOL_State<=POOL_NONE;
          POOL_Image_Ready<=0;
        end
        else begin
            if (cnn_start==1&&POOL_State==POOL_NONE) begin
                POOL_State<=POOL_IDLE;
            end
            else begin
        case (POOL_State)
            POOL_IDLE: 
               if (image_tvalid==1) begin
                    POOL_Start_Control<=1;
                    POOL_State<=POOL_LOAD_ACT;
                end 
            POOL_LOAD_ACT:
               if(image_tlast==1)
              begin
                 POOL_State<=POOL_WAIT_DONE; 
                 POOL_Start_Control<=0;
                 POOL_Image_Ready<=0;               
              end
              else begin
                 POOL_Image_Ready<=1;
                 POOL_State<=POOL_LOAD_ACT;
                 POOL_Start_Control<=1;
              end
            POOL_WAIT_DONE:
                 if(POOL_Finish==1)
                    POOL_State<=  POOL_DONE;
                else 
                    POOL_State<=  POOL_WAIT_DONE;
            POOL_DONE:
                POOL_State<=POOL_NONE;
            POOL_NONE:
               POOL_State<=POOL_NONE;
            default: POOL_State<=POOL_NONE;
        endcase
        end

end
    end
end
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        POOL_Max_MeanValid<=1'b1;
    end
    else begin
            if(state==POOL_Mean)begin
               POOL_Max_MeanValid<=1'b0;
            end
            else begin
                POOL_Max_MeanValid<=1'b1;
            end
        end

    end


always @(posedge clk) begin
    if (!rstn) begin
        POOL_Act<=0;
    end
    else begin
        if(POOL_Start_Control==1)
        begin
             POOL_Act<=image_tdata[POOL_KERNEL_SIZE*POOL_KERNEL_SIZE*DATA_WIDTH-1:0];
        end
        else begin
            POOL_Act<=0;
        end

    end

end
//refresh
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      POOL_Refresh<=0;
    end
    else begin
       if(state==IDLE)
           POOL_Refresh<=1;
       else
          POOL_Refresh<=0;
     end
 end  
 


reg   [POOL_KERNEL_SIZE*POOL_KERNEL_SIZE*DATA_WIDTH-1:0]  POOL_Act;
reg                                      POOL_Start_Control;
reg                                      POOL_Max_MeanValid;
reg                                     POOL_Image_Ready;
reg                                     POOL_Refresh;
wire [DATA_WIDTH-1:0]                   POOL_Outsum;
wire                                    POOL_Outsum_Valid;
wire                                    POOL_Finish;        
Pooling_Array_Control #(
    .DATA_WIDTH(DATA_WIDTH),
    .PARA_WIDTH      (PARA_WIDTH),
    .POOL_KERNEL_SIZE(POOL_KERNEL_SIZE)
)POOL(
  .clk             (clk),
  .rstn            (rstn),
  .refresh         (POOL_Refresh        ),
  .io_inAct        (POOL_Act),
  .start           (POOL_Start_Control      ),
  .Pool_Kernel_Size(Pool_Kernel_Size),
  .io_Max_MeanValid(POOL_Max_MeanValid      ),
  .io_outSum       (POOL_Outsum     ),
  .pool_finish     (POOL_Finish     ),
  .out_valid       (POOL_Outsum_Valid     )
);


reg                FULLCON_Start_Control;
reg  [3:0] FULLCON_State;
parameter FULLCON_NONE      =4'b1111;
parameter FULLCON_IDLE      =4'b0000;
parameter FULLCON_LOAD_ACT  =4'b0001;
parameter FULLCON_WAIT_DONE =4'b0010;
parameter FULLCON_DONE      =4'b0100;



always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        FULLCON_State<=FULLCON_NONE;
        FULLCON_Act_Ready<=0;
        FULLCON_Weight_Ready<=0; 
    end
    else begin
        if(state!=FULLCON)begin
          FULLCON_State<=FULLCON_NONE;
        end
        else begin
            if (cnn_start==1&&FULLCON_State==FULLCON_NONE) begin
              FULLCON_State<=FULLCON_IDLE;  
            end
            else begin
        case (FULLCON_State)
            FULLCON_IDLE: 
               if (weight_tvalid==1&&weightfc_tvalid==1) begin
                    FULLCON_State<=FULLCON_LOAD_ACT;
                end 
            FULLCON_LOAD_ACT:
               if(weight_tlast==1||weightfc_tlast==1)
              begin
  
                 FULLCON_Act_Ready<=0;
                 FULLCON_Weight_Ready<=0; 
                 FULLCON_State<=FULLCON_WAIT_DONE;           
              end
              else begin
                FULLCON_Act_Ready<=1;
                FULLCON_Weight_Ready<=1;
                 FULLCON_State<=FULLCON_LOAD_ACT;
              end
            FULLCON_WAIT_DONE:
                 if(FULLCON_Finish==1)
                    FULLCON_State<=  FULLCON_DONE;
                else 
                    FULLCON_State<=  FULLCON_WAIT_DONE;
            FULLCON_DONE:
                FULLCON_State<=FULLCON_NONE;
            FULLCON_NONE:
                FULLCON_State<=FULLCON_NONE;     
            default: FULLCON_State<=FULLCON_NONE;
        endcase
   end
end
    end
end

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
          FULLCON_Act   <=0; 
          FULLCON_Weight<=0; 
    end
    else begin
        if(FULLCON_State==FULLCON_LOAD_ACT)
        begin
              FULLCON_Act   <=weight_tdata;
              FULLCON_Weight<=weightfc_tdata;
        end
        else begin
          FULLCON_Act   <=0; 
          FULLCON_Weight<=0; 
        end

    end

end
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
          FULLCON_Valid   <=0; 
    end
    else begin
        if(FULLCON_State==FULLCON_LOAD_ACT)
        begin
            FULLCON_Valid   <=1; 
        end
        else begin
          FULLCON_Valid   <=0; 
        end

    end

end
assign     weightfc_tready=  FULLCON_Valid; 
//refresh
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      FULLCON_Refresh<=0;
    end
    else begin
       if(state==IDLE)
           FULLCON_Refresh<=1;
       else
          FULLCON_Refresh<=0;
     end
 end  

reg   [DATA_WIDTH-1:0]  FULLCON_Act;
reg   [FULLCON_OUTPUT_SIZE*DATA_WIDTH-1:0]  FULLCON_Weight;
reg                     FULLCON_Act_Ready;
reg                     FULLCON_Weight_Ready;
reg                     FULLCON_Valid;
reg                     FULLCON_Refresh;

wire [FULLCON_OUTPUT_SIZE*2*DATA_WIDTH-1:0]                   FULLCON_Outsum;
wire                                    FULLCON_Outsum_Valid;
wire                                    FULLCON_Finish;

assign FULLCON_Outsum_Valid= (FULLCON_State==  FULLCON_DONE);
FullCon_PE_Control #(
    .DATA_WIDTH      (DATA_WIDTH),   
    .PARA_WIDTH      (PARA_WIDTH),          
    .OutData_width    (2*DATA_WIDTH),       
    .FULLCON_INPUT_SIZE(FULLCON_INPUT_SIZE), //输入数据的横向长          
    .FULLCON_OUTPUT_NUM(   1    ),           //输入数据的纵向长   
    .FULLCON_OUTPUT_SIZE (FULLCON_OUTPUT_SIZE) //输出层的大小
)   FULLCON_00(
  .clk        ( clk         ),
  .rstn       ( rstn        ),
  .FULLCON_Input_Size  (FULLCON_Input_Size ) ,
  .FULLCON_Output_Size (FULLCON_Output_Size),
  .io_inAct   ( FULLCON_Act            ),
  .io_inWeight( FULLCON_Weight            ),
  .io_outSum  ( FULLCON_Outsum            ),
  .io_clear   ( FULLCON_Refresh            ),
  .io_inValid ( FULLCON_Valid            ),
  .out_finish ( FULLCON_Finish            )
 // .io_outvalid( FULLCON_Outsum_Valid            )
  );


reg RESULT_Valid;
reg [FULLCON_OUTPUT_SIZE*2*DATA_WIDTH-1:0] RESULT_Data;
reg     CNN_Finish;
reg [3:0] CNN_Cnt;

always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      RESULT_Valid<=0;
      RESULT_Data<=0;
      CNN_Finish<=0;
    end
    else begin
        case (select_mode)
            IDLE: begin
                RESULT_Valid<=0;
                RESULT_Data<=0;    
                CNN_Finish<=0;   
                end         
            CONV: begin
               RESULT_Valid<=CONV_Outsum_Valid;
               RESULT_Data<=CONV_Outsum;
               CNN_Finish<=CONV_Finish;
               end
            RELU: begin
                 RESULT_Valid<=RELU_Valid;
                 RESULT_Data<=RELU_Outsum;
                 CNN_Finish<=CONV_Finish;
                 end
            POOL_Mean: begin
               RESULT_Valid<=POOL_Outsum_Valid;
               RESULT_Data<=POOL_Outsum;
               CNN_Finish<=POOL_Finish;
               end
            POOL_Max: begin
                RESULT_Valid<=POOL_Outsum_Valid;     
                RESULT_Data<=POOL_Outsum;
                CNN_Finish<=POOL_Finish;
                end
            FULLCON: begin
               RESULT_Valid<=FULLCON_Outsum_Valid;
               RESULT_Data<=FULLCON_Outsum;
               CNN_Finish<=FULLCON_Finish;
               end
            CONV_RELU: begin
               RESULT_Valid<=RELU_Valid;
               RESULT_Data<=RELU_Outsum;
               CNN_Finish<=CONV_Finish;
               end
            default: begin
                RESULT_Valid<=0;
                RESULT_Data<=0;
                CNN_Finish<=0;
                end
    endcase
    end
end
always @(posedge clk or negedge rstn) begin
    if(!rstn)begin
      CNN_Cnt<=0;
    end
    else begin
       if(state==CONV||state==CONV_RELU)begin
         CNN_Cnt<=4'b0001;
       end
       else if (state==POOL_Max||state==POOL_Mean) begin
        CNN_Cnt<=4'b0010;
       end
    else if (state==FULLCON) begin
        CNN_Cnt<=4'b0100;
    end
    else if(state==RELU)begin
        CNN_Cnt<=4'b1000;
    end
    else begin
        CNN_Cnt<=0;
    end


    end


end
assign result_tdata=RESULT_Data;
assign result_tvalid=RESULT_Valid;
assign cnn_done=CNN_Finish;
assign cnn_cnt=CNN_Cnt;
endmodule
