module timer_1s (
	input wire clk, reset,
	output wire rollover
);

reg [27:0] i;
reg roll;

assign rollover = roll;

initial begin
	roll = 1'b0;
	i = 28'h0000000;
end

always @ (*) begin
	if (i == 28'h2faf080) begin //28'h2faf080 is 50,000,000 in decimal
		roll = 1'b1;
	end 
	else begin
		roll = 1'b0;
	end
end

always @ (posedge clk) begin
	case (reset)
		1'b0: i <= (i < 28'h2faf080) ? (i + 28'h0000001) : 28'h0000000;
		1'b1: i <= 28'h0000000;
	endcase
end

endmodule