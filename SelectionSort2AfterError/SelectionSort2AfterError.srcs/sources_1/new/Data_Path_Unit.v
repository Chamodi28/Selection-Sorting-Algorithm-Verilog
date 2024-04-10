module Data_Path_Unit (
    output reg compare_i , reg compare_j , reg compare_a ,
    output reg [15:0] b0 , b1 , b2 , b3 , b4 , b5 , 
    output reg valid ,
    input clock , reset , load_a_i ,set_i , update_a_i , increment_temp_j , update_a_j , set_b ,
    input wire [15:0]  a0 , a1 , a2 , a3 , a4 , a5 ) ;

integer temp_i , temp_j , temp_index ;
reg [15:0] hold_a[1:6] ;
reg [15:0] temp_min ;
 
// GENERATE COMPARE SIGNALS
always @ (temp_i , temp_j )
begin
    if (temp_i < 7) compare_i <= 1 ; else compare_i <= 0 ;
    if (temp_j < 7) compare_j <= 1 ; else compare_j <= 0 ;
    if (hold_a[temp_i] >= hold_a[temp_j]) compare_a <= 1 ; else compare_a <= 0 ; 
end

always @ (posedge clock , negedge reset)
begin
    if (reset) begin
        if (load_a_i) begin
            temp_i = 1 ;
            temp_min = 1 ; 
            hold_a[1] <= a0 ;
            hold_a[2] <= a1 ;
            hold_a[3] <= a2 ;
            hold_a[4] <= a3 ;
            hold_a[5] <= a4 ;
            hold_a[6] <= a5 ;
        end
        
        if (set_i) begin
            temp_j = temp_i ; 
        end
        
        if (update_a_i) begin
            temp_min <= hold_a[temp_j] ;
            temp_index <= temp_j ;
        end
        
        if (increment_temp_j) temp_j <= temp_j +1 ;
        
        if (update_a_j) begin
            hold_a[temp_index] <= hold_a[temp_i] ;
            hold_a[temp_i] <= temp_min ;
            temp_i <= temp_i +1 ;
        end
        
        if (set_b)begin
            b0 <= hold_a[1] ;
            b1 <= hold_a[2] ;
            b2 <= hold_a[3] ;
            b3 <= hold_a[4] ;
            b4 <= hold_a[5] ;
            b5 <= hold_a[6] ;
            valid <= 1 ;
            
        end
    end
    
    else begin
        temp_j = 0 ;
        temp_i = 0 ;
        temp_index = 0 ;
        valid <= 0 ;
        b0 <= 0 ;
        b1 <= 0 ;
        b2 <= 0 ;
        b3 <= 0 ;
        b4 <= 0 ;
        b5 <= 0 ;
    end    
end
endmodule

