module fb(i, o, kind_shift, s_count);
    input [7:0] i;
    output reg [7:0] o;
    reg [15:0] temp;
    reg [7:0] c;
    reg [7:0] s;
    input [2:0] kind_shift;
    input [3:0] s_count;

always @(i or kind_shift or s or s_count) begin
    case(kind_shift)
        3'b000: begin
            c = i[7:0];
            s = 8'b0;
            temp = {s, c};
            case(s_count)
		        4'b0000: temp = temp;
		        4'b0001: temp = {temp[14:0], temp[15]};
		        4'b0010: temp = {temp[13:0], temp[15:14]};
		        4'b0011: temp = {temp[12:0], temp[15:13]};
		        4'b0100: temp = {temp[11:0], temp[15:12]};
		        4'b0101: temp = {temp[10:0], temp[15:11]};
		        4'b0110: temp = {temp[9:0], temp[15:10]};
		        4'b0111: temp = {temp[8:0], temp[15:9]};
                default: temp = temp;
	        endcase
            o = temp[7:0];
        end
        3'b001: begin
            c = 8'b0;
            s = i[7:0];
            temp = {s, c};
            case(4'b1000-s_count)
		        4'b0000: temp = temp;
		        4'b0001: temp = {temp[14:0], temp[15]};
		        4'b0010: temp = {temp[13:0], temp[15:14]};
		        4'b0011: temp = {temp[12:0], temp[15:13]};
		        4'b0100: temp = {temp[11:0], temp[15:12]};
		        4'b0101: temp = {temp[10:0], temp[15:11]};
		        4'b0110: temp = {temp[9:0], temp[15:10]};
		        4'b0111: temp = {temp[8:0], temp[15:9]};
                default: temp = temp;
	        endcase
            o = temp[7:0];
        end
        3'b010: begin
            c = i[7:0];
            s = {8{i[7]}};
            temp = {s, c};
            case(s_count)
		        4'b0000: temp = temp;
		        4'b0001: temp = {temp[14:0], temp[15]};
		        4'b0010: temp = {temp[13:0], temp[15:14]};
		        4'b0011: temp = {temp[12:0], temp[15:13]};
		        4'b0100: temp = {temp[11:0], temp[15:12]};
		        4'b0101: temp = {temp[10:0], temp[15:11]};
		        4'b0110: temp = {temp[9:0], temp[15:10]};
		        4'b0111: temp = {temp[8:0], temp[15:9]};
                default: temp = temp;
	        endcase
            o = temp[7:0];
        end
        3'b011: begin
            c = 8'b0;
            s = i[7:0];
            temp = {s, c};
            case(4'b1000-s_count)
		        4'b0000: temp = temp;
		        4'b0001: temp = {temp[14:0], temp[15]};
		        4'b0010: temp = {temp[13:0], temp[15:14]};
		        4'b0011: temp = {temp[12:0], temp[15:13]};
		        4'b0100: temp = {temp[11:0], temp[15:12]};
		        4'b0101: temp = {temp[10:0], temp[15:11]};
		        4'b0110: temp = {temp[9:0], temp[15:10]};
		        4'b0111: temp = {temp[8:0], temp[15:9]};
                default: temp = temp;
	        endcase
            o = temp[7:0];
        end
        3'b100: begin
            c = i[7:0];
            s = i[7:0];
            temp = {s, c};
            case(s_count)
		        4'b0000: temp = temp;
		        4'b0001: temp = {temp[14:0], temp[15]};
		        4'b0010: temp = {temp[13:0], temp[15:14]};
		        4'b0011: temp = {temp[12:0], temp[15:13]};
		        4'b0100: temp = {temp[11:0], temp[15:12]};
		        4'b0101: temp = {temp[10:0], temp[15:11]};
		        4'b0110: temp = {temp[9:0], temp[15:10]};
		        4'b0111: temp = {temp[8:0], temp[15:9]};
                default: temp = temp;
	        endcase
            o = temp[7:0];
        end
        3'b101: begin
            c = i[7:0];
            s = i[7:0];
            temp = {s, c};
            case(4'b1000-s_count)
		        4'b0000: temp = temp;
		        4'b0001: temp = {temp[14:0], temp[15]};
		        4'b0010: temp = {temp[13:0], temp[15:14]};
		        4'b0011: temp = {temp[12:0], temp[15:13]};
		        4'b0100: temp = {temp[11:0], temp[15:12]};
		        4'b0101: temp = {temp[10:0], temp[15:11]};
		        4'b0110: temp = {temp[9:0], temp[15:10]};
		        4'b0111: temp = {temp[8:0], temp[15:9]};
                default: temp = temp;
	        endcase
            o = temp[7:0];
        end
        default: o = c;
    endcase
end
endmodule