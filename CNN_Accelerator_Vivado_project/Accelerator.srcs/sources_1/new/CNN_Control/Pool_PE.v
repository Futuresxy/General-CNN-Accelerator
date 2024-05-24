module Pool_PE#(
    parameter DATA_WIDTH=16 
)
(
  input         clk,
  input         rstn,
  input                                     refresh,
  input  signed [DATA_WIDTH-1:0] io_inAct1,
  input  signed [DATA_WIDTH-1:0] io_inAct2,
  output signed [DATA_WIDTH-1:0] io_outAnswer,
  input                      io_Max_MeanValid
);
  reg [15:0] outAnswer_reg; // @[Pool_PE.scala 15:28]



always @(posedge clk ) begin
   if(!rstn||refresh)
   begin
        outAnswer_reg <=0;
   end
    else begin
        if(io_Max_MeanValid==1)
        outAnswer_reg <=  $signed(io_inAct1) > $signed(io_inAct2) ? $signed(io_inAct1) : $signed(io_inAct2);
        else 
        outAnswer_reg <=  $signed(io_inAct1) + $signed(io_inAct2);
    end
end

  assign io_outAnswer = outAnswer_reg; 


endmodule