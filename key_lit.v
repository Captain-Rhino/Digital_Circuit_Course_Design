module key_light(
	input clk,
	input rst_n,
	input [2:0] key,
	input IRsig,
	output reg litup,
	output reg [6:0] SEG0,
	output reg [6:0] SEG1,
	output reg [6:0] SEG2,
	output reg [6:0] SEG3,
	output reg [6:0] SEG4,
	output reg [6:0] SEG5
);
reg [2:0]key_value;
reg [2:0]key_flag;
reg [2:0]key_reg;
reg [6:0]pay_total='d0;
reg [6:0]item_total='d0;
//reg [3:0]num_cnt='d0;
reg [3:0]pay_1=4'd5;
reg [3:0]pay_2=4'd1;
reg [3:0]item_1=4'd3;
reg [4:0]pay_total_gw='d0;
reg [4:0]pay_total_sw='d0;
reg [4:0]remain_gw='d0;
reg [4:0]remain_sw='d0;
reg [4:0]item_total_gw='d0;
reg [4:0]item_total_sw='d0;
reg [19:0] delay_cnt;
reg [19:0] delay_cnt1;
reg [19:0] delay_cnt2;
initial SEG0=7'b100_0000;
initial SEG1=7'b100_0000;

always@(IRsig)begin
	if(IRsig)
	litup=1;
	else
	litup=0;
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_reg[0]<=1'b1;
		delay_cnt<=20'b0;
		end
	else begin
		key_reg[0]<=key[0];
		if(key_reg[0] != key[0])
			delay_cnt<=20'b1000_000;
		else begin
			if(delay_cnt>0)
				delay_cnt<=delay_cnt-20'b1;
			else
				delay_cnt<=20'b0;
			end
		end	
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_value[0]<=1'b1;
		key_flag[0]<=1'b0;
	end 
	else begin 
		if(delay_cnt==20'b1)begin
			key_flag[0]<=1'b1;
			key_value[0]<=key[0];
		end
		else begin
			key_flag[0]<=1'b0;
			key_value[0]<=key_value[0];
			end
		end
	end
	
		always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_reg[2]<=1'b1;
		delay_cnt2<=20'b0;
		end
	else begin
		key_reg[2]<=key[2];
		if(key_reg[2] != key[2])
			delay_cnt2<=20'b1000_000;
		else begin
			if(delay_cnt2>0)
				delay_cnt2<=delay_cnt2-20'b1;
			else
				delay_cnt2<=20'b0;
			end
		end	
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_value[2]<=1'b1;
		key_flag[2]<=1'b0;
	end 
	else begin 
		if(delay_cnt2==20'b1)begin
			key_flag[2]<=1'b1;
			key_value[2]<=key[2];
		end
		else begin
			key_flag[2]<=1'b0;
			key_value[2]<=key_value[2];
			end
		end
	end
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n) begin
			pay_total_gw<='d0;
			pay_total_sw<='d0;
		end
	else if(key_flag[0]&(!key_value[0]))			//button down
			pay_total_gw<=pay_total_gw+pay_1;
	else if(key_flag[2]&(!key_value[2]))			//button2 down
			pay_total_gw<=pay_total_gw+pay_2;
	else if(pay_total_gw>'d9&&pay_total_sw<'d10)begin
				pay_total_sw<=pay_total_sw+'d1;
				pay_total_gw<=pay_total_gw-'d10;
				pay_total = 10*pay_total_sw+pay_total_gw;
				end
	//else if(pay_total_sw>'d0&&pay_total_sw<'d10) pay_total = 10*pay_total_sw+pay_total_gw;
				
	//else if(pay_total_sw=='d0&&pay_total_gw<'d10)
				//pay_total <= pay_total_gw;
	else if(pay_total_sw>'d9)begin
				pay_total_gw<='hf;
				pay_total_sw<='hf;
			end
		//end
end
always@(posedge clk or negedge rst_n)begin

end
always @(pay_total_gw)
	begin
		case(pay_total_gw)
		4'd1: SEG4=7'b111_1001;
		4'd2: SEG4=7'b010_0100;
		4'd3: SEG4=7'b011_0000;
		4'd4: SEG4=7'b001_1001;
		4'd5: SEG4=7'b001_0010;
		4'd6: SEG4=7'b000_0010;
		4'd7: SEG4=7'b111_1000;
		4'd8: SEG4=7'b000_0000;
		4'd9: SEG4=7'b001_0000;
		4'd0: SEG4=7'b100_0000;
		4'hf: SEG4=7'b000_1110;
		default:SEG4=7'b011_1111;
		endcase
	end
	always @(pay_total_sw)
	begin
		case(pay_total_sw)
		4'd1: SEG5=7'b111_1001;
		4'd2: SEG5=7'b010_0100;
		4'd3: SEG5=7'b011_0000;
		4'd4: SEG5=7'b001_1001;
		4'd5: SEG5=7'b001_0010;
		4'd6: SEG5=7'b000_0010;
		4'd7: SEG5=7'b111_1000;
		4'd8: SEG5=7'b000_0000;
		4'd9: SEG5=7'b001_0000;
		4'd0: SEG5=7'b100_0000;
		4'hf: SEG5=7'b000_1110;
		default:SEG5=7'b011_1111;
		endcase
	end
	
	
	
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_reg[1]<=1'b1;
		delay_cnt1<=20'b0;
		end
	else begin
		key_reg[1]<=key[1];
		if(key_reg[1] != key[1])
			delay_cnt1<=20'b1000_000;
		else begin
			if(delay_cnt1>0)
				delay_cnt1<=delay_cnt1-20'b1;
			else
				delay_cnt1<=20'b0;
			end
		end	
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		key_value[1]<=1'b1;
		key_flag[1]<=1'b0;
	end 
	else begin 
		if(delay_cnt1==20'b1)begin
			key_flag[1]<=1'b1;
			key_value[1]<=key[1];
		end
		else begin
			key_flag[1]<=1'b0;
			key_value[1]<=key_value[1];
			end
		end
	end
	
	always@(posedge clk or negedge rst_n)begin
	if(!rst_n) begin
			item_total_gw<='d0;
			item_total_sw<='d0;
			remain_gw<='d0;
			remain_sw<='d0;
		end
	else if(key_flag[1]&(!key_value[1]))begin				//button down
			item_total_gw<=item_total_gw+item_1;
		end
	else if(item_total_gw>'d9&&item_total_sw<'d10)begin
				item_total_sw<=item_total_sw+'d1;
				item_total_gw<=item_total_gw-'d10;
				item_total = 10*item_total_sw+item_total_gw;
			end
	//else if(item_total_sw>'d0&&item_total_sw<'d10) item_total = 10*item_total_sw+item_total_gw;
	//else if(item_total_sw=='d0&&item_total_gw<'d10)
				//item_total <= item_total_gw;
	else if(pay_total_gw>=item_total_gw&&pay_total_sw>=item_total_sw)begin
				remain_gw<=pay_total_gw-item_total_gw;
				remain_sw<=pay_total_sw-item_total_sw;
			end
	else if(item_total_gw>pay_total_gw&&pay_total_sw>=item_total_sw+1)begin
				remain_gw<=pay_total_gw+'d10-item_total_gw;
				remain_sw<=pay_total_sw-'d1-item_total_sw;
			end
			//debug
	else if(item_total_sw==pay_total_sw&&item_total_gw>pay_total_gw||item_total_sw>pay_total_sw)begin
				remain_gw<='hf;
				remain_sw<='hf;
			end
	else if(item_total_sw>'d9)begin
				item_total_gw<='hf;
				item_total_sw<='hf;
			end
		//end
end

always@(posedge clk or negedge rst_n)begin

end
always @(item_total_gw)
	begin
		case(item_total_gw)
		4'd1: SEG2=7'b111_1001;
		4'd2: SEG2=7'b010_0100;
		4'd3: SEG2=7'b011_0000;
		4'd4: SEG2=7'b001_1001;
		4'd5: SEG2=7'b001_0010;
		4'd6: SEG2=7'b000_0010;
		4'd7: SEG2=7'b111_1000;
		4'd8: SEG2=7'b000_0000;
		4'd9: SEG2=7'b001_0000;
		4'd0: SEG2=7'b100_0000;
		4'hf: SEG2=7'b000_1110;
		default:SEG2=7'b011_1111;
		endcase
	end
	always @(item_total_sw)
	begin
		case(item_total_sw)
		4'd1: SEG3=7'b111_1001;
		4'd2: SEG3=7'b010_0100;
		4'd3: SEG3=7'b011_0000;
		4'd4: SEG3=7'b001_1001;
		4'd5: SEG3=7'b001_0010;
		4'd6: SEG3=7'b000_0010;
		4'd7: SEG3=7'b111_1000;
		4'd8: SEG3=7'b000_0000;
		4'd9: SEG3=7'b001_0000;
		4'd0: SEG3=7'b100_0000;
		4'hf: SEG3=7'b000_1110;
		default:SEG3=7'b011_1111;
		endcase
	end
	always @(remain_gw)
	begin
		case(remain_gw)
		4'd1: SEG0=7'b111_1001;
		4'd2: SEG0=7'b010_0100;
		4'd3: SEG0=7'b011_0000;
		4'd4: SEG0=7'b001_1001;
		4'd5: SEG0=7'b001_0010;
		4'd6: SEG0=7'b000_0010;
		4'd7: SEG0=7'b111_1000;
		4'd8: SEG0=7'b000_0000;
		4'd9: SEG0=7'b001_0000;
		4'd0: SEG0=7'b100_0000;
		4'hf: SEG0=7'b000_1110;
		default:SEG0=7'b011_1111;
		endcase
	end
	always @(remain_sw)
	begin
		case(remain_sw)
		4'd1: SEG1=7'b111_1001;
		4'd2: SEG1=7'b010_0100;
		4'd3: SEG1=7'b011_0000;
		4'd4: SEG1=7'b001_1001;
		4'd5: SEG1=7'b001_0010;
		4'd6: SEG1=7'b000_0010;
		4'd7: SEG1=7'b111_1000;
		4'd8: SEG1=7'b000_0000;
		4'd9: SEG1=7'b001_0000;
		4'd0: SEG1=7'b100_0000;
		4'hf: SEG1=7'b000_1110;
		default:SEG1=7'b011_1111;
		endcase
	end
endmodule