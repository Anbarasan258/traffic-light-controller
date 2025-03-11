module traffic_tb();
reg clock,reset;
wire [2:0] north_light,south_light,east_light,west_light;

traffic_rtl dut(.clock(clock),.reset(reset),.north_light(north_light),.south_light(south_light),.east_light(east_light),.west_light(west_light));

always
begin
clock=1'b0;
forever #10 clock=~clock;

end

task reset1();
begin
reset=1'b1;
#20;
reset=1'b0;
end
endtask

initial
begin
reset1();
end
endmodule
