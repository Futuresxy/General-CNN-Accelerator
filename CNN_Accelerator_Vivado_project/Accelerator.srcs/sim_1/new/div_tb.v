`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/25 13:39:57
// Design Name: 
// Module Name: div_tb
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


module div_tb(

    );
reg aclk;
reg s_axis_divisor_tvalid;
reg s_axis_dividend_tvalid;
reg [7:0] s_axis_divisor_tdata;
reg [7:0] s_axis_dividend_tdata;
wire m_axis_dout_tvalid;
wire [15:0] m_axis_dout_tdata;
wire [7:0] quotient;
wire [7:0] remainder;

assign quotient = m_axis_dout_tdata[15:8];
assign remainder = m_axis_dout_tdata[7:0];

initial begin
    aclk = 1'b1;
    forever #10 aclk = ~aclk;
end

initial begin
    s_axis_dividend_tdata = 8'd0;
    s_axis_dividend_tvalid = 1'b0;
    s_axis_divisor_tvalid = 8'd0;
    s_axis_divisor_tdata = 1'b0;
    # 40;
    s_axis_dividend_tdata = 8'd123;
    s_axis_dividend_tvalid = 1'b1;
    s_axis_divisor_tdata = 8'd10;
    s_axis_divisor_tvalid = 1'b1;
    # 60;
    s_axis_dividend_tdata = -8'd12;
    s_axis_dividend_tvalid = 1'b1;
    s_axis_divisor_tdata = 8'd10;
    s_axis_divisor_tvalid = 1'b1;
    # 60;
    s_axis_dividend_tdata = 8'd189;
    s_axis_dividend_tvalid = 1'b1;
    s_axis_divisor_tdata = -8'd10;
    s_axis_divisor_tvalid = 1'b1;
    # 60;
    s_axis_dividend_tdata = -8'd125;
    s_axis_dividend_tvalid = 1'b1;
    s_axis_divisor_tdata = -8'd10;
    s_axis_divisor_tvalid = 1'b1;
end

div_gen_0 inst0 (
  .aclk(aclk),                                      // input wire aclk
  .s_axis_divisor_tvalid(s_axis_divisor_tvalid),    // input wire s_axis_divisor_tvalid
  .s_axis_divisor_tdata(s_axis_divisor_tdata),      // input wire [15 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(s_axis_dividend_tvalid),  // input wire s_axis_dividend_tvalid
  .s_axis_dividend_tdata(s_axis_dividend_tdata),    // input wire [15 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(m_axis_dout_tvalid),          // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(m_axis_dout_tdata)            // output wire [15 : 0] m_axis_dout_tdata
);

endmodule
