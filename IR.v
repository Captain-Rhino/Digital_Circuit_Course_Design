module IR(clock, clr_n,IR,Sound,led);
input clock,clr_n;
input IR;
output reg led;
output reg[4:0] Sound;

reg [27:0]counter_1;
reg flag;
initial 
begin
counter_1=28'd0;
Sound=5'b1_1111;
end
always@(IR)begin
if(IR)begin
led<=1;
flag<=1;
end
else
led<=0;
end
//always@(posedge clock or negedge clr_n)
//begin
//	if(!clr_n)
//	;
//	else
//	begin
//		if(counter_distance<22'd300_0000)
//			counter_distance<=counter_distance+1'b1;
//		else
//			counter_distance<=22'd0;
//		end
//end

//always@(counter_distance)
//begin
//	if(counter_distance<22'd500)
//		trig<='b1;
//	else
//		trig<='b0;
//end

//always@(posedge clock)
//begin
//	if(echo=='b1)
//		counter_echo<=counter_echo+1;
//	else if(counter_distance==22'd300_0000)
//	begin
//		counter_echo<=0;
//	end
//	else if(counter_echo>0)
//			if(counter_echo*34<3000000)
//				begin
//				out_dis<='b1;
//				flag<=1;
//				end
//	else
//		out_dis<='b0;
//end
		


always@(posedge clock or negedge clr_n)
begin
if(~clr_n)
counter_1<='d0;
else if(flag)
	if(counter_1<28'd2_5000_0000)
		counter_1<=counter_1+'b1;
	else
		counter_1<=28'd0;
else
	counter_1<='d0;
end

always@(posedge clock or negedge clr_n)
begin
if(~clr_n)
begin Sound<=5'b1_1111;end
else if(counter_1>28'd0 && counter_1<28'd2_5000_0000)begin
Sound<=5'b0_1111;end
else
Sound<=5'b1_1111;

end

endmodule
