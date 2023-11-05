module regfile_tb();

reg error;
reg [15:0] data_in;
reg [2:0] writenum, readnum;
reg write, clk;
reg [15:0] data_out;

	`define test0 16'b0101001111011101 //random unique I/O definitions to test reading and writing
    `define test1 16'b0101110111011101  
    `define test2 16'b0101001111101111  
    `define test3 16'b0100101101011101 
    `define test4 16'b0101101011001010  
    `define test5 16'b1010110111011101  
    `define test6 16'b0110101010010101  
    `define test7 16'b1010101010010101 


regfile dut(data_in,writenum,write,readnum,clk,data_out);

	task check_write;

    input [15:0] expected_reg0;
    input [15:0] expected_reg1;
    input [15:0] expected_reg2;
    input [15:0] expected_reg3;
    input [15:0] expected_reg4;
    input [15:0] expected_reg5;
    input [15:0] expected_reg6;
    input [15:0] expected_reg7;

	begin

	if (regfile_tb.dut.reg0 !== expected_reg0) begin
        $display("Error ** reg0 is %b, expected is %b",
            regfile_tb.dut.reg0, expected_reg0);
        error = 1'b1;
		end

    if (regfile_tb.dut.reg1 !== expected_reg1) begin
        $display("Error ** reg1 is %b, expected is %b",
            regfile_tb.dut.reg1, expected_reg1);
        error = 1'b1;
		end
    
    if (regfile_tb.dut.reg2 !== expected_reg2) begin
        $display("Error ** reg2 is %b, expected is %b",
            regfile_tb.dut.reg2, expected_reg2);
        error = 1'b1;
		end

    if (regfile_tb.dut.reg3 !== expected_reg3) begin
        $display("Error ** reg3 is %b, expected is %b",
            regfile_tb.dut.reg3, expected_reg3);
        error = 1'b1;
		end

    if (regfile_tb.dut.reg4 !== expected_reg4) begin
        $display("Error ** reg4 is %b, expected is %b",
            regfile_tb.dut.reg4, expected_reg4);
        error = 1'b1;
		end

    if (regfile_tb.dut.reg5 !== expected_reg5) begin
        $display("Error ** reg5 is %b, expected is %b",
            regfile_tb.dut.reg5, expected_reg5);
        error = 1'b1;
		end

    if (regfile_tb.dut.reg6 !== expected_reg6) begin
        $display("Error ** reg6 is %b, expected is %b",
            regfile_tb.dut.reg6, expected_reg6);
        error = 1'b1;
		end

    if (regfile_tb.dut.reg7 !== expected_reg7) begin
        $display("Error ** reg7 is %b, expected is %b",
            regfile_tb.dut.reg7, expected_reg7);
        error = 1'b1;
		end

    end

    endtask

	task check_read;

    input [15:0] expected_data_out;

	begin

    if (regfile_tb.dut.data_out !== expected_data_out) begin
        $display("Error ** data_out is %b, expected is %b",
            regfile_tb.dut.data_out, expected_data_out);
        error = 1'b1;
		end

    end

    endtask

    initial begin
	
	clk=1'b1; #5; 
	forever begin

	clk=1'b0; #5;
	clk=1'b1; #5; //starts the clock for the loading operations

	end

	end
	

	initial begin

	error=1'b0; //initializes error signals
	data_in= `test0; //tries to write all 0's  
    write = 1'b1;   //sets the register to write mode
    writenum = 3'b000; //specifies the register to be written to  
	#10;
	check_write(`test0,{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}});

    data_in= `test1; writenum = 3'b001; #10; //specifies the register to be written to  
	check_write(`test0,`test1,{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}});
    #10;

    data_in= `test2; writenum = 3'b010; #10; //specifies the register to be written to  
	check_write(`test0,`test1,`test2,{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}});
    #10;

    data_in= `test3; writenum = 3'b011; #10; //specifies the register to be written to  
	check_write(`test0,`test1,`test2,`test3,{16{1'bx}},{16{1'bx}},{16{1'bx}},{16{1'bx}});
    #10;

    data_in= `test4; writenum = 3'b100; #10; //specifies the register to be written to  
	check_write(`test0,`test1,`test2,`test3,`test4,{16{1'bx}},{16{1'bx}},{16{1'bx}});
    #10;

    data_in= `test5; writenum = 3'b101; #10; //specifies the register to be written to  
	check_write(`test0,`test1,`test2,`test3,`test4,`test5,{16{1'bx}},{16{1'bx}});
    #10;

    data_in= `test6; writenum = 3'b110; #10; //specifies the register to be written to  
	check_write(`test0,`test1,`test2,`test3,`test4,`test5,`test6,{16{1'bx}});
    #10;

    data_in= `test7; writenum = 3'b111; #10; //specifies the register to be written to  
	check_write(`test0,`test1,`test2,`test3,`test4,`test5,`test6, `test7);
    #10;

    write = 1'b0; //disables from writing and chages to reading

    readnum = 3'b000; //specifies the register to be read 
	#10;
	check_read(`test0); //checks for the unique input that was assigned in the previous part of testing

    readnum = 3'b001; 
	#10;
	check_read(`test1);

    readnum = 3'b010; 
	#10;
	check_read(`test2);

    readnum = 3'b011;
	#10;
	check_read(`test3);

    readnum = 3'b100; 
	#10;
	check_read(`test4);

    readnum = 3'b101; 
	#10;
	check_read(`test5);

    readnum = 3'b110; 
	#10;
	check_read(`test6);

    readnum = 3'b111; 
	#10;
	check_read(`test7);

    $stop;

    end
endmodule