
`timescale 1 ns / 1 ps

	module Windows_Data_Convert_v1_0_S00_AXIS #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line
		parameter KERNEL_SIZE    =2, // 卷积核心的大小 4x4              
		parameter DATA_HORIZONTAL=28,//输入数据的横向长
		parameter DATA_VERTICAL  =28,//输入数据的纵向长
		parameter STRIDE         =1,//卷积操作窗滑动的步长  
		parameter integer C_S_AXIS_PARA_DATA_WIDTH =8,
		// AXI4Stream sink: Data Width
		parameter integer C_S_AXIS_TDATA_WIDTH	= 8
	)
	(
		// Users to add ports here
		input	wire [C_S_AXIS_PARA_DATA_WIDTH-1:0]	Data_horizontal,
		input	wire [C_S_AXIS_PARA_DATA_WIDTH-1:0]	Data_vertical,
		input	wire [C_S_AXIS_PARA_DATA_WIDTH-1:0]	Kernel_size,
		input	wire [C_S_AXIS_PARA_DATA_WIDTH-1:0]	Stride,
		input                                       Refresh,
		output [C_S_AXIS_TDATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0] OUT_WINDOW_DATA,
		output                                                    OUT_DATA_VALID,
		output  reg                                                  OUT_DATA_LAST,
		// User ports ends
		// Do not modify the ports beyond this line

		// AXI4Stream sink: Clock
		input wire  S_AXIS_ACLK,
		// AXI4Stream sink: Reset
		input wire  S_AXIS_ARESETN,
		// Ready to accept data in
		output reg  S_AXIS_TREADY,
		// Data in
		input wire [C_S_AXIS_TDATA_WIDTH-1 : 0] S_AXIS_TDATA,
		// Byte qualifier
		input wire [(C_S_AXIS_TDATA_WIDTH/8)-1 : 0] S_AXIS_TSTRB,
		// Indicates boundary of last packet
		input wire  S_AXIS_TLAST,
		// Data is in valid
		input wire  S_AXIS_TVALID
	);
	// Define the states of state machine
	// The control state machine oversees the CONVERT data to conv window
	parameter [1:0] IDLE = 1'b0,        // This is the initial/idle state 

	               START_WINDOWS  = 1'b1; // start to convert data
	wire  	axis_tready;
	//reg     axis_tready1;
	// State variable
	reg mst_exec_state;     
	// convert data start 
	(*mark_debug="true"*) wire  convert_start;
	// convert data finished 
	wire  convert_done;
	wire data_last;
	
		//assign OUT_DATA_LAST     =convert_done;
	// I/O Connections assignments
	always @(posedge S_AXIS_ACLK) 
	begin  
	  if (!S_AXIS_ARESETN) 
	  // Synchronous reset (active low)
	    begin
	      OUT_DATA_LAST<=0;
	    end  
	  else begin
	    OUT_DATA_LAST<=data_last;
	  end
	  
	end	
		
		
	// I/O Connections assignments
	always @(posedge S_AXIS_ACLK) 
	begin  
	  if (!S_AXIS_ARESETN) 
	  // Synchronous reset (active low)
	    begin
	      S_AXIS_TREADY	<= 0;
	    end  
	  else begin
	    if(convert_start)begin
	       S_AXIS_TREADY	<= axis_tready;
	       end
        else begin
            S_AXIS_TREADY	<= 0;
            end
	  end
	  
	end

	// Control state machine implementation
	always @(posedge S_AXIS_ACLK) 
	begin  
	  if (!S_AXIS_ARESETN) 
	  // Synchronous reset (active low)
	    begin
	      mst_exec_state <= IDLE;
	    end  
	  else
	    case (mst_exec_state)
	      IDLE: 
	        // The sink starts accepting tdata when 
	        // there tvalid is asserted to mark the
	        // presence of valid streaming data 
	          if (S_AXIS_TVALID)
	            begin
	              mst_exec_state <= START_WINDOWS;
	            end
	          else
	            begin
	              mst_exec_state <= IDLE;
	            end
	      START_WINDOWS: 
	        // When the sink has accepted all the streaming input data,
	        // the interface swiches functionality to a streaming master
	        if (convert_done)
	          begin
	            mst_exec_state <= IDLE;
	          end
	        else
	          begin
	            // The sink accepts and stores tdata 
	            // into FIFO
	            mst_exec_state <= START_WINDOWS;
	          end

	    endcase
	end
	// AXI Streaming Sink 
	// 
	// The example design sink is always ready to accept the S_AXIS_TDATA  until
	// the FIFO is not filled with NUMBER_OF_INPUT_WORDS number of input words.
	assign axis_tready = ((mst_exec_state == START_WINDOWS) && (convert_done!=1)&&(Refresh!=1));


	// FIFO write enable generation
	assign convert_start = S_AXIS_TVALID && axis_tready;

	// 滑窗模块
	windows #(
    .Data_width     (C_S_AXIS_TDATA_WIDTH),  
    .PARA_DATA_WIDTH(C_S_AXIS_PARA_DATA_WIDTH),               
    .KERNEL_SIZE    (   KERNEL_SIZE       ),
    .DATA_HORIZONTAL(   DATA_HORIZONTAL   ),
    .DATA_VERTICAL  (   DATA_VERTICAL     ),
    .STRIDE         (   STRIDE            )
	)window_inst(
		.clk  (S_AXIS_ACLK),
		.rstn (S_AXIS_ARESETN),
		.start(convert_start),
		.din  (S_AXIS_TDATA),
		.DATA_horizontal(Data_horizontal),
	    .DATA_vertical(Data_vertical  ),
	    .KERNEL_size(Kernel_size    ),
	    .Window_Stride(Stride         ),
		.refresh( Refresh ),
		.out_valid(OUT_DATA_VALID),
		.last (data_last),
		.done(convert_done),
		.taps (OUT_WINDOW_DATA)
	);
	// Add user logic here

	// User logic ends

	endmodule
