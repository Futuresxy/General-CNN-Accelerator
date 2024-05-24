module Conv_PE#(
    parameter DATA_WIDTH=16,
    parameter RESULT_DATA_WIDTH=32 
)(
  input                     clk,
  input                     rstn,
  input                     refresh,
  input  signed [DATA_WIDTH-1  :0] io_inAct,
  input  signed [RESULT_DATA_WIDTH-1:0] io_inWtPS,
  output signed [RESULT_DATA_WIDTH-1:0] io_outWtPS,
  output signed [  DATA_WIDTH-1:0] io_outAct,
  input                     io_inwtValid
);


  reg [DATA_WIDTH-1:0] weightReg; 
  reg [DATA_WIDTH-1:0] actReg; 
  reg [RESULT_DATA_WIDTH-1:0] parSumReg; 

//计算�?励乘以权�?
  wire [RESULT_DATA_WIDTH-1:0] _parSumReg_T = $signed(weightReg) * $signed(io_inAct); 

  //存储传�?�权�?
  wire [RESULT_DATA_WIDTH-1:0] _GEN_0 = io_inwtValid ? $signed(io_inWtPS) : $signed({{(RESULT_DATA_WIDTH-DATA_WIDTH){weightReg[DATA_WIDTH-1]}},weightReg}); 

//传�?�权重或者部分和
  assign io_outWtPS = io_inwtValid ? $signed({{DATA_WIDTH{weightReg[DATA_WIDTH-1]}},weightReg}) : $signed(parSumReg); 
  
  assign io_outAct = actReg; 


  always @(posedge clk ) begin
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



//ila_pe  ila_045
//(
//.clk(clk),
//.probe0({io_inwtValid,weightReg,actReg,parSumReg})

//);



endmodule