module test;
    reg rst;
    reg clk;
    reg [7:0] a_r;
    reg [7:0] a_i;
    reg [7:0] b_r;
    reg [7:0] b_i;
    reg i_en;
    reg [16:0] o_r;
    reg [16:0] o_i;

initial begin
    clk = 1'b0;
    a_r = 8'00001010;
    b_r = 8'00000101;
    a_i = 8'00000010;
    b_i = 8'00000001;
    i_en = 1'b0;
    #4;
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

initial begin
    #1;
    clk = ~clk;
end

comp_mul dut(rst, clk, a_r, a_i, b_r, b_i, i_en, o_r, o_i);

endmodule