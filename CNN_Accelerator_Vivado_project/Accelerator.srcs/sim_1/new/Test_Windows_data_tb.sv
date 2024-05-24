`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/04 11:10:49
// Design Name: 
// Module Name: Test_Windows_data_tb
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


import axi_vip_pkg::*;
import Windows_data_Test_axi_vip_0_0_pkg::*;
import axi4stream_vip_pkg::*;
import Windows_data_Test_axi4stream_vip_0_0_pkg::*;//master
import Windows_data_Test_axi4stream_vip_1_0_pkg::*;  //slave



module Test_Windows_data_tb(

    );
    bit axi_clk = 0;
    bit axi_resetn = 0;
    bit [7:0]  mtestWData = 8'd6;  
    bit [31:0] rdata = 32'd0;
    xil_axi_resp_t  resp;

    parameter integer address = 32'h00000000;

    Windows_data_Test_wrapper u_design_axi_vip_wrapper 
    (
        .aclk    (axi_clk),
        .aresetn (axi_resetn)
    );

    initial begin 
        axi_clk = 1;
        axi_resetn = 0;
        #230ns
        axi_resetn = 1;
        #5000ns
        $stop();
    end

    always #5ns axi_clk = ~ axi_clk;

    // 
    Windows_data_Test_axi_vip_0_0_mst_t  master;
    Windows_data_Test_axi4stream_vip_0_0_mst_t   axis_master;
    //Windows_data_Test_axi4stream_vip_0_1_slv_t   axis_slave;
    axi4stream_transaction   wr_transaction; // write transaction created by master VIP 
    axi4stream_ready_gen ready_gen;// Ready signal created by slave VIP when TREADY is High
    initial begin
        master= new (" master axi vip ", u_design_axi_vip_wrapper.Windows_data_Test_i.axi_vip_0.inst.IF);
        axis_master =new ("master vip agent", u_design_axi_vip_wrapper.Windows_data_Test_i.axi4stream_vip_0.inst.IF);
       // axis_slave  =new ("slave vip agent ", u_design_axi_vip_wrapper.Windows_data_Test_i.axi4stream_vip_1.inst.IF);
        master.start_master();
        axis_master.start_master();
      //  axis_slave.start_slave();
        wait(axi_resetn == 1'b1);

        #200ns
        master.AXI4LITE_WRITE_BURST(address + 32'h00000000, 0, 32'd28, resp);

        #200ns
        master.AXI4LITE_WRITE_BURST(address + 32'h00000004, 0, 32'd28, resp);

        #200ns
        master.AXI4LITE_WRITE_BURST(address + 32'h00000008, 0, 32'd4, resp);

        #200ns   
        master.AXI4LITE_WRITE_BURST(address + 32'h0000000c, 0, 32'd0, resp);

        #200ns
        master.AXI4LITE_READ_BURST(address + 32'h00000000, 0, rdata, resp);

        #200ns
        master.AXI4LITE_READ_BURST(address + 32'h00000004, 0, rdata, resp);

        #200ns
        master.AXI4LITE_READ_BURST(address + 32'h00000008, 0, rdata, resp);

        #200ns   
        master.AXI4LITE_READ_BURST(address + 32'h0000000c, 0, rdata, resp);
           
   
      
      
    end
  

endmodule

/*
bit clk;
bit aresetn;

//used in API and parital randomization for transaction generation and data read back from driver
axi_transaction                         wr_transaction;                // Write transaction
axi_transaction                         rd_transaction;                // Read transaction

xil_axi_uint                            mtestWID;                      // Write ID  
xil_axi_ulong                           mtestWADDR;                    // Write ADDR  
xil_axi_len_t                           mtestWBurstLength;             // Write Burst Length   
xil_axi_size_t                          mtestWDataSize;                // Write SIZE  
xil_axi_burst_t                         mtestWBurstType;               // Write Burst Type  
xil_axi_uint                            mtestRID;                      // Read ID  
xil_axi_ulong                           mtestRADDR;                    // Read ADDR  
xil_axi_len_t                           mtestRBurstLength;             // Read Burst Length   
xil_axi_size_t                          mtestRDataSize;                // Read SIZE  
xil_axi_burst_t                         mtestRBurstType;               // Read Burst Type  
xil_axi_lock_t                          mtestLOCK;                     // LOCK value for WRITE/READ_BURST transaction
xil_axi_cache_t                         mtestCacheType = 3;            // Cache Type value for WRITE/READ_BURST transaction
xil_axi_prot_t                          mtestProtectionType = 3'b000;  // Protection Type value for WRITE/READ_BURST transaction
xil_axi_region_t                        mtestRegion = 4'b000;          // Region value for WRITE/READ_BURST transaction
xil_axi_qos_t                           mtestQOS = 4'b000;             // QOS value for WRITE/READ_BURST transaction
xil_axi_data_beat                       dbeat;                         // Data beat value for WRITE/READ_BURST transaction
xil_axi_user_beat                       usrbeat;                       // User beat value for WRITE/READ_BURST transaction
xil_axi_data_beat [255:0]               mtestWUSER;                    // Wuser value for WRITE/READ_BURST transaction
xil_axi_data_beat                       mtestAWUSER = 'h0;             // Awuser value for WRITE/READ_BURST transaction
xil_axi_data_beat                       mtestARUSER = 0;               // Aruser value for WRITE/READ_BURST transaction
xil_axi_data_beat [255:0]               mtestRUSER;                    // Ruser value for WRITE/READ_BURST transaction
xil_axi_uint                            mtestBUSER = 0;                // Buser value for WRITE/READ_BURST transaction
xil_axi_resp_t                          mtestBresp;                    // Bresp value for WRITE/READ_BURST transaction
xil_axi_resp_t[255:0]                   mtestRresp;                    // Rresp value for WRITE/READ_BURST transaction

bit [63:0]                             mtestWData;                     // Write Data
bit[8*4096-1:0]                        Wdatablock;                     // Write data block
xil_axi_data_beat                      Wdatabeat[];                    // Write data beats

bit [63:0]                             mtestRData;                     // Read Data
bit[8*4096-1:0]                        Rdatablock;                     // Read data block
xil_axi_data_beat                      Rdatabeat[];                    // Read data beats


  initial begin
    aresetn = 1'b0;
    clk = 1'b0;
    #100ns;
    aresetn = 1'b1;
  end
   
  always #10 clk <= ~clk;

Windows_data_Test_wrapper u_dut(
    .aclk       (clk     ),
    .aresetn    (aresetn )
);

axi_demo_axi_vip_0_0_mst_t              mst_agent;

initial begin
    mst_agent = new("master vip agent",u_dut.axi_vip_0.inst.IF);
    mst_agent.start_master();               // mst_agent start to run
    mtestWID = $urandom_range(0,(1<<(0)-1)); 
    mtestWADDR = 'h0000_0000;//$urandom_range(0,(1<<(32)-1));
    mtestWBurstLength = 0;
    mtestWDataSize = xil_axi_size_t'(xil_clog2((32)/8));
    mtestWBurstType = XIL_AXI_BURST_TYPE_INCR;
    mtestWData = 'd28;//$urandom();
    $display("mtestWDataSize = %d", mtestWDataSize);
    //single write transaction filled in user inputs through API 
    single_write_transaction_api("single write with api",
                                 .id(mtestWID),
                                 .addr(mtestWADDR),
                                 .len(mtestWBurstLength), 
                                 .size(mtestWDataSize),
                                 .burst(mtestWBurstType),
                                 .wuser(mtestWUSER),
                                 .awuser(mtestAWUSER), 
                                 .data(mtestWData)
                                 );
                                  
    mtestRID = $urandom_range(0,(1<<(0)-1));
    mtestRADDR = mtestWADDR;
    mtestRBurstLength = 0;
    mtestRDataSize = xil_axi_size_t'(xil_clog2((32)/8)); 
    mtestRBurstType = XIL_AXI_BURST_TYPE_INCR;
    
    $display("mtestRDataSize = %d", mtestRDataSize);
    //single read transaction filled in user inputs through API 
    single_read_transaction_api("single read with api",
                                 .id(mtestRID),
                                 .addr(mtestRADDR),
                                 .len(mtestRBurstLength), 
                                 .size(mtestRDataSize),
                                 .burst(mtestRBurstType)
                                 );
end

  task automatic single_write_transaction_api ( 
                                input string                     name ="single_write",
                                input xil_axi_uint               id =0, 
                                input xil_axi_ulong              addr =0,
                                input xil_axi_len_t              len =0, 
                                input xil_axi_size_t             size =xil_axi_size_t'(xil_clog2((32)/8)),
                                input xil_axi_burst_t            burst =XIL_AXI_BURST_TYPE_INCR,
                                input xil_axi_lock_t             lock = XIL_AXI_ALOCK_NOLOCK,
                                input xil_axi_cache_t            cache =3,
                                input xil_axi_prot_t             prot =0,
                                input xil_axi_region_t           region =0,
                                input xil_axi_qos_t              qos =0,
                                input xil_axi_data_beat [255:0]  wuser =0, 
                                input xil_axi_data_beat          awuser =0,
                                input bit [63:0]              data =0
                                                );
    axi_transaction                               wr_trans;
    $display("single_write_transaction_api size = %d", size);
    wr_trans = mst_agent.wr_driver.create_transaction(name);
    wr_trans.set_write_cmd(addr,burst,id,len,size);
    wr_trans.set_prot(prot);
    wr_trans.set_lock(lock);
    wr_trans.set_cache(cache);
    wr_trans.set_region(region);
    wr_trans.set_qos(qos);
    wr_trans.set_data_block(data);
    mst_agent.wr_driver.send(wr_trans);   
  endtask  : single_write_transaction_api 
 
  task automatic single_read_transaction_api ( 
                                    input string                     name ="single_read",
                                    input xil_axi_uint               id =0, 
                                    input xil_axi_ulong              addr =0,
                                    input xil_axi_len_t              len =0, 
                                    input xil_axi_size_t             size =xil_axi_size_t'(xil_clog2((32)/8)),
                                    input xil_axi_burst_t            burst =XIL_AXI_BURST_TYPE_INCR,
                                    input xil_axi_lock_t             lock =XIL_AXI_ALOCK_NOLOCK ,
                                    input xil_axi_cache_t            cache =3,
                                    input xil_axi_prot_t             prot =0,
                                    input xil_axi_region_t           region =0,
                                    input xil_axi_qos_t              qos =0,
                                    input xil_axi_data_beat          aruser =0
                                                );
    axi_transaction                               rd_trans;
    $display("single_read_transaction_api size = %d", size);
    rd_trans = mst_agent.rd_driver.create_transaction(name);
    rd_trans.set_read_cmd(addr,burst,id,len,size);
    rd_trans.set_prot(prot);
    rd_trans.set_lock(lock);
    rd_trans.set_cache(cache);
    rd_trans.set_region(region);
    rd_trans.set_qos(qos);
    mst_agent.rd_driver.send(rd_trans);   
  endtask  : single_read_transaction_api

endmodule*/
