module top;
reg	[7:0]	i;
reg [2:0] kind_shift;
reg [3:0] s_count;
wire [7:0]	o;

fb dut(i, o, kind_shift, s_count);

//------여기서 부터 아래 선까지는 waveform을 보기위한 파일을 만드는 코드이다.---- 
initial begin
      $dumpfile("test_out.vcd");
      $dumpvars(-1,dut);  // tb는 위에 nand4_if tb(a,y)의 tb를 말한다. 
      $monitor("%b",o);
end
//------------------------------------------------------------------------------

initial begin
	i = 8'b00000010;
    kind_shift = 3'b000;
    s_count = 4'b0001;
	#100;
	i = 8'b00000010;
    kind_shift = 3'b001;
    s_count = 4'b0001;
	#100;

	i = 8'b00000010;
    kind_shift = 3'b010;
    s_count = 4'b0001;
	#100;
	i = 8'b00000010;
    kind_shift = 3'b011;
    s_count = 4'b0001;
	#100;
	i = 8'b00000010;
    kind_shift = 3'b100;
    s_count = 4'b0001;
	#100;
	i = 8'b00000010;
    kind_shift = 3'b101;
    s_count = 4'b0001;
	#100;

    
    i = 8'b11111110;
    kind_shift = 3'b000;
    s_count = 1'b1;
	#100;
	i = 8'b11111110;
    kind_shift = 3'b001;
    s_count = 1'b1;
	#100;
	i = 8'b11111110;
    kind_shift = 3'b010;
    s_count = 1'b1;
	#100;
	i = 8'b11111110;
    kind_shift = 3'b011;
    s_count = 1'b1;
	#100;
	i = 8'b11111110;
    kind_shift = 3'b100;
    s_count = 1'b1;
	#100;
	i = 8'b11111110;
    kind_shift = 3'b101;
    s_count = 1'b1;
	#100;
    
end
endmodule