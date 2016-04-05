module aes_dec ( input clk,rst,
                  input [0:127]data_in,key_in,key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10,
                  output reg [0:127]data_out
                );

reg [0:6]enc_state;
reg [0:31]state0,state1,state2,state3;
reg [0:31]aes_matrix0_step1,aes_matrix1_step1,aes_matrix2_step1,aes_matrix3_step1;

reg b;
reg [0:127]op_reg;

//wire [0:127]key_out;
//reg rst_key_schedule;
//reg [0:127]key_in_key_schedule;
//reg [0:3]round_no_key_schedule;
//reg [0:127]key_out_key_schedule;

wire [0:127]subbyte0=128'h52096ad53036a538bf40a39e81f3d7fb; //637c777bf26b6fc53001672bfed7ab76
wire [0:127]subbyte1=128'h7ce339829b2fff87348e4344c4dee9cb; //ca82c97dfa5947f0add4a2af9ca472c0
wire [0:127]subbyte2=128'h547b9432a6c2233dee4c950b42fac34e; //b7fd9326363ff7cc34a5e5f171d83115
wire [0:127]subbyte3=128'h082ea16628d924b2765ba2496d8bd125; //04c723c31896059a071280e2eb27b275
wire [0:127]subbyte4=128'h72f8f66486689816d4a45ccc5d65b692; //09832c1a1b6e5aa0523bd6b329e32f84
wire [0:127]subbyte5=128'h6c704850fdedb9da5e154657a78d9d84; //53d100ed20fcb15b6acbbe394a4c58cf
wire [0:127]subbyte6=128'h90d8ab008cbcd30af7e45805b8b34506; //d0efaafb434d338545f9027f503c9fa8
wire [0:127]subbyte7=128'hd02c1e8fca3f0f02c1afbd0301138a6b; //51a3408f929d38f5bcb6da2110fff3d2
wire [0:127]subbyte8=128'h3a9111414f67dcea97f2cfcef0b4e673; //cd0c13ec5f974417c4a77e3d645d1973
wire [0:127]subbyte9=128'h96ac7422e7ad3585e2f937e81c75df6e; //60814fdc222a908846eeb814de5e0bdb
wire [0:127]subbytea=128'h47f11a711d29c5896fb7620eaa18be1b; //e0323a0a4906245cc2d3ac629195e479
wire [0:127]subbyteb=128'hfc563e4bc6d279209adbc0fe78cd5af4; //e7c8376d8dd54ea96c56f4ea657aae08
wire [0:127]subbytec=128'h1fdda8338807c731b11210592780ec5f; //ba78252e1ca6b4c6e8dd741f4bbd8b8a
wire [0:127]subbyted=128'h60517fa919b54a0d2de57a9f93c99cef; //703eb5664803f60e613557b986c11d9e
wire [0:127]subbytee=128'ha0e03b4dae2af5b0c8ebbb3c83539961; //e1f8981169d98e949b1e87e9ce5528df
wire [0:127]subbytef=128'h172b047eba77d626e169146355210c7d; //8ca1890dbfe6426841992d0fb054bb16

function [0:31]subbyte;
  input [0:31]aes_matrix;
  reg [0:7]a; reg [0:3]a1; reg [0:3]a2;
  reg [0:127]b1;
  integer i;
  begin
    for (i=0;i<4;i=i+1)begin
     case (i)
      0: begin
         a=aes_matrix[0:7];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[0:7]=b1[0:7];
           1: subbyte[0:7]=b1[8:15];
           2: subbyte[0:7]=b1[16:23];
           3: subbyte[0:7]=b1[24:31];
           4: subbyte[0:7]=b1[32:39];
           5: subbyte[0:7]=b1[40:47];
           6: subbyte[0:7]=b1[48:55];
           7: subbyte[0:7]=b1[56:63];
           8: subbyte[0:7]=b1[64:71];
           9: subbyte[0:7]=b1[72:79];
           4'ha: subbyte[0:7]=b1[80:87];
           4'hb: subbyte[0:7]=b1[88:95];
           4'hc: subbyte[0:7]=b1[96:103];
           4'hd: subbyte[0:7]=b1[104:111];
           4'he: subbyte[0:7]=b1[112:119];
           4'hf: subbyte[0:7]=b1[120:127];
          endcase
       end
       
       1: begin
         a=aes_matrix[8:15];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[8:15]=b1[0:7];
           1: subbyte[8:15]=b1[8:15];
           2: subbyte[8:15]=b1[16:23];
           3: subbyte[8:15]=b1[24:31];
           4: subbyte[8:15]=b1[32:39];
           5: subbyte[8:15]=b1[40:47];
           6: subbyte[8:15]=b1[48:55];
           7: subbyte[8:15]=b1[56:63];
           8: subbyte[8:15]=b1[64:71];
           9: subbyte[8:15]=b1[72:79];
           4'ha: subbyte[8:15]=b1[80:87];
           4'hb: subbyte[8:15]=b1[88:95];
           4'hc: subbyte[8:15]=b1[96:103];
           4'hd: subbyte[8:15]=b1[104:111];
           4'he: subbyte[8:15]=b1[112:119];
           4'hf: subbyte[8:15]=b1[120:127];
          endcase
        end
        
       2: begin
         a=aes_matrix[16:23];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[16:23]=b1[0:7];
           1: subbyte[16:23]=b1[8:15];
           2: subbyte[16:23]=b1[16:23];
           3: subbyte[16:23]=b1[24:31];
           4: subbyte[16:23]=b1[32:39];
           5: subbyte[16:23]=b1[40:47];
           6: subbyte[16:23]=b1[48:55];
           7: subbyte[16:23]=b1[56:63];
           8: subbyte[16:23]=b1[64:71];
           9: subbyte[16:23]=b1[72:79];
           4'ha: subbyte[16:23]=b1[80:87];
           4'hb: subbyte[16:23]=b1[88:95];
           4'hc: subbyte[16:23]=b1[96:103];
           4'hd: subbyte[16:23]=b1[104:111];
           4'he: subbyte[16:23]=b1[112:119];
           4'hf: subbyte[16:23]=b1[120:127];
          endcase
        end
        
       3: begin
         a=aes_matrix[24:31];  
         a1=a[0:3];
         a2=a[4:7];
         case (a1) //[y2:y3]=[0:3]=a[y2:3]
           0: b1=subbyte0;
           1: b1=subbyte1;
           2: b1=subbyte2;
           3: b1=subbyte3;
           4: b1=subbyte4;
           5: b1=subbyte5;
           6: b1=subbyte6;
           7: b1=subbyte7;
           8: b1=subbyte8;
           9: b1=subbyte9;
           4'ha: b1=subbytea;
           4'hb: b1=subbyteb;
           4'hc: b1=subbytec;
           4'hd: b1=subbyted;
           4'he: b1=subbytee;
           4'hf: b1=subbytef;
         endcase
         case (a2) //[y4:y1]=a[4:7]
           0: subbyte[24:31]=b1[0:7];
           1: subbyte[24:31]=b1[8:15];
           2: subbyte[24:31]=b1[16:23];
           3: subbyte[24:31]=b1[24:31];
           4: subbyte[24:31]=b1[32:39];
           5: subbyte[24:31]=b1[40:47];
           6: subbyte[24:31]=b1[48:55];
           7: subbyte[24:31]=b1[56:63];
           8: subbyte[24:31]=b1[64:71];
           9: subbyte[24:31]=b1[72:79];
           4'ha: subbyte[24:31]=b1[80:87];
           4'hb: subbyte[24:31]=b1[88:95];
           4'hc: subbyte[24:31]=b1[96:103];
           4'hd: subbyte[24:31]=b1[104:111];
           4'he: subbyte[24:31]=b1[112:119];
           4'hf: subbyte[24:31]=b1[120:127];
          endcase
        end
      endcase
      
    end
  end
