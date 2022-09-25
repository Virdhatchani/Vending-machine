`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2022 20:02:16
// Design Name: 
// Module Name: Software_Vending
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Software_Vending(input clk, input rst,input[1:0] prod_name,input [1:0]in, // 01 = 5 rs, 10 = 10 rs
output reg[1:0] out, output reg[4:0] change,output reg[1:0] prod_count1,output reg[1:0] prod_count2 
);
parameter s0 = 2'b00; //0
parameter s1 = 2'b01; //5
parameter s2 = 2'b10; //10
reg[1:0] c_state,n_state;
reg[4:0] total;

always@ (clk) //change only during clock
    begin
        if(rst == 1) //reset stage= system reboot
            begin
                c_state = 0;
                n_state = 0;
                change = 5'b00000;
                prod_count1=2'b10; //assigning product stock*********************
                prod_count2=2'b10; //assigning product stock*********************
                total=5'b00000;
            end
        else
            c_state = n_state;
        //prodct logic starts
        if(in==0)
            total=total+5'b00000;
        else if(in==2'b01)
            total=total+5'b00101;
        else if(in==2'b10)
            total=total+5'b01010;
        
        if(prod_name==2'b01) // for product 1
            begin
            if(prod_count1>0) //prod 1 = 15Rs
                begin
                case(c_state)
                 s0: //state 0 : 0 rs
                   if(in == 0) //0+0 = reset
                        begin
                            n_state = s0;
                            out = 0;
                            change = 5'b00000;
                            total=5'b00000;               
                        end
                    else if(in == 2'b01) //0+5
                        begin
                            n_state = s1;
                            out = 0;
                            change = 5'b00000;
                        end
                    else if(in == 2'b10) //0+10
                        begin
                            n_state = s2;
                            out = 0;
                            change = 5'b00000;
                        end
                s1: //state 1 : 5 rs
                    if(in == 0) //5+0 = reset
                        begin
                            n_state = s0;
                            out = 0;
                            total=5'b00000;
                            change = 5'b00101; //change returned 5 rs
                        end
                    else if(in == 2'b01) //5+5 =10
                        begin
                            n_state = s2;
                            out = 0;
                            change = 5'b00000;
                        end
                    else if(in == 2'b10) //5+10=total done
                        begin
                            n_state = s0;
                            out = 2'b01;
                            prod_count1 = prod_count1 - 1;
                            total=5'b00000;
                            change = 5'b00000;
                        end
                s2: //state 2 : 10 rs
                    if(in == 0) //10+0=reset
                        begin
                            n_state = s0;
                            out = 0;
                            change = 5'b01010;
                            total=5'b00000;
                        end
                    else if(in == 2'b01) //10+5 =15==>reset
                        begin
                            n_state = s0;
                            out =2'b01;
                            total=5'b00000;
                            prod_count1 = prod_count1-1;
                            change = 5'b00000;
                        end
                    else if(in == 2'b10) //10+10
                        begin
                            n_state = s0;
                            out = 2'b01;
                            total=5'b00000;
                            prod_count1 = prod_count1-1;
                            change = 5'b00101; //change returned 5 rs and 1 bottle
                        end
            endcase
            end
            else //prod_count=0;
                begin
                    c_state = 0;
                    n_state = 0;
                    out = 0;
                    //if prod not available,whatever is input,will be given back
                    if(in==0)
                        change=5'b00000;
                    else if(in==2'b01)
                        change=5'b00101;
                    else if(in==2'b10)
                        change=5'b01010;
                    prod_count1=2'b00;
                    total=5'b00000;
                end
            end
        else if(prod_name==2'b10) // for product 2  
            begin
            if(prod_count2>0) //prod 1 = 15Rs
                begin
                case(c_state)
                s0: //state 0 : 0 rs
                    if(in == 0) 
                        begin
                            n_state = s0;
                            out = 0;
                            change = 5'b00000;
                            total=5'b00000;                                               
                        end
                    else if(in==2'b01)
                        begin
                            n_state = s1;
                            out = 0;
                            change = 5'b00000;
                        end
                    else if(in==2'b10)
                        begin
                            n_state = s2;
                            out = 0;
                            change = 5'b00000;
                        end
                s1: //state 1 : 5 rs
                    if(in==0)
                        begin
                            n_state = s0;
                            out = 0;
                            change = total;
                            total=5'b00000;                            
                        end
                    else if(total>=5'b10100)
                        begin
                            n_state=s0;
                            out=2'b10;
                            prod_count2 = prod_count2-1;
                            change = total-5'b10100; //total-20Rs
                            total=5'b00000;
                        end 
                    else if((total<5'b10100)&&(in==2'b01))
                        begin
                            n_state=s2;
                            out=0;
                            change=5'b00000;
                        end 
                    else if((total<5'b10100)&&(in==2'b10))   
                        begin
                            n_state=s1;
                            out=0;
                            change=5'b00000;
                        end
                s2:
                    if(in==0)
                        begin
                            n_state=s0;
                            out=0;
                            change = total;
                        end
                    else if(total<5'b10100)
                        begin
                            n_state=s1;
                            out=0;
                            change=5'b00000;
                        end
                    else if(total>=5'b10100)
                        begin
                            n_state=s0;
                            out=2'b10;
                            prod_count2 = prod_count2-1;
                            change = total-5'b10100; //total-20Rs
                            total=5'b00000;
                        end                                                                                         
                endcase
                end
                else //prod_count=0;
                    begin
                        c_state = 0;
                        n_state = 0;
                        out = 0;
                        //if prod not available,whatever is input,will be given back
                        if(in==0)
                            change=5'b00000;
                        else if(in==2'b01)
                            change=5'b00101;
                        else if(in==2'b10)
                            change=5'b01010;
                        prod_count2=2'b00;
                        total=5'b00000;
                    end
                   
            end           
    end                  
endmodule

