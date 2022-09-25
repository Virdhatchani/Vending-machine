`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2022 20:02:16
// Design Name: 
// Module Name: Hardware_Vending
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Hardware Implementation
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Hardware_Vending(input clk, input rst, input [1:0]in, // 01 = 5 rs, 10 = 10 rs
output reg out, output reg[1:0] change
);
parameter s0 = 2'b00; //10
parameter s1 = 2'b01; //15
parameter s2 = 2'b10; //20
parameter s3 = 2'b11; //0

always@ (clk) //change only during posedge clock
    begin
        if(rst == 1) //reset stage=S0 stage
            begin
                out=2'b00;
                change = 2'b00;
            end
        else
            begin
                if(in == 2'b00)
                    begin
                        out=0;
                        change=2'b10;
                    end
                else if(in == 2'b01)
                    begin
                        out=1;
                        change=2'b00;
                    end
                else if(in == 2'b10)
                    begin
                        out=1;
                        change=2'b01;
                    end
                 else if(in == 2'b11)
                    begin
                        out=2'b00;
                        change = 2'b00;
                    end
            end
      end
        
        
        
endmodule
