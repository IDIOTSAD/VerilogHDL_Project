module test;
	reg rst;
	reg clk;
	reg [7:0] a_r;
	reg [7:0] a_i;
	reg [7:0] b_r;
	reg [7:0] b_i;
	reg i_en;
	wire [16:0] o_r;
	wire [16:0] o_i;

initial begin
	rst = 1'b1;	
	clk = 1'b0;
	a_r = 8'b00000011;
	b_r = 8'b00000101;
	a_i = 8'b00000010;
	b_i = 8'b00000001;
	i_en = 1'b1;
	#4;
	rst = 1'b0;
	i_en = 1'b1;
	#32;
	rst = 1'b1;
	#4
	rst = 1'b0;
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

comp_mul dut(rst, clk, a_r, a_i, b_r, b_i, i_en, o_r, o_i);

endmodule
