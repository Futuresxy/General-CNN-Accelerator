module Conv_PE#(
    parameter DATA_WIDTH=16 
)(
  input                     clk,
  input                     rstn,
  input                     refresh,
  input  [DATA_WIDTH-1  :0] io_inAct,
  input  [2*DATA_WIDTH-1:0] io_inWtPS,
  output [2*DATA_WIDTH-1:0] io_outWtPS,
  output [  DATA_WIDTH-1:0] io_outAct,
  input                     io_inwtValid
);


  reg [DATA_WIDTH-1:0] weightReg; 
  reg [DATA_WIDTH-1:0] actReg; 
  reg [2*DATA_WIDTH-1:0] parSumReg; 

//计算激励乘以权重
  wire [2*DATA_WIDTH-1:0] _parSumReg_T = $signed(weightReg) * $signed(actReg); 

  //存储传递权重
  wire [2*DATA_WIDTH-1:0] _GEN_0 = io_inwtValid ? $signed(io_inWtPS) : $signed({{DATA_WIDTH{weightReg[DATA_WIDTH-1]}},weightReg}); 

//传递权重或者部分和
  assign io_outWtPS = io_inwtValid ? $signed({{DATA_WIDTH{weightReg[DATA_WIDTH-1]}},weightReg}) : $signed(parSumReg); 
  
  assign io_outAct = actReg; 


  always @(posedge clk  or negedge rstn) begin
    if(!rstn||refresh)
    begin
        weightReg<=0; 
        actReg <= 0;
        parSumReg <=0;
    end

    else begin
        weightReg <= _GEN_0[DATA_WIDTH-1:0];
        actReg <= io_inAct; // @[Conv_PE.scala 18:DATA_WIDTH-1]
        parSumReg <= $signed(io_inWtPS) + $signed(_parSumReg_T); // @[Conv_PE.scala 19:28]
    end
    
  end







endmodule