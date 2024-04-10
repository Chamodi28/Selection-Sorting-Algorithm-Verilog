`timescale 1ns / 1ps

module Selection_Sort(
input clock , reset , start ,
input [15:0]  a0 , a1 , a2 , a3 , a4 , a5 ,
output [15:0] b0 , b1 , b2 , b3 , b4 , b5 , 
output valid     );

wire compare_i ,  compare_j ,  compare_a ,
load_a_i , set_i , update_a_i , increment_temp_j , update_a_j , set_b ;


Control_Unit CU ( .reset(reset) , .start(start) , .clock(clock) , .compare_i(compare_i) , 
.compare_j(compare_j) , .compare_a(compare_a) , .load_a_i(load_a_i) , .set_i(set_i) , 
.update_a_i(update_a_i) , .increment_temp_j(increment_temp_j) , .update_a_j(update_a_j) ,
.set_b(set_b)
) ;


Data_Path_Unit DU ( 
.reset(reset) , .clock(clock) , .b0(b0) , .b1(b1) , .b2(b2) , .b3(b3) , .b4(b4) , .b5(b5) ,
.compare_i(compare_i) , .compare_j(compare_j) , .compare_a(compare_a) , .load_a_i(load_a_i) , .set_i(set_i) , 
.update_a_i(update_a_i) , .increment_temp_j(increment_temp_j) , .update_a_j(update_a_j) ,
.set_b(set_b) , .a0(a0) , .a1(a1) , .a2(a2) , .a3(a3) , .a4(a4) , .a5(a5)      
) ;

endmodule
