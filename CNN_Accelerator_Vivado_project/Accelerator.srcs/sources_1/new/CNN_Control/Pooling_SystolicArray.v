module Pooling_SystolicArray#(
    parameter DATA_WIDTH=16,
    parameter PARA_WIDTH=32,
    parameter POOL_KERNEL_SIZE=2 
)(
  input                                           clk ,
  input                                           rstn,
  input                                           refresh,
  input         [PARA_WIDTH-1     :0]             Pool_Kernel_Size,
  input  signed [POOL_KERNEL_SIZE*POOL_KERNEL_SIZE*DATA_WIDTH-1:0] io_inAct,
  output signed [DATA_WIDTH-1                 :0] io_outSum,
  input                                           io_Max_MeanValid
);


reg  [DATA_WIDTH-1:0] reg_outAnswer  [POOL_KERNEL_SIZE*POOL_KERNEL_SIZE-1:0];

genvar i;

 generate
    for (i=0;i<POOL_KERNEL_SIZE*POOL_KERNEL_SIZE-1;i=i+1)
    begin :Pool_Array
      wire [DATA_WIDTH-1:0] wire_outAnswer;
            if(i==0) begin:Pool_0
              Pool_PE#(
                  .DATA_WIDTH(DATA_WIDTH)
              ) Array ( 
              .clk(clk),
              .rstn(rstn        ),
              .refresh (refresh),
              .io_inAct1(io_inAct[DATA_WIDTH-1:0]),
              .io_inAct2(io_inAct[2*DATA_WIDTH-1:DATA_WIDTH]),
              .io_outAnswer(wire_outAnswer),
              .io_Max_MeanValid(io_Max_MeanValid)
            );

          end
            else begin:Pool_x
              Pool_PE#(
                  .DATA_WIDTH(DATA_WIDTH)
              ) Array ( 
              .clk(clk),
              .rstn(rstn        ),
              .refresh (refresh),
              .io_inAct1(Pool_Array[i-1].wire_outAnswer),
              .io_inAct2(io_inAct[(i+2)*DATA_WIDTH-1:(i+1)*DATA_WIDTH]),
              .io_outAnswer(wire_outAnswer),
              .io_Max_MeanValid(io_Max_MeanValid)
            );
              end
    end
 endgenerate

genvar j;

 generate
    for (j=0;j<POOL_KERNEL_SIZE*POOL_KERNEL_SIZE-1;j=j+1)
        always @(posedge clk ) begin
          if (!rstn) begin
            reg_outAnswer[j]<=0;
          end
          else begin
              reg_outAnswer[j]<=Pool_Array[j].wire_outAnswer;
          end
        end


endgenerate





assign io_outSum =(Pool_Kernel_Size<2)?0:(io_Max_MeanValid?reg_outAnswer[Pool_Kernel_Size*Pool_Kernel_Size-2]:reg_outAnswer[Pool_Kernel_Size*Pool_Kernel_Size-2]/(Pool_Kernel_Size*Pool_Kernel_Size));

endmodule