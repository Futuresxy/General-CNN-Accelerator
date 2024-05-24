`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/28 12:19:41
// Design Name: 
// Module Name: FullCon_PE_Control
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


module FullCon_PE_Control#(
    parameter DATA_WIDTH=16,
    parameter PARA_WIDTH=32,
    parameter OutData_width=32,
    parameter FULLCON_INPUT_SIZE=128,//输入数据的横向长
	parameter FULLCON_OUTPUT_NUM=1,//输入数据的纵向长
	parameter FULLCON_OUTPUT_SIZE=10 //输出层的大小
)  (
  input                                                 clk,
  input                                                 rstn,
  input          [PARA_WIDTH-1   :       0 ]            FULLCON_Input_Size,
  input          [PARA_WIDTH-1   :    0 ]               FULLCON_Output_Size,
  input    [DATA_WIDTH-1                 :0]            io_inAct,
  input    [FULLCON_OUTPUT_SIZE*DATA_WIDTH-1   :0]      io_inWeight,
  output reg   [FULLCON_OUTPUT_SIZE*OutData_width-1:0]   io_outSum,
  input                                                 io_inValid,
  input                                                 io_clear,
  output                                                out_finish
//  output                                                io_outvalid
);

genvar i,j,k;


wire  signed [FULLCON_OUTPUT_SIZE*OutData_width-1:0]outSum;
always @(posedge clk ) begin
       
                if(!rstn||io_clear)
                begin
                    io_outSum<=0;
                end
                else begin
                       io_outSum<=outSum; 
                end
            end



reg [DATA_WIDTH-1   :0] reg_in_Act;
always @(posedge clk ) begin:Weight_pipeline
       
                if(!rstn||io_clear)
                begin
                    reg_in_Act<=0;
                end
                else begin
                       reg_in_Act<=io_inAct; 
                end
            end


reg [FULLCON_OUTPUT_SIZE-1:0]  reg_valid;
 generate
    for (i=0;i<FULLCON_OUTPUT_SIZE;i=i+1)
    begin :Full_connection_Array
    wire [DATA_WIDTH-1   :0] wire_Act;//往下传递输入激励
    wire                     valid; //是否有效
    wire [DATA_WIDTH-1   :0] reg_Sum;//输出层的数据
    reg  [(i+1)*DATA_WIDTH-1:0]Weight;
       
    always @(posedge clk ) begin:Weight_pipeline
       
                if(!rstn||io_clear)
                begin
                    Weight<=0;
                    reg_valid[i]<=0;
                end
                else begin
                       reg_valid[i]<=valid;
                       Weight<=Weight<<<DATA_WIDTH;
                       Weight[DATA_WIDTH-1:0]<=io_inWeight[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]; 
                end
            end




       if(i==0) begin :Array_0
            FullCon_PE  #(
                 .DATA_WIDTH   (DATA_WIDTH),
                 .OutData_width(OutData_width)
             )FullCon_Array(
               .clk          ( clk ),
               .rstn         ( rstn ),
               .io_inAct     ( reg_in_Act ),
               .io_inWeight  ( Weight[(i+1)*DATA_WIDTH-1:(i)*DATA_WIDTH] ),
               .io_outAct    ( wire_Act ),
               .io_outSum    ( outSum[(i+1)*OutData_width-1:i*OutData_width] ),
               .io_inValid   (io_inValid),
               .io_clear      (io_clear),
               .io_outValid  ( valid     )
             );
       end else begin :Array_x
            FullCon_PE #(
                 .DATA_WIDTH   (DATA_WIDTH),
                 .OutData_width(OutData_width)
             ) FullCon_Array(
               .clk          ( clk ),
               .rstn         ( rstn ),
               .io_inAct     ( Full_connection_Array[i-1].wire_Act ),
               .io_inWeight  ( Weight[(i+1)*DATA_WIDTH-1:(i)*DATA_WIDTH] ),
               .io_outAct    ( wire_Act ),
               .io_outSum    ( outSum[(i+1)*OutData_width-1:i*OutData_width]  ),
               .io_inValid   ( Full_connection_Array[i-1].valid  ),
               .io_clear      (io_clear),
               .io_outValid  ( valid     )
             );
    end
//    assign io_outvalid= Full_connection_Array[FULLCON_Output_Size-1].valid;
//    assign io_outAct= Full_connection_Array[FULLCON_Output_Size-1].wire_Act;






    end
 endgenerate
 reg  finish;
always @(posedge clk ) begin
                if(!rstn||io_clear)
                begin
                    finish<=0;
                end
                else begin
                       finish<=(FULLCON_Output_Size>1)?reg_valid[FULLCON_Output_Size-1]:0;
                end
            end

assign out_finish=(FULLCON_Output_Size>1)?finish&~reg_valid[FULLCON_Output_Size-1]:0;

endmodule


