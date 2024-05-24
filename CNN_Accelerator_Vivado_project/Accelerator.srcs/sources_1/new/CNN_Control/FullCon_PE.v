module FullCon_PE#(
    parameter DATA_WIDTH=16,
    parameter OutData_width=32
)  (
  input                                  clk,
  input                                  rstn,
  input  signed  [DATA_WIDTH-1   :0]     io_inAct,
  input  signed  [DATA_WIDTH-1   :0]     io_inWeight,
  output signed  [DATA_WIDTH-1   :0]     io_outAct,
  output signed  [OutData_width-1:0]     io_outSum,
  input                                  io_inValid,
  input                                  io_clear,
  output                                 io_outValid
);

reg [OutData_width-1:0] reg_outsum;
reg [DATA_WIDTH-1   :0] reg_outact;
reg [DATA_WIDTH-1   :0] reg_outweight;
reg                     valid;
assign io_outAct=reg_outact;
assign io_outSum=reg_outsum;
assign io_outValid=valid;


always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        valid<=0;
         reg_outsum<=0;
    end
    else begin
    valid<=io_inValid;
     if(io_clear==1)
        reg_outsum<=0;
        else
        reg_outsum<=valid?reg_outweight*reg_outact+reg_outsum:reg_outsum;
    end
end
    

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        reg_outact<=0;

        reg_outweight<=0;
    end
    else begin
        reg_outact<=io_inAct;
        reg_outweight<=io_inWeight;
       
    end

end



endmodule