endfunction

//function multiply by 02
function [0:7]mul_02;
  input [0:7]value_02;
  reg [0:7]temp_02;
  parameter r1=8'b00011011;//1B
  parameter r2=8'b00000010;//02
  begin
    if(value_02[0]==1'b0) begin
      mul_02=value_02 * r2;//mul_02=(value_02 * r2) ^ r1;
    end
    else begin
      temp_02=value_02;
      temp_02[0:6]=temp_02[1:7];
      temp_02[7]=1'b0;
      mul_02=temp_02 ^ r1;
    end
  end
endfunction

//function multiply by 09
function [0:7]mul_09;
  input [0:7]value_09;
  reg [0:7]temp1_09,temp2_09,temp3_09;
  begin
    temp1_09=mul_02(value_09);
    temp2_09=mul_02(temp1_09);
    temp3_09=mul_02(temp2_09);
    mul_09=temp3_09 ^ value_09;
  end
endfunction

//function multiply by 11
function [0:7]mul_11;
  input [0:7]value_11;
  reg [0:7]temp1_11,temp2_11,temp3_11,temp4_11;
  begin
    temp1_11=mul_02(value_11);
	 //$display("e5*02=%h",temp1_11);
    temp2_11=mul_02(temp1_11);
	 //$display("(e5*02)*02=%h",temp2_11);
    temp3_11=temp2_11 ^ value_11;
	 //$display("(e5*02)^e5=%h",temp3_11);
    temp4_11=mul_02(temp3_11);
	 //$display("((e5*02)^e5)*02=%h",temp4_11);
    mul_11=temp4_11 ^ value_11;
	 //$display("((e5*02)^e5)*02)^e5=%h",mul_11);
  end
endfunction

//function multiply by 13
function [0:7]mul_13;
  input [0:7]value_13;
  reg [0:7]temp1_13,temp2_13,temp3_13,temp4_13;
  begin
    temp1_13=mul_02(value_13);
    temp2_13=temp1_13 ^ value_13;
    temp3_13=mul_02(temp2_13);
    temp4_13=mul_02(temp3_13);
    mul_13=temp4_13 ^ value_13;
  end
endfunction

//function multiply by 14
function [0:7]mul_14;
  input [0:7]value_14;
  reg [0:7]temp1_14,temp2_14,temp3_14,temp4_14;
  begin
    temp1_14=mul_02(value_14);
    temp2_14=temp1_14 ^ value_14;
    temp3_14=mul_02(temp2_14);
    temp4_14=temp3_14 ^ value_14;
    mul_14=mul_02(temp4_14);
  end
endfunction

function [0:127]inv_mix_col;
  input [0:7]one1,two1,three1,four1,one2,two2,three2,four2,one3,two3,three3,four3,one4,two4,three4,four4;
  reg [0:7]temp1,temp2,temp3,temp4;
  begin
    //first column of matrix
    temp1=mul_14(one1);
    temp2=mul_11(two1);
    temp3=mul_13(three1);
    temp4=mul_09(four1);
    inv_mix_col[0:7]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    temp1=mul_09(one1);
    temp2=mul_14(two1);
    temp3=mul_11(three1);
    temp4=mul_13(four1);
    inv_mix_col[8:15]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    temp1=mul_13(one1);
    temp2=mul_09(two1);
    temp3=mul_14(three1);
    temp4=mul_11(four1);
    inv_mix_col[16:23]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    temp1=mul_11(one1);
    temp2=mul_13(two1);
    temp3=mul_09(three1);
    temp4=mul_14(four1);
    inv_mix_col[24:31]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    //first 32 bits filled now.
    
    //second column of matrix
    temp1=mul_14(one2);
    temp2=mul_11(two2);
    temp3=mul_13(three2);
    temp4=mul_09(four2);
    inv_mix_col[32:39]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    
    temp1=mul_09(one2);
    temp2=mul_14(two2);
    temp3=mul_11(three2);
    temp4=mul_13(four2);
    inv_mix_col[40:47]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    
    temp1=mul_13(one2);
    temp2=mul_09(two2);
    temp3=mul_14(three2);
    temp4=mul_11(four2);
    inv_mix_col[48:55]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    
    temp1=mul_11(one2);
    temp2=mul_13(two2);
    temp3=mul_09(three2);
    temp4=mul_14(four2);
    inv_mix_col[56:63]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    //total 64 bits filled.
    
    //third column processing
    temp1=mul_14(one3);
    temp2=mul_11(two3);
    temp3=mul_13(three3);
    temp4=mul_09(four3);
    inv_mix_col[64:71]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    temp1=mul_09(one3);
    temp2=mul_14(two3);
    temp3=mul_11(three3);
    temp4=mul_13(four3);
    inv_mix_col[72:79]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
  
    temp1=mul_13(one3);
    temp2=mul_09(two3);
    temp3=mul_14(three3);
    temp4=mul_11(four3);
    inv_mix_col[80:87]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
  
    temp1=mul_11(one3);
    temp2=mul_13(two3);
    temp3=mul_09(three3);
    temp4=mul_14(four3);
    inv_mix_col[88:95]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    //total 96 bits filled.
    
    //fourth column processing
    temp1=mul_14(one4);
    temp2=mul_11(two4);
    temp3=mul_13(three4);
    temp4=mul_09(four4);
    inv_mix_col[96:103]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    
    temp1=mul_09(one4);
    temp2=mul_14(two4);
    temp3=mul_11(three4);
    temp4=mul_13(four4);
    inv_mix_col[104:111]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    
    temp1=mul_13(one4);
    temp2=mul_09(two4);
    temp3=mul_14(three4);
    temp4=mul_11(four4);
    inv_mix_col[112:119]=((temp1 ^ temp2) ^ temp3) ^ temp4;
    
    
    temp1=mul_11(one4);
    temp2=mul_13(two4);
    temp3=mul_09(three4);
    temp4=mul_14(four4);
    inv_mix_col[120:127]=((temp1 ^ temp2) ^ temp3) ^ temp4;
 
  end
endfunction

//key_schedule l2 (clk,rst_key_schedule,key_in_key_schedule,round_no_key_schedule,key_out_key_schedule);
//memory_ key l12 (round_no_key_schedule,key_in_key_schedule,key_out_key_schedule);

always @ (clk,rst) begin
  if(rst) begin
    enc_state=0;
    b=1'b1;
    //Part 1 begins
    //state=in(data)
    state0[0:7]=data_in[0:7];
	 state0[8:15]=data_in[32:39];
	 state0[16:23]=data_in[64:71];
	 state0[24:31]=data_in[96:103];
	 
	 state1[0:7]=data_in[8:15];
	 state1[8:15]=data_in[40:47];
	 state1[16:23]=data_in[72:79];
	 state1[24:31]=data_in[104:111];
	 
	 state2[0:7]=data_in[16:23];
	 state2[8:15]=data_in[48:55];
	 state2[16:23]=data_in[80:87];
	 state2[24:31]=data_in[112:119];
	 
	 state3[0:7]=data_in[24:31];
	 state3[8:15]=data_in[56:63];
	 state3[16:23]=data_in[88:95];
	 state3[24:31]=data_in[120:127]; 
	 
	 /*$display("state0 = %h",state0);
	 $display("state1 = %h",state1);
	 $display("state2 = %h",state2);
	 $display("state3 = %h",state3);*/
	 	 
  end
  else begin
    case (enc_state)
      0: begin
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_in[0:7];
		  state0[8:15]=state0[8:15] ^ key_in[32:39];
		  state0[16:23]=state0[16:23] ^ key_in[64:71];
		  state0[24:31]=state0[24:31] ^ key_in[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_in[8:15];
		  state1[8:15]=state1[8:15] ^ key_in[40:47];
		  state1[16:23]=state1[16:23] ^ key_in[72:79];
		  state1[24:31]=state1[24:31] ^ key_in[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_in[16:23];
		  state2[8:15]=state2[8:15] ^ key_in[48:55];
		  state2[16:23]=state2[16:23] ^ key_in[80:87];
		  state2[24:31]=state2[24:31] ^ key_in[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_in[24:31];
		  state3[8:15]=state3[8:15] ^ key_in[56:63];
		  state3[16:23]=state3[16:23] ^ key_in[88:95];
		  state3[24:31]=state3[24:31] ^ key_in[120:127];
        //Part 1 over.
        
		  /*$display("state0 = %h",state0);
	     $display("state1 = %h",state1);
	     $display("state2 = %h",state2);
	     $display("state3 = %h",state3);*/

		  
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_in;
        //round_no_key_schedule=4'b1001;
        
        if(b) begin
          enc_state=7'b0000001;
        end
        else begin
          enc_state=7'b0000000;
        end
      end
      
      1: begin
        //Part 2 begins.
        //LOOP 1
        
        /*
        //subybyte operation
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
		  /*$display("state0 = %h",state0);
	     $display("state1 = %h",state1);
	     $display("state2 = %h",state2);
	     $display("state3 = %h",state3);*/
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b0000010;
        end
        else begin
          enc_state=7'b0000001;
        end
      end
      
      2: begin
        /*
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];
        */
        
        /////////////////////////////////////////////
        //// shiftrow operation for decryption.
        ////////////////////////////////////////////
        /*//shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[24:31]= aes_matrix1_step1[16:23];
        aes_matrix1_step1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[16:31];
        aes_matrix2_step1[16:31]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[8:31];
        aes_matrix3_step1[24:31]=aes_matrix3_step1[0:7];
        aes_matrix3_step1[0:23]=op_reg[0:23];
        */
        
        //subybyte operation for decryption
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
		  /*$display("state0 = %h",aes_matrix0_step1);
	     $display("state1 = %h",aes_matrix1_step1);
	     $display("state2 = %h",aes_matrix2_step1);
	     $display("state3 = %h",aes_matrix3_step1);*/
		  
        if(b) begin
          enc_state=7'b0000011;
        end
        else begin
          enc_state=7'b0000010;
        end
      end
      
      3: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0000100;
        end
        else begin
          enc_state=7'b0000011;
        end
      end
      
      4: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        
        
        if(b) begin
          enc_state=7'b0000101;
        end
        else begin
          enc_state=7'b0000100;
        end
      end
      
      5: begin
        //empty stage, waiting for key 1 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0000110;
        end
        else begin
          enc_state=7'b0000101;
        end
      end
      
      6: begin
        //empty stage, waiting for key 1 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0000111;
        end
        else begin
          enc_state=7'b0000110;
        end
      end
      
      7: begin
        //empty stage, waiting for key 1 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0001000;
        end
        else begin
          enc_state=7'b0000111;
        end
      end
      
      8: begin
        //empty stage, waiting for key 1 to come from key schedule.
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
		  
		  //key_out_key_schedule=128'h549932d1f08557681093ed9cbe2c974e; //*IMPORTANT.
        
        if(b) begin
          enc_state=7'b0001001;
        end
        else begin
          enc_state=7'b0001000;
        end
      end
      
      9: begin
        //Add Round Key operation
		  
		  //$display("key out =%h",key_out_key_schedule);
		  
		  
        state0[0:7]=state0[0:7] ^ key_1[0:7];
		  state0[8:15]=state0[8:15] ^ key_1[32:39];
		  state0[16:23]=state0[16:23] ^ key_1[64:71];
		  state0[24:31]=state0[24:31] ^ key_1[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_1[8:15];
		  state1[8:15]=state1[8:15] ^ key_1[40:47];
		  state1[16:23]=state1[16:23] ^ key_1[72:79];
		  state1[24:31]=state1[24:31] ^ key_1[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_1[16:23];
		  state2[8:15]=state2[8:15] ^ key_1[48:55];
		  state2[16:23]=state2[16:23] ^ key_1[80:87];
		  state2[24:31]=state2[24:31] ^ key_1[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_1[24:31];
		  state3[8:15]=state3[8:15] ^ key_1[56:63];
		  state3[16:23]=state3[16:23] ^ key_1[88:95];
		  state3[24:31]=state3[24:31] ^ key_1[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b0001;
        
        /*$display("value of state0 = %h",state0);
        $display("value of state1 = %h",state1);
        $display("value of state2 = %h",state2);
        $display("value of state3 = %h",state3);*/
        
        //LOOP 1 over.
        if(b) begin
          enc_state=7'b0001010;
        end
        else begin
          enc_state=7'b0001001;
        end
      end
      
      10: begin
        //LOOP 2 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //reset for key expansion.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b0001011;
        end
        else begin
          enc_state=7'b0001010;
        end 
      end
      
      11: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'h54d990a16ba09ab596bbf40ea111702f;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b0001100;
        end
        else begin
          enc_state=7'b0001011;
        end 
      end
      
      12: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //$display("value of op_reg = %h",op_reg);
		  
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
		  
		  
		  
		  /*$display("value of state0 = %h",state0);
        $display("value of state1 = %h",state1);
        $display("value of state2 = %h",state2);
        $display("value of state3 = %h",state3);*/
        
        if(b) begin
          enc_state=7'b0001101;
        end
        else begin
          enc_state=7'b0001100;
        end
      end
      
      13: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b0001110;
        end
        else begin
          enc_state=7'b0001101;
        end
      end
      
      14: begin
        //empty stage, waiting for key 2 to come from key schedule.
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        if(b) begin
          enc_state=7'b0001111;
        end
        else begin
          enc_state=7'b0001110;
        end
      end
      
      15: begin
        //empty stage, waiting for key 2 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0010000;
        end
        else begin
          enc_state=7'b0001111;
        end
      end
      
      16: begin
        //empty stage, waiting for key 2 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0010001;
        end
        else begin
          enc_state=7'b0010000;
        end
      end
      
      17: begin
        //empty stage, waiting for key 2 to come from key schedule.
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
		  
		  //key_out_key_schedule=128'h47438735a41c65b9e016baf4aebf7ad2;
        
        if(b) begin
          enc_state=7'b0010010;
        end
        else begin
          enc_state=7'b0010000;
        end
      end
      
      18: begin
        //add round key operation
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0010;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_2[0:7];
		  state0[8:15]=state0[8:15] ^ key_2[32:39];
		  state0[16:23]=state0[16:23] ^ key_2[64:71];
		  state0[24:31]=state0[24:31] ^ key_2[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_2[8:15];
		  state1[8:15]=state1[8:15] ^ key_2[40:47];
		  state1[16:23]=state1[16:23] ^ key_2[72:79];
		  state1[24:31]=state1[24:31] ^ key_2[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_2[16:23];
		  state2[8:15]=state2[8:15] ^ key_2[48:55];
		  state2[16:23]=state2[16:23] ^ key_2[80:87];
		  state2[24:31]=state2[24:31] ^ key_2[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_2[24:31];
		  state3[8:15]=state3[8:15] ^ key_2[56:63];
		  state3[16:23]=state3[16:23] ^ key_2[88:95];
		  state3[24:31]=state3[24:31] ^ key_2[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b0010;
        
        //LOOP 2 over.
        if(b) begin
          enc_state=7'b0010011;
        end
        else begin
          enc_state=7'b0010010;
        end
      end
      
      19: begin
        //LOOP 3 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule for key expansion file.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b0010100;
        end
        else begin
          enc_state=7'b0010011;
        end
      end
      
      20: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23]; */
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'h3e1c22c0b6fcbf768da85067f6170495;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b0010101;
        end
        else begin
          enc_state=7'b0010100;
        end
      end
      
      21: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b0010110;
        end
        else begin
          enc_state=7'b0010101;
        end
      end
      
      22: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b0010111;
        end
        else begin
          enc_state=7'b0010110;
        end
      end
      
      23: begin
        //empty stage, waiting for key 3 to come from key schedule.
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        if(b) begin
          enc_state=7'b0011000;
        end
        else begin
          enc_state=7'b0010111;
        end
      end
      
      24: begin
        //empty stage, waiting for key 3 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0011001;
        end
        else begin
          enc_state=7'b0011000;
        end
      end
      
      25: begin
        //empty stage, waiting for key 3 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0011010;
        end
        else begin
          enc_state=7'b0011001;
        end
      end
      
      26: begin
        //empty stage, waiting for key 3 to come from key schedule.
        state0=aes_matrix0_step1;
		  state1=aes_matrix1_step1;
		  state2=aes_matrix2_step1;
		  state3=aes_matrix3_step1;
        
        //key_out_key_schedule=128'h14f9701ae35fe28c440adf4d4ea9c026;
		  
        if(b) begin
          enc_state=7'b0011011;
        end
        else begin
          enc_state=7'b0011010;
        end
      end
      
      27: begin
        //add round key operation
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0011;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_3[0:7];
		  state0[8:15]=state0[8:15] ^ key_3[32:39];
		  state0[16:23]=state0[16:23] ^ key_3[64:71];
		  state0[24:31]=state0[24:31] ^ key_3[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_3[8:15];
		  state1[8:15]=state1[8:15] ^ key_3[40:47];
		  state1[16:23]=state1[16:23] ^ key_3[72:79];
		  state1[24:31]=state1[24:31] ^ key_3[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_3[16:23];
		  state2[8:15]=state2[8:15] ^ key_3[48:55];
		  state2[16:23]=state2[16:23] ^ key_3[80:87];
		  state2[24:31]=state2[24:31] ^ key_3[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_3[24:31];
		  state3[8:15]=state3[8:15] ^ key_3[56:63];
		  state3[16:23]=state3[16:23] ^ key_3[88:95];
		  state3[24:31]=state3[24:31] ^ key_3[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b0011;

        
        //LOOP 3 over.
        if(b) begin
          enc_state=7'b0011100;
        end
        else begin
          enc_state=7'b0011011;
        end
      end
      
      28: begin
        //LOOP 4 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule for key expansion file.
        //rst_key_schedule=1'b0;
        
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0011101;
        end
        else begin
          enc_state=7'b0011100;
        end
      end
      
      29: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'hb458124c68b68a014b99f82e5f15554c;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b0011110;
        end
        else begin
          enc_state=7'b0011101;
        end
      end
      
      30: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b0011111;
        end
        else begin
          enc_state=7'b0011110;
        end
      end
      
      31: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b0100000;
        end
        else begin
          enc_state=7'b0011111;
        end
      end
      
      32: begin
        //empty stage, waiting for key 4 to come from key schedule.
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        if(b) begin
          enc_state=7'b0100001;
        end
        else begin
          enc_state=7'b0100000;
        end
      end
      
      33: begin
        //empty stage, waiting for key 4 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0100010;
        end
        else begin
          enc_state=7'b0100001;
        end
      end
      
      34: begin
        //empty stage, waiting for key 4 to come from key schedule.
        
        if(b) begin
          enc_state=7'b0100011;
        end
        else begin
          enc_state=7'b0100010;
        end
      end
      
      35: begin
        //empty stage, waiting for key 4 to come from key schedule.
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
        
		  //key_out_key_schedule=128'h5e390f7df7a69296a7553dc10aa31f6b;
        
        if(b) begin
          enc_state=7'b0100100;
        end
        else begin
          enc_state=7'b0100011;
        end
      end
      
      36: begin
        //add round key operation
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0100;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_4[0:7];
		  state0[8:15]=state0[8:15] ^ key_4[32:39];
		  state0[16:23]=state0[16:23] ^ key_4[64:71];
		  state0[24:31]=state0[24:31] ^ key_4[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_4[8:15];
		  state1[8:15]=state1[8:15] ^ key_4[40:47];
		  state1[16:23]=state1[16:23] ^ key_4[72:79];
		  state1[24:31]=state1[24:31] ^ key_4[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_4[16:23];
		  state2[8:15]=state2[8:15] ^ key_4[48:55];
		  state2[16:23]=state2[16:23] ^ key_4[80:87];
		  state2[24:31]=state2[24:31] ^ key_4[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_4[24:31];
		  state3[8:15]=state3[8:15] ^ key_4[56:63];
		  state3[16:23]=state3[16:23] ^ key_4[88:95];
		  state3[24:31]=state3[24:31] ^ key_4[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b0100;

        
        //LOOP 4 over.
        if(b) begin
          enc_state=7'b0100101;
        end
        else begin
          enc_state=7'b0100100;
        end
      end
      
      37: begin
        //LOOP 5 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b0100110;
        end
        else begin
          enc_state=7'b0100101;
        end
      end
      
      38: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'he8dab6901477d4653ff7f5e2e747dd4f;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b0100111;
        end
        else begin
          enc_state=7'b0100110;
        end
      end
      
      39: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b0101000;
        end
        else begin
          enc_state=7'b0100111;
        end
      end
      
      40: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b0101001;
        end
        else begin
          enc_state=7'b0101000;
        end
      end
      
      41: begin
        //empty stage, waiting for key 5 to come from key schedule. 
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        if(b) begin
          enc_state=7'b0101010;
        end
        else begin
          enc_state=7'b0101001;
        end
      end
      
      42: begin
        //empty stage, waiting for key 5 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b0101011;
        end
        else begin
          enc_state=7'b0101010;
        end
      end
      
      43: begin
        //empty stage, waiting for key 5 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b0101100;
        end
        else begin
          enc_state=7'b0101011;
        end
      end
      
      44: begin
        //empty stage, waiting for key 5 to come from key schedule. 
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
		  
		  //key_out_key_schedule=128'h3caaa3e8a99f9deb50f3af57adf622aa;
        
        if(b) begin
          enc_state=7'b0101101;
        end
        else begin
          enc_state=7'b0101100;
        end
      end
      
      45: begin
        //add round key operation
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0101;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_5[0:7];
		  state0[8:15]=state0[8:15] ^ key_5[32:39];
		  state0[16:23]=state0[16:23] ^ key_5[64:71];
		  state0[24:31]=state0[24:31] ^ key_5[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_5[8:15];
		  state1[8:15]=state1[8:15] ^ key_5[40:47];
		  state1[16:23]=state1[16:23] ^ key_5[72:79];
		  state1[24:31]=state1[24:31] ^ key_5[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_5[16:23];
		  state2[8:15]=state2[8:15] ^ key_5[48:55];
		  state2[16:23]=state2[16:23] ^ key_5[80:87];
		  state2[24:31]=state2[24:31] ^ key_5[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_5[24:31];
		  state3[8:15]=state3[8:15] ^ key_5[56:63];
		  state3[16:23]=state3[16:23] ^ key_5[88:95];
		  state3[24:31]=state3[24:31] ^ key_5[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b0101;
        
        //LOOP 5 over.
        if(b) begin
          enc_state=7'b0101110;
        end
        else begin
          enc_state=7'b0101101;
        end
      end
      
      46: begin
        //LOOP 6 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b0101111;
        end
        else begin
          enc_state=7'b0101110;
        end
      end
      
      47: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'h36339d50f9b539269f2c092dc4406d23;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b0110000;
        end
        else begin
          enc_state=7'b0101111;
        end
      end
      
      48: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b0110001;
        end
        else begin
          enc_state=7'b0110000;
        end
      end
      
      49: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
		  
        if(b) begin
          enc_state=7'b0110010;
        end
        else begin
          enc_state=7'b0110001;
        end
      end
      
      50: begin
        //empty stage, waiting for key 6 to come from key schedule. 
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        if(b) begin
          enc_state=7'b0110011;
        end
        else begin
          enc_state=7'b0110010;
        end
      end
      
      51: begin
        //empty stage, waiting for key 6 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b0110100;
        end
        else begin
          enc_state=7'b0110011;
        end
      end
      
      52: begin
        //empty stage, waiting for key 6 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b0110101;
        end
        else begin
          enc_state=7'b0110100;
        end
      end
      
      53: begin
        //empty stage, waiting for key 6 to come from key schedule. 
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
        
		  //key_out_key_schedule=128'h47f7f7bc95353e03f96c32bcfd058dfd;
		  
        if(b) begin
          enc_state=7'b0110110;
        end
        else begin
          enc_state=7'b0110101;
        end
      end
      
      54: begin
        //add round key operation
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0110;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_6[0:7];
		  state0[8:15]=state0[8:15] ^ key_6[32:39];
		  state0[16:23]=state0[16:23] ^ key_6[64:71];
		  state0[24:31]=state0[24:31] ^ key_6[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_6[8:15];
		  state1[8:15]=state1[8:15] ^ key_6[40:47];
		  state1[16:23]=state1[16:23] ^ key_6[72:79];
		  state1[24:31]=state1[24:31] ^ key_6[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_6[16:23];
		  state2[8:15]=state2[8:15] ^ key_6[48:55];
		  state2[16:23]=state2[16:23] ^ key_6[80:87];
		  state2[24:31]=state2[24:31] ^ key_6[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_6[24:31];
		  state3[8:15]=state3[8:15] ^ key_6[56:63];
		  state3[16:23]=state3[16:23] ^ key_6[88:95];
		  state3[24:31]=state3[24:31] ^ key_6[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b0110;
        
        //LOOP 6 over.
        if(b) begin
          enc_state=7'b0110111;
        end
        else begin
          enc_state=7'b0110110;
        end
      end
      
      55: begin
        //LOOP 7 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b0111000;
        end
        else begin
          enc_state=7'b0110111;
        end
      end
      
      56: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'h2d6d7ef03f33e334093602dd5bfb12c7;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b0111001;
        end
        else begin
          enc_state=7'b0111000;
        end
      end
      
      57: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b0111010;
        end
        else begin
          enc_state=7'b0111001;
        end
      end
      
      58: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b0111011;
        end
        else begin
          enc_state=7'b0111010;
        end
      end
      
      59: begin
        //empty stage, waiting for key 7 to come from key schedule. 
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);

        
        if(b) begin
          enc_state=7'b0111100;
        end
        else begin
          enc_state=7'b0111011;
        end
      end
      
      60: begin
        //empty stage, waiting for key 7 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b0111101;
        end
        else begin
          enc_state=7'b0111100;
        end
      end
      
      61: begin
        //empty stage, waiting for key 7 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b0111110;
        end
        else begin
          enc_state=7'b0111101;
        end
      end
      
      62: begin
        //empty stage, waiting for key 7 to come from key schedule. 
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
		  
		  //key_out_key_schedule=128'hb6ff744ed2c2c9bf6c590cbf0469bf41;
        
        if(b) begin
          enc_state=7'b0111111;
        end
        else begin
          enc_state=7'b0111110;
        end
      end
      
      63: begin
        //add round key operation
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0111;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_7[0:7];
		  state0[8:15]=state0[8:15] ^ key_7[32:39];
		  state0[16:23]=state0[16:23] ^ key_7[64:71];
		  state0[24:31]=state0[24:31] ^ key_7[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_7[8:15];
		  state1[8:15]=state1[8:15] ^ key_7[40:47];
		  state1[16:23]=state1[16:23] ^ key_7[72:79];
		  state1[24:31]=state1[24:31] ^ key_7[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_7[16:23];
		  state2[8:15]=state2[8:15] ^ key_7[48:55];
		  state2[16:23]=state2[16:23] ^ key_7[80:87];
		  state2[24:31]=state2[24:31] ^ key_7[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_7[24:31];
		  state3[8:15]=state3[8:15] ^ key_7[56:63];
		  state3[16:23]=state3[16:23] ^ key_7[88:95];
		  state3[24:31]=state3[24:31] ^ key_7[120:127];
        
        //key_schedule operation set up.
        ///rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b0111;
        
        //LOOP 7 over.
        if(b) begin
          enc_state=7'b1000000;
        end
        else begin
          enc_state=7'b0111111;
        end
      end
      
      64: begin
        //LOOP 8 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b1000001;
        end
        else begin
          enc_state=7'b1000000;
        end
      end
      
      65: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'h3bd92268fc74fb735767cbe0c0590e2d;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b1000010;
        end
        else begin
          enc_state=7'b1000001;
        end
      end
      
      66: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b1000011;
        end
        else begin
          enc_state=7'b1000010;
        end
      end
      
      67: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b1000100;
        end
        else begin
          enc_state=7'b1000011;
        end
      end
      
      68: begin
        //empty stage, waiting for key 8 to come from key schedule. 
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);

        
        if(b) begin
          enc_state=7'b1000101;
        end
        else begin
          enc_state=7'b1000100;
        end
      end
      
      69: begin
        //empty stage, waiting for key 8 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b1000110;
        end
        else begin
          enc_state=7'b1000101;
        end
      end
      
      70: begin
        //empty stage, waiting for key 8 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b1000111;
        end
        else begin
          enc_state=7'b1000110;
        end
      end
      
      71: begin
        //empty stage, waiting for key 8 to come from key schedule. 
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
		  
		  //key_out_key_schedule=128'hb692cf0b643dbdf1be9bc5006830b3fe;
        
        if(b) begin
          enc_state=7'b1001000;
        end
        else begin
          enc_state=7'b1000111;
        end
      end
      
      72: begin
        //add round key operation
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b1000;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_8[0:7];
		  state0[8:15]=state0[8:15] ^ key_8[32:39];
		  state0[16:23]=state0[16:23] ^ key_8[64:71];
		  state0[24:31]=state0[24:31] ^ key_8[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_8[8:15];
		  state1[8:15]=state1[8:15] ^ key_8[40:47];
		  state1[16:23]=state1[16:23] ^ key_8[72:79];
		  state1[24:31]=state1[24:31] ^ key_8[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_8[16:23];
		  state2[8:15]=state2[8:15] ^ key_8[48:55];
		  state2[16:23]=state2[16:23] ^ key_8[80:87];
		  state2[24:31]=state2[24:31] ^ key_8[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_8[24:31];
		  state3[8:15]=state3[8:15] ^ key_8[56:63];
		  state3[16:23]=state3[16:23] ^ key_8[88:95];
		  state3[24:31]=state3[24:31] ^ key_8[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b1000;
        
        //LOOP 8 over.
        if(b) begin
          enc_state=7'b1001001;
        end
        else begin
          enc_state=7'b1001000;
        end
      end
      
      73: begin
        //LOOP 9 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        /*rst_key_schedule=1'b0;*/
        
        aes_matrix0_step1=state0;        
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b1001010;
        end
        else begin
          enc_state=7'b1001001;
        end
      end
      
      74: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'ha7be1a6997ad739bd8c9ca451f618b61;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b1001011;
        end
        else begin
          enc_state=7'b1001010;
        end
      end
      
      75: begin
        //mix column operation.
        //op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b1001100;
        end
        else begin
          enc_state=7'b1001011;
        end
      end
      
      76: begin
        //arranging state matrix
        /*state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];*/
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b1001101;
        end
        else begin
          enc_state=7'b1001100;
        end
      end
      
      77: begin
        //empty stage, waiting for key 9 to come from key schedule. 
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);

        
        if(b) begin
          enc_state=7'b1001110;
        end
        else begin
          enc_state=7'b1001101;
        end
      end
      
      78: begin
        //empty stage, waiting for key 9 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b1001111;
        end
        else begin
          enc_state=7'b1001110;
        end
      end
      
      79: begin
        //empty stage, waiting for key 9 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b1010000;
        end
        else begin
          enc_state=7'b1001111;
        end
      end
      
      80: begin
        //empty stage, waiting for key 9 to come from key schedule. 
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
		  
		  //key_out_key_schedule=128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
        
        
        if(b) begin
          enc_state=7'b1010001;
        end
        else begin
          enc_state=7'b1010000;
        end
      end
      
      81: begin
        //add round key operation
        //$display("key_out_key_schedule = %h",key_out_key_schedule);
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //key_schedule operation set up.
        /*rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b1001;*/
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_9[0:7];
		  state0[8:15]=state0[8:15] ^ key_9[32:39];
		  state0[16:23]=state0[16:23] ^ key_9[64:71];
		  state0[24:31]=state0[24:31] ^ key_9[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_9[8:15];
		  state1[8:15]=state1[8:15] ^ key_9[40:47];
		  state1[16:23]=state1[16:23] ^ key_9[72:79];
		  state1[24:31]=state1[24:31] ^ key_9[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_9[16:23];
		  state2[8:15]=state2[8:15] ^ key_9[48:55];
		  state2[16:23]=state2[16:23] ^ key_9[80:87];
		  state2[24:31]=state2[24:31] ^ key_9[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_9[24:31];
		  state3[8:15]=state3[8:15] ^ key_9[56:63];
		  state3[16:23]=state3[16:23] ^ key_9[88:95];
		  state3[24:31]=state3[24:31] ^ key_9[120:127];
        
        //key_schedule operation set up.
        //rst_key_schedule=1'b1;
        //key_in_key_schedule=key_out_key_schedule;
        //round_no_key_schedule=4'b1001;
        
        //LOOP 9 over.
        //Part 2 over.
        if(b) begin
          enc_state=7'b1010010;
        end
        else begin
          enc_state=7'b1010001;
        end
      end
      
      82: begin
        //Part 3 begins.
        /*aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);*/
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        aes_matrix0_step1=state0;
        aes_matrix1_step1=state1;
        aes_matrix2_step1=state2;
        aes_matrix3_step1=state3;
        
        //key schedule operation set up.
        //rst_key_schedule=1'b0;
        
        if(b) begin
          enc_state=7'b1010011;
        end
        else begin
          enc_state=7'b1010010;
        end
      end
      
      83: begin
        //shiftrow operation
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        /*op_reg[0:7]=aes_matrix1_step1[0:7];
        aes_matrix1_step1[0:7]=aes_matrix1_step1[8:15];
        aes_matrix1_step1[8:15]=aes_matrix1_step1[16:23];
        aes_matrix1_step1[16:23]=aes_matrix1_step1[24:31];
        aes_matrix1_step1[24:31]=op_reg[0:7];
        
        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=aes_matrix2_step1[0:15];
        aes_matrix2_step1[0:7]=aes_matrix2_step1[16:23];
        aes_matrix2_step1[8:15]=aes_matrix2_step1[24:31];
        aes_matrix2_step1[16:31]=op_reg[0:15];
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=aes_matrix3_step1[0:23];
        aes_matrix3_step1[0:7]=aes_matrix3_step1[24:31];
        aes_matrix3_step1[8:31]=op_reg[0:23];*/
        
        //*op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        //op_reg=128'h6353e08c0960e104cd70b751bacad0e7;
		  op_reg=inv_mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
		  
        if(b) begin
          enc_state=7'b1010100;
        end
        else begin
          enc_state=7'b1010011;
        end
      end
      
      84: begin
        //arranging state matrix
        /*state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;*/
        
        //arranging state matrix
        state0[0:7]=op_reg[0:7];
        state0[8:15]=op_reg[32:39];
        state0[16:23]=op_reg[64:71];
        state0[24:31]=op_reg[96:103];
        state1[0:7]=op_reg[8:15];
        state1[8:15]=op_reg[40:47];
        state1[16:23]=op_reg[72:79];
        state1[24:31]=op_reg[104:111];
        state2[0:7]=op_reg[16:23];
        state2[8:15]=op_reg[48:55];
        state2[16:23]=op_reg[80:87];
        state2[24:31]=op_reg[112:119];
        state3[0:7]=op_reg[24:31];
        state3[8:15]=op_reg[56:63];
        state3[16:23]=op_reg[88:95];
        state3[24:31]=op_reg[120:127];
        
        if(b) begin
          enc_state=7'b1010101;
        end
        else begin
          enc_state=7'b1010100;
        end
      end
      
      85: begin
        //empty stage, waiting for key 10 to come from key schedule. 
        
        //shiftrow operation for decryption.
        //shift row operation not applied on first row.
        
        //shift row operation of standard AES 128 on second row.
        op_reg[0:7]=state1[24:31];
        state1[8:31]=state1[0:23];
        state1[0:7]= op_reg[0:7];        

        //shift row operation of standard AES 128 on third row.
        op_reg[0:15]=state2[16:31];
        state2[16:31]=state2[0:15];
        state2[0:15]=op_reg[0:15];
         
        
        //shift row operation of standard AES 128 on fourth row.
        op_reg[0:23]=state3[8:31];
        state3[24:31]=state3[0:7];
        state3[0:23]=op_reg[0:23];
        
        if(b) begin
          enc_state=7'b1010110;
        end
        else begin
          enc_state=7'b1010101;
        end
      end
      
      86: begin
        //empty stage, waiting for key 10 to come from key schedule. 
        
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        if(b) begin
          enc_state=7'b1010111;
        end
        else begin
          enc_state=7'b1010110;
        end
      end
      
      87: begin
        //empty stage, waiting for key 10 to come from key schedule. 
        //$display("key_out_key_schedule = %h",key_out_key_schedule);
        if(b) begin
          enc_state=7'b1011000;
        end
        else begin
          enc_state=7'b1010111;
        end
      end
      
      88: begin
        //empty stage, waiting for key 10 to come from key schedule. 
        //$display("key_out_key_schedule = %h",key_out_key_schedule);
        if(b) begin
          enc_state=7'b1011001;
        end
        else begin
          enc_state=7'b1011000;
        end
      end
      
      89: begin
        //empty stage, waiting for key 10 to come from key schedule. 
        //$display("key_out_key_schedule = %h",key_out_key_schedule);
        
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
		  
		  //key_out_key_schedule=128'h000102030405060708090a0b0c0d0e0f;
        
        if(b) begin
          enc_state=7'b1011010;
        end
        else begin
          enc_state=7'b1011001;
        end
      end
      
      90: begin
        //add round key
        //$display("key_out_key_schedule = %h",key_out_key_schedule);
        /*state0=state0 ^ key_out_key_schedule[0:31]; 
        state1=state1 ^ key_out_key_schedule[32:63];
        state2=state2 ^ key_out_key_schedule[64:95];
        state3=state3 ^ key_out_key_schedule[96:127];*/
        
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_10[0:7];
		  state0[8:15]=state0[8:15] ^ key_10[32:39];
		  state0[16:23]=state0[16:23] ^ key_10[64:71];
		  state0[24:31]=state0[24:31] ^ key_10[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_10[8:15];
		  state1[8:15]=state1[8:15] ^ key_10[40:47];
		  state1[16:23]=state1[16:23] ^ key_10[72:79];
		  state1[24:31]=state1[24:31] ^ key_10[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_10[16:23];
		  state2[8:15]=state2[8:15] ^ key_10[48:55];
		  state2[16:23]=state2[16:23] ^ key_10[80:87];
		  state2[24:31]=state2[24:31] ^ key_10[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_10[24:31];
		  state3[8:15]=state3[8:15] ^ key_10[56:63];
		  state3[16:23]=state3[16:23] ^ key_10[88:95];
		  state3[24:31]=state3[24:31] ^ key_10[120:127];
        
        //Part 3 over.
        if(b) begin
          enc_state=7'b1011011;
        end
        else begin
          enc_state=7'b1011010;
        end
      end
      
      91: begin
        //Part 4 begins
        data_out[0:7]=state0[0:7];
			data_out[32:39]=state0[8:15];
			data_out[64:71]=state0[16:23];
			data_out[96:103]=state0[24:31];
	 
	 
			data_out[8:15]=state1[0:7];
			data_out[40:47]=state1[8:15];
			data_out[72:79]=state1[16:23];
			data_out[104:111]=state1[24:31];
	 
	 
			data_out[16:23]=state2[0:7];
			data_out[48:55]=state2[8:15];
			data_out[80:87]=state2[16:23];
			data_out[112:119]=state2[24:31];
	 
	 
			data_out[24:31]=state3[0:7];
			data_out[56:63]=state3[8:15];
			data_out[88:95]=state3[16:23];
			data_out[120:127]=state3[24:31];
        
        //Part 4 over.
        //$display("data_out = %b",data_out);
        
        if(b) begin
          enc_state=7'b1011100;
        end
        else begin
          enc_state=7'b1011011;
        end

      end
      
      92: begin
      end
      
      default: begin
      end
    endcase
  end
  
end

endmodule

