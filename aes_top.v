`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:35 11/01/2015 
// Design Name: 
// Module Name:    aes_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module aes_top(
    input clk,
rst_enc,
rst_dec,

    input [0:127] plain_data,
key_input,

    output [0:127]decrypted_data,

    output reg data_match
    );


//wire [0:127]cipher_data;
//wire [0:3]key_no;
//wire [0:127]key_value_store; 
//reg encrypted_data

wire [0:127]cipher_data;
wire 
[0:127]key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10;


aes_enc z1 (clk,rst_enc,plain_data,key_input,cipher_data,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10);
//memory_key z2 (key_no,key_value_store);

aes_dec z2 (clk,rst_dec,cipher_data,key_10,key_9,key_8,key_7,key_6,key_5,key_4,key_3,key_2,key_1,key_input,decrypted_data);


always @ (posedge clk) begin

	if(decrypted_data==plain_data) begin

		data_match=1'b1;

	end

end


endmodule
