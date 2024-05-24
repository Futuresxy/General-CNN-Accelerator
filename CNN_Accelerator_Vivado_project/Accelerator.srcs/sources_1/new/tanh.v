module tanh#(
    parameter Data_width=16,
    parameter OutData_width=32
)  (
  input                                  clk,
  input                                  rstn,
  input                                  resetExternal,
  input  signed  [Data_width-1   :0]     io_inAct,
  input                                  io_inValid,
  output reg signed  [OutData_width-1:0]     io_outTanh,
  output                                 finishedTanh,//½áÊø
  output                                 io_outValid
);
reg [Data_width-1:0] Act  ;
reg [Data_width-1:0] Act_1;
reg [Data_width-1:0] Act_2;
reg [Data_width-1:0] Act_3;
reg [Data_width-1:0] Act_4;


reg [Data_width-1:0] Act2  ;
reg [Data_width-1:0] Act2_1;
reg [Data_width-1:0] Act2_2;
reg [Data_width-1:0] Act2_3;




reg [Data_width-1:0] Act3;
reg [Data_width-1:0] Act3_1;
reg [Data_width-1:0] Act3_2;

reg [Data_width-1:0] Act5;
reg [Data_width-1:0] Act5_1;


reg [Data_width-1:0] Act7;

always @(negedge clk or negedge rstn) begin
    if(!rstn)begin
       Act  <=0;
       Act_1<=0;
       Act_2<=0;
       Act_3<=0;
       Act_4<=0;
    end
    else begin
      Act  <=Act_1;
      Act_1<=Act_2;
      Act_2<=Act_3;
      Act_3<=Act_4;
      Act_4<=io_inAct;
    end
end
always @(negedge clk or negedge rstn) begin
    if(!rstn)begin
       Act2  <=0;
       Act2_1<=0;
       Act2_2<=0;
       Act2_3<=0;
    end
    else begin
       Act2  <=Act2_1;
       Act2_1<=Act2_2;
       Act2_2<=Act2_3;
       Act2_3<=Act_4*Act_4;
    end
end
always @(negedge clk or negedge rstn) begin
    if(!rstn)begin
       Act3<=0;
       Act3_1<=0;
       Act3_2<=0; 
    end
    else begin
       Act3<=Act3_1;
       Act3_1<=Act3_2 / 3;
       Act3_2<=Act2_3*Act_3;
    end
end
always @(negedge clk or negedge rstn) begin
    if(!rstn)begin
       Act5<=0;
       Act5_1<=0;
    end
    else begin
        Act5<=(Act5_1<<2)/15;
        Act5_1<=Act3_2*Act2_2;
      
    end
end
always @(negedge clk or negedge rstn) begin
    if(!rstn)begin
       Act7<=0;
    end
    else begin
      Act7<=Act5_1*Act2_1*17/315;
    end
end
always @(negedge clk or negedge rstn) begin
    if(!rstn)begin
       io_outTanh<=0;
    end
    else begin
      io_outTanh<=Act-Act3+Act5-Act7;
    end
end
endmodule