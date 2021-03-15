module comp_mul(rst, clk, a_r, a_i, b_r, b_i, i_en, o_r, o_i);
	input		rst, clk;
	input signed	[7:0]	a_r, a_i;
	input signed	[7:0]	b_r, b_i;
	input		i_en;
	output reg signed	[16:0]	o_r, o_i;

	parameter	SA = 2'b00, SB=2'b01, SC=2'b10, SD=2'b11;
	reg		state, next;
	wire		ab_sel, sub, o_r_en, o_i_en;
	wire signed	[7:0]   a_op, b_op;
	wire signed	[15:0] pp1, pp2;
	wire signed	[16:0] sum;

	assign a_op = (ab_sel == 2'b00 || ab_sel == 2'b01) ? a_r : a_i;
	assign b_op = (ab_sel == 2'b00 || ab_sel == 2'b10) ? b_r : b_i;

	assign sum = (sub == 2'b11 || sub == 2'b00) ? pp1+pp2 : pp1-pp2;

	assign ab_sel = (state == SA)? 2'b00 : (state == SB)? 2'b01 : (state == SC)? 2'b10 : 2'b11;
	assign sub = (state == SA)? 2'b11 : (state == SB)? 2'b10 : (state == SC)? 2'b01 : 2'b00;
	assign o_r_en = (state == SA)? 2'b11 : (state == SB)? 2'b10 : (state == SC)? 2'b01 : 2'b00;
	assign o_i_en = (state == SA)? 2'b00 : (state == SB)? 2'b01 : (state == SC)? 2'b10 : 2'b11;

always @(ab_sel or a_op or b_op) begin
	if (ab_sel == 2'b00 || ab_sel == 2'b01) begin
		pp1 = (a_op * b_op)
	end
	else begin
		pp2 = (a_op * b_op);
	end
end

always@(state or i_en) begin
	case(state)
		SA : if(i_en == 1'b1) next = SD;
				else next = SA;
		SB : next = SA;
		SC : next = SB;
		SD : next = SC;
	endcase
end

always@(posedge clk or posedge rst) begin
	if(rst == 1'b1) begin
		state <= SA;
		o_r <= ‘b0;
		o_i <= ‘b0;
	end else begin
		state <= next;
		if(o_r_en == 2'b00) o_r <= o_r + sum;
		if(o_r_en == 2'b11) o_r <= sum;
		if(o_i_en == 2’b10) o_i <= sum;
		if(o_i_en == 2’b01) o_i <= o_i + sum;
	end 
end

endmodule