module filter (rst, clk, in, in_en, out, out_en);
    input   [7:0] in, cur_in;
    input rst;
    input clk;
    input in_en;
    output  reg  [15:0] total;
    output  reg  [15:0] out;
    output  reg out_en;

    reg isChange;
    reg [7:0] f_1, f_2, f_3, f_temp;
    parameter	stop = 1'b0, go = 1'b1;
    reg state, next;

    assign out_en = (state == stop) ? 1'b0; : 1'b1;
    assign isChange = (cur_in == in) ? 1'b0; : 1'b1;

initial begin
    state = stop;
    isChange = 0;
    f_1 = 0;
    f_2 = 0;
    f_3 = 0;
end

always @(posedge clk) begin
    cur_in <= in;
end

always @(*) begin
    if(isChange == 1'b1) begin
        f_3 = f_2;
        f_2 = f_1;
        f_1 = in;
    end
end

always @(posedge clk) begin
    total <= f_1 * f_2 * f_3;
end

always@(state or in_en) begin
	case(state)
        stop : if(in_en == 1'b1) next = go;
				else next = stop;
        go : next = stop;
	endcase
end

always@(posedge clk or posedge rst) begin
    if(rst == 1'b1) begin
        state = stop;
        f_1 = 0;
        f_2 = 0;
        f_3 = 0;
    end
    else begin
	    state <= next;
	    if(out_en == 1’b1) out <= total;
    end 
end

endmodule