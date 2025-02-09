`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/08 17:04:18
// Design Name: 
// Module Name: CNN_Module_tb
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


module CNN_Module_tb();
parameter KERNEL_SIZE=5;

parameter Data_horizontal_address=0;
parameter Data_vertical_address=4;
parameter Kernel_size_address=8;
parameter Stride_address=12;
parameter Refresh_address=16;

//---------------CNN�Ĵ�����ַ------------------
parameter Conv_Kernel_Size_address=0;
parameter Conv_Kernel_Num_address=4;
parameter Pool_Kernel_Size_address=8;
parameter Pool_Kernel_Num_address=12;
parameter FULLCON_Input_Size_address=16;
parameter FULLCON_Output_Size_address=20;
parameter select_mode_address=24;
parameter cnn_start_address=28;
parameter SCALE_RIGHT=32;
parameter SCALE_LEFT=36;

parameter MODE_IDLE      =0;
parameter MODE_CONV      =1;
parameter MODE_RELU      =2;
parameter MODE_POOL_Max  =4;
parameter MODE_POOL_Mean =5;
parameter MODE_FULLCON   =8;
parameter MODE_CONV_RELU =16;
  // Declaring the signals
  reg [7:0] AXI4_LITE_Control_Accelerator_araddr;
  reg [2:0] AXI4_LITE_Control_Accelerator_arprot=3'b000;
  reg AXI4_LITE_Control_Accelerator_arvalid;
  wire AXI4_LITE_Control_Accelerator_arready;
  reg [7:0] AXI4_LITE_Control_Accelerator_awaddr;
  reg [2:0] AXI4_LITE_Control_Accelerator_awprot=3'b000;
  reg AXI4_LITE_Control_Accelerator_awvalid;
  wire AXI4_LITE_Control_Accelerator_awready;
  reg AXI4_LITE_Control_Accelerator_bready=1'b1;
  wire [1:0] AXI4_LITE_Control_Accelerator_bresp;
  wire AXI4_LITE_Control_Accelerator_bvalid;
  wire [31:0] AXI4_LITE_Control_Accelerator_rdata;
  reg AXI4_LITE_Control_Accelerator_rready;
  wire [1:0] AXI4_LITE_Control_Accelerator_rresp;
  wire AXI4_LITE_Control_Accelerator_rvalid;
  reg [31:0] AXI4_LITE_Control_Accelerator_wdata;
  wire AXI4_LITE_Control_Accelerator_wready;
  reg [3:0] AXI4_LITE_Control_Accelerator_wstrb=4'b1111;
  reg AXI4_LITE_Control_Accelerator_wvalid;

  reg [4:0] AXI4_LITE_Control_Window_araddr;
  reg [2:0] AXI4_LITE_Control_Window_arprot=3'b000;
  reg AXI4_LITE_Control_Window_arvalid;
  wire AXI4_LITE_Control_Window_arready;
  reg [4:0] AXI4_LITE_Control_Window_awaddr;
  reg [2:0] AXI4_LITE_Control_Window_awprot=3'b000;
  reg AXI4_LITE_Control_Window_awvalid;
  wire AXI4_LITE_Control_Window_awready;
  reg AXI4_LITE_Control_Window_bready=1'b1;
  wire [1:0] AXI4_LITE_Control_Window_bresp;
  wire AXI4_LITE_Control_Window_bvalid;
  wire [31:0] AXI4_LITE_Control_Window_rdata;
  reg AXI4_LITE_Control_Window_rready;
  wire [1:0] AXI4_LITE_Control_Window_rresp;
  wire AXI4_LITE_Control_Window_rvalid;
  reg [31:0] AXI4_LITE_Control_Window_wdata;
  wire AXI4_LITE_Control_Window_wready;
  reg [3:0] AXI4_LITE_Control_Window_wstrb=4'b1111;
  reg AXI4_LITE_Control_Window_wvalid;
  
  
   reg M_AXIS_tready;
  // AXI Stream Signals
  reg [63:0] S_AXIS1_tdata;
  reg [7:0] S_AXIS1_tkeep;
  reg S_AXIS1_tlast;
  wire S_AXIS1_tready;
  reg [7:0] S_AXIS1_tstrb;
  reg S_AXIS1_tvalid;

  reg [7:0] S_AXIS2_tdata;
  reg [0:0] S_AXIS2_tkeep;
  reg S_AXIS2_tlast;
  wire S_AXIS2_tready;
  reg S_AXIS2_tvalid;

  reg [63:0] S_AXIS_tdata;
  reg [7:0] S_AXIS_tkeep;
  reg S_AXIS_tlast;
  wire S_AXIS_tready;
  reg [7:0] S_AXIS_tstrb;
  reg S_AXIS_tvalid;

  wire [3:0] cnn_cnt_0;
  wire cnn_done;
  reg s_axis_aclk;
  reg s_axis_aresetn;

  // Instantiate the design under test
  CNN_Module_wrapper uut (
    .AXI4_LITE_Control_Accelerator_araddr(AXI4_LITE_Control_Accelerator_araddr),
    .AXI4_LITE_Control_Accelerator_arprot(AXI4_LITE_Control_Accelerator_arprot),
    .AXI4_LITE_Control_Accelerator_arready(AXI4_LITE_Control_Accelerator_arready),
    .AXI4_LITE_Control_Accelerator_arvalid(AXI4_LITE_Control_Accelerator_arvalid),
    .AXI4_LITE_Control_Accelerator_awaddr(AXI4_LITE_Control_Accelerator_awaddr),
    .AXI4_LITE_Control_Accelerator_awprot(AXI4_LITE_Control_Accelerator_awprot),
    .AXI4_LITE_Control_Accelerator_awready(AXI4_LITE_Control_Accelerator_awready),
    .AXI4_LITE_Control_Accelerator_awvalid(AXI4_LITE_Control_Accelerator_awvalid),
    .AXI4_LITE_Control_Accelerator_bready(AXI4_LITE_Control_Accelerator_bready),
    .AXI4_LITE_Control_Accelerator_bresp(AXI4_LITE_Control_Accelerator_bresp),
    .AXI4_LITE_Control_Accelerator_bvalid(AXI4_LITE_Control_Accelerator_bvalid),
    .AXI4_LITE_Control_Accelerator_rdata(AXI4_LITE_Control_Accelerator_rdata),
    .AXI4_LITE_Control_Accelerator_rready(AXI4_LITE_Control_Accelerator_rready),
    .AXI4_LITE_Control_Accelerator_rresp(AXI4_LITE_Control_Accelerator_rresp),
    .AXI4_LITE_Control_Accelerator_rvalid(AXI4_LITE_Control_Accelerator_rvalid),
    .AXI4_LITE_Control_Accelerator_wdata(AXI4_LITE_Control_Accelerator_wdata),
    .AXI4_LITE_Control_Accelerator_wready(AXI4_LITE_Control_Accelerator_wready),
    .AXI4_LITE_Control_Accelerator_wstrb(AXI4_LITE_Control_Accelerator_wstrb),
    .AXI4_LITE_Control_Accelerator_wvalid(AXI4_LITE_Control_Accelerator_wvalid),
    .AXI4_LITE_Control_Window_araddr(AXI4_LITE_Control_Window_araddr),
    .AXI4_LITE_Control_Window_arprot(AXI4_LITE_Control_Window_arprot),
    .AXI4_LITE_Control_Window_arready(AXI4_LITE_Control_Window_arready),
    .AXI4_LITE_Control_Window_arvalid(AXI4_LITE_Control_Window_arvalid),
    .AXI4_LITE_Control_Window_awaddr(AXI4_LITE_Control_Window_awaddr),
    .AXI4_LITE_Control_Window_awprot(AXI4_LITE_Control_Window_awprot),
    .AXI4_LITE_Control_Window_awready(AXI4_LITE_Control_Window_awready),
    .AXI4_LITE_Control_Window_awvalid(AXI4_LITE_Control_Window_awvalid),
    .AXI4_LITE_Control_Window_bready(AXI4_LITE_Control_Window_bready),
    .AXI4_LITE_Control_Window_bresp(AXI4_LITE_Control_Window_bresp),
    .AXI4_LITE_Control_Window_bvalid(AXI4_LITE_Control_Window_bvalid),
    .AXI4_LITE_Control_Window_rdata(AXI4_LITE_Control_Window_rdata),
    .AXI4_LITE_Control_Window_rready(AXI4_LITE_Control_Window_rready),
    .AXI4_LITE_Control_Window_rresp(AXI4_LITE_Control_Window_rresp),
    .AXI4_LITE_Control_Window_rvalid(AXI4_LITE_Control_Window_rvalid),
    .AXI4_LITE_Control_Window_wdata(AXI4_LITE_Control_Window_wdata),
    .AXI4_LITE_Control_Window_wready(AXI4_LITE_Control_Window_wready),
    .AXI4_LITE_Control_Window_wstrb(AXI4_LITE_Control_Window_wstrb),
    .AXI4_LITE_Control_Window_wvalid(AXI4_LITE_Control_Window_wvalid),
    .M_AXIS_tdata(M_AXIS_tdata),
    .M_AXIS_tlast(M_AXIS_tlast),
    .M_AXIS_tready(M_AXIS_tready),
    .M_AXIS_tvalid(M_AXIS_tvalid),
    .S_AXIS1_tdata(S_AXIS1_tdata),
    .S_AXIS1_tkeep(S_AXIS1_tkeep),
    .S_AXIS1_tlast(S_AXIS1_tlast),
    .S_AXIS1_tready(S_AXIS1_tready),
    .S_AXIS1_tstrb(S_AXIS1_tstrb),
    .S_AXIS1_tvalid(S_AXIS1_tvalid),
    .S_AXIS2_tdata(S_AXIS2_tdata),
    .S_AXIS2_tkeep(S_AXIS2_tkeep),
    .S_AXIS2_tlast(S_AXIS2_tlast),
    .S_AXIS2_tready(S_AXIS2_tready),
    .S_AXIS2_tvalid(S_AXIS2_tvalid),
    .S_AXIS_tdata(S_AXIS_tdata),
    .S_AXIS_tkeep(S_AXIS_tkeep),
    .S_AXIS_tlast(S_AXIS_tlast),
    .S_AXIS_tready(S_AXIS_tready),
    .S_AXIS_tstrb(S_AXIS_tstrb),
    .S_AXIS_tvalid(S_AXIS_tvalid),
    .cnn_cnt_0(cnn_cnt_0),
    .cnn_done(cnn_done),
    .s_axis_aclk(s_axis_aclk),
    .s_axis_aresetn(s_axis_aresetn)
  );

  // Task to write to AXI4-Lite Control Accelerator
// Task to write to AXI4-Lite Control Accelerator
task write_to_accelerator;

    input [31:0] addr;
    input [31:0] data;
    begin
      fork 
        begin:write_address
        AXI4_LITE_Control_Accelerator_awaddr = addr;
        AXI4_LITE_Control_Accelerator_awprot=0;
        
        AXI4_LITE_Control_Accelerator_awvalid = 1'd1;
        
          wait(AXI4_LITE_Control_Accelerator_awready);
          @(posedge s_axis_aclk);
          #5;
          AXI4_LITE_Control_Accelerator_awvalid = 1'd0;
        end
        begin:write_data_
         AXI4_LITE_Control_Accelerator_wvalid = 1;
         AXI4_LITE_Control_Accelerator_wdata = data; 
         AXI4_LITE_Control_Accelerator_wstrb   = 4'b1111; 
          wait(AXI4_LITE_Control_Accelerator_wready);
          @(posedge s_axis_aclk);
          #5;
          AXI4_LITE_Control_Accelerator_wvalid  = 1'd0;
        end
      join
    end 
  endtask



  // Task to write to AXI4-Lite Control Window
    task write_to_window;
    input [4:0] addr;
    input [31:0] data;
    begin
      fork 
        begin:write_addr
        AXI4_LITE_Control_Window_awaddr = addr;
        AXI4_LITE_Control_Window_awprot=0;
        
        AXI4_LITE_Control_Window_awvalid = 1'd1;
        
          wait(AXI4_LITE_Control_Window_awready);
          @(posedge s_axis_aclk);
          #5;
          AXI4_LITE_Control_Window_awvalid = 1'd0;
        end
        begin:write_data
         AXI4_LITE_Control_Window_wvalid = 1;
         AXI4_LITE_Control_Window_wdata = data; 
         AXI4_LITE_Control_Window_wstrb   = 4'b1111; 
          wait(AXI4_LITE_Control_Window_wready);
          @(posedge s_axis_aclk);
          #5;
          AXI4_LITE_Control_Window_wvalid  = 1'd0;
        end
      join
    end 
  endtask


// ���񣺴��ı��ļ���ȡ���ݲ�����AXI-Stream�ӿ�
  task read_and_drive_weight_data;
    integer file1;
    reg [63:0] data1;
    reg [7:0] keep1;
    reg last1;
    reg [7:0] strb1;
    reg valid1;
    begin
      // ���ļ�  ��� �� �ػ�����һ��fifo
      file1 = $fopen("E:\\Accelerator\\CNN_Accelerator\\CNN_Accelerator_Vivado_project\\Accelerator.sim\\sim_1\\sim_txt\\input_weight_data.txt", "r");
           if (file1 == 0) begin
        $display("�޷����ļ�");
        $finish;
      end

      // ��ȡ���ݲ������ӿ�
      while (!$feof(file1) ) begin
        // �ӵ�һ���ļ���ȡ����  ���Ȩ������
        @(posedge s_axis_aclk); // �ȴ�һ��ʱ������  
        if (!$feof(file1)) begin
          $fscanf(file1, "%h %b %b %b\n", data1, keep1, last1, strb1);  //���ڶ�������ͬʱ����ʱ��ÿ8bit����һ������˵�һ������
          // ����S_AXIS1�ӿ�
          S_AXIS1_tdata = data1;
          S_AXIS1_tkeep = keep1;
          S_AXIS1_tlast = last1;
          S_AXIS1_tstrb = strb1;
          S_AXIS1_tvalid = 1;
          if(last1==1)begin
          @(posedge s_axis_aclk);
            S_AXIS1_tvalid = 0;
          end
        end
       
      end

      // �ر��ļ�
      $fclose(file1);

    end
  endtask
   task read_and_drive_feature_data;
    integer  file2;

    reg [63:0] data2;
    reg [7:0] keep2;
    reg last2;
    reg [7:0] strb2;
    reg valid2;
    begin
      // ���ļ�  ��� �� �ػ�����һ��fifo
           file2 = $fopen("E:\\Accelerator\\CNN_Accelerator\\CNN_Accelerator_Vivado_project\\Accelerator.sim\\sim_1\\sim_txt\\input_feature_data.txt", "r");
      //file2 = $fopen("E:\\Accelerator\\CNN_Accelerator\\CNN_Accelerator_Vivado_project\\Accelerator.sim\\sim_1\\sim_txt\\input_pool_max_data.txt", "r");
        if (file2 == 0) begin
        $display("�޷����ļ�");
        $finish;
      end

      // ��ȡ���ݲ������ӿ�
      while ( !$feof(file2)) begin
        // �ӵ�һ���ļ���ȡ����  ���Ȩ������
        @(posedge s_axis_aclk); // �ȴ�һ��ʱ������  
        // �ӵڶ����ļ���ȡ����  �����������롢�ػ�������
        if (!$feof(file2)) begin
          $fscanf(file2, "%d %b %b %b\n", data2, keep2, last2, strb2);
          // ����S_AXIS2�ӿ�
          S_AXIS2_tdata = data2;
          S_AXIS2_tkeep = keep2;
          S_AXIS2_tlast = last2;
          S_AXIS2_tvalid = 1;
          if(last2==1)begin
          @(posedge s_axis_aclk);
            S_AXIS2_tvalid = 0;
          end
        end
      end

      // �ر��ļ�
      $fclose(file2);
    end
  endtask
  
   task read_and_drive_fcweight_data;
    integer  file3;
    reg [63:0] data;
    reg [7:0] keep;
    reg last;
    reg [7:0] strb;
    reg valid;
    begin
      // ���ļ�  ��� �� �ػ�����һ��fifo
           file3 = $fopen("E:\\Accelerator\\CNN_Accelerator\\CNN_Accelerator_Vivado_project\\Accelerator.sim\\sim_1\\sim_txt\\input_fcweight_data.txt", "r");
      if ( file3 == 0) begin
        $display("�޷����ļ�");
        $finish;
      end

      // ��ȡ���ݲ������ӿ�
      while (!$feof(file3)) begin
        // �ӵ�һ���ļ���ȡ����  ���Ȩ������
        @(posedge s_axis_aclk); // �ȴ�һ��ʱ������  


        // �ӵ������ļ���ȡ����  ȫ���Ӳ�Ȩ��
        if (!$feof(file3)) begin
          $fscanf(file3, "%d %b %b %b\n", data, keep, last, strb);
          // ����S_AXIS�ӿ�
          S_AXIS_tdata = data;
          S_AXIS_tkeep = keep;
          S_AXIS_tlast = last;
          S_AXIS_tstrb = strb;
          S_AXIS_tvalid = 1;
          if(last==1)begin
          @(posedge s_axis_aclk);
            S_AXIS_tvalid = 0;
          end
        end

      end

      // �ر��ļ�

      $fclose(file3);
    end
  endtask
  // Test stimulus
  initial begin
    M_AXIS_tready=1;
    // Initializing the signals
    s_axis_aclk = 1; 
    s_axis_aresetn = 0;    
    @(posedge s_axis_aclk); s_axis_aresetn = 1; 
// Test AXI4-Lite Window write
   @(posedge s_axis_aclk);
    write_to_window(Data_horizontal_address,8);
   @(posedge s_axis_aclk);
   write_to_window(Data_vertical_address,8);
   @(posedge s_axis_aclk);
   write_to_window( Kernel_size_address,2);
   @(posedge s_axis_aclk);
   write_to_window( Stride_address,2);
   @(posedge s_axis_aclk);
   write_to_window(Refresh_address,0);
   @(posedge s_axis_aclk);

//---------------CNN�Ĵ�����ַ------------------
// Test AXI4-Lite Accelerator write
@(posedge s_axis_aclk); write_to_accelerator(Conv_Kernel_Size_address,2);
@(posedge s_axis_aclk); write_to_accelerator(Conv_Kernel_Num_address,4);
@(posedge s_axis_aclk); write_to_accelerator(Pool_Kernel_Size_address,2);
@(posedge s_axis_aclk); write_to_accelerator(Pool_Kernel_Num_address,1);
@(posedge s_axis_aclk); write_to_accelerator(FULLCON_Input_Size_address,100);
@(posedge s_axis_aclk); write_to_accelerator(FULLCON_Output_Size_address,8);
@(posedge s_axis_aclk); write_to_accelerator(select_mode_address,MODE_CONV_RELU);
@(posedge s_axis_aclk); write_to_accelerator(SCALE_LEFT,0);//������
@(posedge s_axis_aclk); write_to_accelerator(SCALE_RIGHT,0);//������
@(posedge s_axis_aclk); write_to_accelerator(cnn_start_address,0);
    // Test AXI4-Lite Window read
    //read_from_window(5'h01, AXI4_LITE_Control_Window_rdata);
       
    // Test AXI4-Lite Accelerator read
    //read_from_accelerator(8'h00, AXI4_LITE_Control_Accelerator_rdata);

    // Stimulus for AXI Stream interfaces (S_AXIS)
    // Assigning test data to S_AXIS inputs
   // �������񣬶�ȡ���ݲ�����AXI-Stream�ӿ�
    read_and_drive_fcweight_data;
    read_and_drive_feature_data;
    read_and_drive_weight_data;
    #2000
    write_to_accelerator(cnn_start_address,1);//��ʼ����
    // Completing the simulation
    #4000;
    $finish;
  end

  // Clock generation for s_axis_aclk
  always #5 s_axis_aclk = ~s_axis_aclk;

endmodule

