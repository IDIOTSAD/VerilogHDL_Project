module comp_mul(rst, clk, a_r, a_i, b_r, b_i, i_en, o_r, o_i);
	input		rst, clk;
	input signed	[7:0]	a_r, a_i;
	input signed	[7:0]	b_r, b_i;
	input		i_en;
	output reg signed	[16:0]	o_r, o_i;

	parameter	SA = 2'b00, SB=2'b01, SC=2'b10, SD=2'b11;
	reg	[1:0]	state, next;
	wire	[1:0]	ab_sel, sub, o_r_en, o_i_en;
	wire signed	[7:0]   a_op, b_op;
	reg signed	[15:0] pp1, pp2;
	reg signed	[16:0] sum;

	assign a_op = (ab_sel == 2'b00 || ab_sel == 2'b01) ? a_r : a_i;
	assign b_op = (ab_sel == 2'b00 || ab_sel == 2'b10) ? b_r : b_i;

	assign ab_sel = (state == SA)? 2'b00 : (state == SB)? 2'b01 : (state == SC)? 2'b10 : 2'b11;
	assign sub = (state == SA)? 2'b11 : (state == SB)? 2'b10 : (state == SC)? 2'b01 : 2'b00;
	assign o_r_en = (state == SA)? 2'b11 : (state == SB)? 2'b10 : (state == SC)? 2'b01 : 2'b00;
	assign o_i_en = (state == SA)? 2'b00 : (state == SB)? 2'b01 : (state == SC)? 2'b10 : 2'b11;

always @(posedge clk) begin
	if (ab_sel == 2'b00) begin	//SA
		pp1 <= (a_op * b_op);
	end
	else if (ab_sel == 2'b11) begin	//SD
		pp2 <= (a_op * b_op);
	end
	else if (ab_sel == 2'b10) begin	//SC
		pp1 <= (a_op * b_op);
	end 
	else begin
		pp2 <= (a_op * b_op);	//SB
	end
end

always @(pp1 or pp2) begin
	sum <= pp1 + pp2;
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
		pp1 <= 0;
		pp2 <= 0;
		o_r <= 16'b0;
		o_i <= 16'b0;
	end else begin
		state <= next;
		if(o_r_en == 2'b01) o_r <= sum;
		if(o_i_en == 2'b00) o_i <= sum;
	end 
end

endmodule
