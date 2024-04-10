`timescale 1ns / 1ps

module Test_Bed();

reg clock ; reg reset ; reg start ;
reg [15:0]  a0 , a1 , a2 , a3 , a4 , a5 ;
wire [15:0] b0 , b1 , b2 , b3 , b4 , b5 ;
wire valid ;

always #1.5 clock =~ clock ;
initial
begin
    clock = 0 ; 
    reset = 0 ; 
    start = 0 ;
    #50 reset = 1 ;
    #50 start = 1 ;
end

initial
begin
    a0 <= 25 ; 
    a1 <= 10 ;
    a2 <= 2 ;
    a3 <= 110 ;
    a4 <= 240 ;
    a5 <= 85 ;

end

initial #500000 $finish ;

Selection_Sort SS(
.reset(reset) , .start(start) , .clock(clock) , 
.a0(a0) , .a1(a1) , .a2(a2) , .a3(a3) , .a4(a4) , .a5(a5) , 
.b0(b0) , .b1(b1) , .b2(b2) , .b3(b3) , .b4(b4) , .b5(b5) ,
.valid(valid)
);

endmodule


