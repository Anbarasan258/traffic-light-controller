module traffic_rtl(clock,reset,north_light,south_light,east_light,west_light);
input clock,reset;
output reg [2:0] north_light,south_light,east_light,west_light; //output of each direction[GREEN SIGNAL]
reg [2:0] state;
reg [3:0] count;
parameter [2:0] north=3'b000,north_yellow=3'b001,south=3'b010,south_yellow=3'b011,east=3'b100,east_yellow=3'b101,west=3'b110,west_yellow=3'b111;
// above parameter is the is the state's that are assigned to the numbers [binary number are assigned according to the transition]


//state transition and count logic
always@(posedge clock)
begin
    if(reset)   
       begin
            state=north;
            count=4'b0000;
       end
     else
        begin
             case (state)
               north:
                   begin
                       if(count==4'b1111)  //for green signal the time is 15 seconds
                         begin
                         state=north_yellow;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=north;
                         count=count+1;
                         end
                   end 
                north_yellow: 
                   begin
                       if(count==4'b0010)  //for yellow signal the time is 2 seconds
                         begin
                         state=south;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=north_yellow;
                         count=count+1;
                         end
                   end 
                south:
                    begin
                       if(count==4'b1111)
                         begin
                         state=south_yellow;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=south;
                         count=count+1;
                         end
                   end
                 south_yellow:
                        begin
                       if(count==4'b0010)
                         begin
                         state=east;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=south_yellow;
                         count=count+1;
                         end
                   end 
                 east:
                    begin
                       if(count==4'b1111)
                         begin
                         state=east_yellow;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=east;
                         count=count+1;
                         end
                   end 
                 east_yellow:
                     begin
                       if(count==4'b0010)
                         begin
                         state=west;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=east_yellow;
                         count=count+1;
                         end
                   end  
                 west:
                   begin
                       if(count==4'b1111)
                         begin
                         state=west_yellow;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=west;
                         count=count+1;
                         end
                   end 
                west_yellow:
                   begin
                       if(count==4'b0010)
                         begin
                         state=north;
                         count=4'b0000;
                         end
                       else
                         begin
                         state=west_yellow;
                         count=count+1;
                         end
                   end 
             endcase
        end
end 
//green=001
//yellow=010
//red=100
//output logic
always@(posedge clock)
begin
    case (state)
            north:
               begin
                  north_light=3'b001; //green
                  south_light=3'b100; //red
                  east_light=3'b100; //red
                  west_light=3'b100; //red
               end
             north_yellow:
               begin
                  north_light=3'b010; //yellow
                  south_light=3'b100; //red
                  east_light=3'b100;  //red
                  west_light=3'b100;  //red
               end 
              south:
                begin
                  north_light=3'b100; //red
                  south_light=3'b001; //green
                  east_light=3'b100;  //red
                  west_light=3'b100;  //red
               end
              south_yellow:
                begin
                  north_light=3'b100; //red
                  south_light=3'b010; //yellow
                  east_light=3'b100;  //red
                  west_light=3'b100;  //red
               end
              east:
                begin
                  north_light=3'b100; //red
                  south_light=3'b100; //red
                  east_light=3'b001;  //green
                  west_light=3'b100;  //red
               end
              east_yellow:
                begin
                  north_light=3'b100; //red 
                  south_light=3'b100; //red
                  east_light=3'b010;  //yellow
                  west_light=3'b100;  //red
               end
             west:
               begin
                  north_light=3'b100; //red
                  south_light=3'b100; //red
                  east_light=3'b100;  //red
                  west_light=3'b001;  //green
               end
             west_yellow:
                begin
                  north_light=3'b100; //red 
                  south_light=3'b100; //red
                  east_light=3'b100;  //red
                  west_light=3'b010;  //yellow
               end
        endcase
end 
endmodule
