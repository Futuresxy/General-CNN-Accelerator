
`timescale 1 ns / 1 ps

	module Windows_Data_Convert_v1_0_M00_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		parameter      KERNEL_SIZE =2,
		// Do not modify the parameters beyond this line
		parameter integer C_M_AXIS_PARA_DATA_WIDTH=8,
		// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32
	)
	(
		// Users to add ports here
		input [C_M_AXIS_TDATA_WIDTH-1:0] OUT_WINDOW_DATA,
		input                            OUT_DATA_VALID,
		input                            OUT_DATA_LAST,
		// User ports ends
		// Do not modify the ports beyond this line
        input  [C_M_AXIS_PARA_DATA_WIDTH-1:0] Kernel_size,
		// Global ports
		input wire  M_AXIS_ACLK,
		// 
		input wire  M_AXIS_ARESETN,
		// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		output wire  M_AXIS_TVALID,
		// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
		// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
		
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TKEEP,
		// TLAST indicates the boundary of a packet.
		output reg  M_AXIS_TLAST,
		// TREADY indicates that the slave can accept a transfer in the current cycle.
		input wire  M_AXIS_TREADY
	);
	                                                             
	
	// AXI Stream internal signals
	//streaming data valid
	wire  	axis_tvalid;
	//streaming data valid delayed by one clock cycle
	reg  	axis_tvalid_delay;
	//Last of the streaming data 
	wire  	axis_tlast;
	//no required delayed by one clock cycle,because
	//reg  	axis_tlast_delay;

reg [C_M_AXIS_TDATA_WIDTH-1 : 0] stream_data_out;
reg [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] data_tstrb;
reg [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] data_tkeep;
	// I/O Connections assignments

	assign M_AXIS_TVALID = axis_tvalid_delay;
	assign M_AXIS_TDATA	= stream_data_out;
	//assign M_AXIS_TLAST	= OUT_DATA_LAST;
	assign M_AXIS_TSTRB	= data_tstrb;  //Kernel_size*Kernel_size    {{(C_M_AXIS_TDATA_WIDTH/8)}{1'd1}};//
    assign M_AXIS_TKEEP  =data_tkeep;
  	genvar i;
	// 每个上升沿，由低向高移位一次  
	generate
		for(i=0;i<C_M_AXIS_TDATA_WIDTH/8;i=i+1)  
	       always@(posedge M_AXIS_ACLK  )begin:strb
	           	if(!M_AXIS_ARESETN)begin
                      data_tstrb[i] <= 0;
                      data_tkeep[i] <= 0;
	           	end
	           	else begin
	           	  if(i<Kernel_size*Kernel_size)
	           		begin
						data_tstrb[i] <= 1;
						data_tkeep[i] <= 1;
	           		end
	           	   else begin
                        data_tstrb[i] <= 0;
                        data_tkeep[i] <= 0;
	           	end
	           	end
	           	
	           end
	endgenerate
  
  
  
  
	always @(posedge M_AXIS_ACLK)                                             
	begin                                                                     
	  if (!M_AXIS_ARESETN)                                                    
	  // Synchronous reset (active low)                                       
	    begin                                                                 
	      M_AXIS_TLAST <= 0;                                                                                                
	    end                                                                   
	  else begin
	     M_AXIS_TLAST	<= OUT_DATA_LAST;
	                                                                       
	   end                                               
	end     
                           
	always @(posedge M_AXIS_ACLK)                                             
	begin                                                                     
	  if (!M_AXIS_ARESETN)                                                    
	  // Synchronous reset (active low)                                       
	    begin                                                                 
	      stream_data_out <= 0;                                                                                                
	    end                                                                   
	  else begin
	     stream_data_out<=OUT_WINDOW_DATA;
	                                                                       
	   end                                               
	end                                                                       

	always @(posedge M_AXIS_ACLK)                                             
	begin                                                                     
	  if (!M_AXIS_ARESETN)                                                    
	  // Synchronous reset (active low)                                       
	    begin                                                                 
	      axis_tvalid_delay <= 0;                                                                                                
	    end                                                                   
	  else begin
	     axis_tvalid_delay<=OUT_DATA_VALID;
	                                                                       
	   end                                               
	end                                                                                               


	// Add user logic here

	// User logic ends

	endmodule
