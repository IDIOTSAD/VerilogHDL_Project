module test;
	reg rst;
	reg clk;
	reg [7:0] in;
	wire [16:0] out;

initial begin
	rst = 1'b1;	
	clk = 1'b0;
	in_en = 1'b0;
	#3;
	rst = 1'b0;
	in_en = 1'b1;
	in = 8'b00000010;
	#4;
	in = 8'b00000100;
	#4;
	in = 8'b00001000;
	#1000;
	$finish;
end

initial begin
	$vcdplusfile("test_out.vcd");
	$vcdpluson(0,test);
end

always begin
	#1;
	clk = ~clk;
end

filter dut(rst, clk, in, in_en, out, out_en);

endmodule
