module Control_Unit ( input reset , start , clock  , compare_i , compare_j , compare_a ,
    output reg load_a_i ,
    output reg set_i ,
    output reg update_a_i ,
    output reg increment_temp_j ,
    output reg update_a_j ,
    output reg set_b );

reg [4:0] current_state , next_state ;

// DEFINE STATES
parameter s_idle = 4'b0000 , 
          s_1 = 4'b0001 ,
          s_while1 = 4'b0010 , 
          s_2 = 4'b0011 ,
          s_3 = 4'b0100 ,
          s_while2 = 4'b0101 ,
          s_4 = 4'b0110 ,
          s_5 = 4'b0111 ,
          s_6 = 4'b1000 ;

always @ (posedge clock , negedge reset)
begin
    if (reset == 0) current_state <= s_idle ;
    else current_state <= next_state ;
end

always @ (current_state)
begin 
    load_a_i <= 0 ;
    set_b <= 0 ;
    set_i <= 0 ;
    update_a_i <= 0 ;
    increment_temp_j <= 0 ;
    update_a_j <= 0 ;
    
    case (current_state)
        s_1 : load_a_i <= 1 ;
        s_2 : set_b <= 1 ;
        s_3 : set_i <= 1 ;
        s_4 : update_a_j <= 1 ;
        s_5 : update_a_i <= 1 ;
        s_6 : increment_temp_j <= 1 ;
    endcase
end

// STATE CHANGING 
always @ (current_state , start , compare_i , compare_j , compare_a )
begin
    case (current_state)
        s_idle : if (start == 1) next_state <= s_1 ; else next_state <= s_idle ; 
        s_1 : next_state <= s_while1 ;
        s_while1 : if (compare_i == 1) next_state <= s_3 ; else next_state <= s_2 ; 
        s_2 : next_state <= s_idle ;
        s_3 : next_state <= s_while2 ;
        s_while2 : if (compare_j == 1) begin
                    if (compare_a == 1) next_state <= s_5 ;
                    else next_state <= s_6 ;              
                   end
                   else next_state <= s_4 ; 
                   
        s_4 : next_state <= s_while1 ;
        s_5 : next_state <= s_6 ;
        s_6 : next_state <= s_while2 ;    
    endcase
end

endmodule

