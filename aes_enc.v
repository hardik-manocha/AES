module aes_enc ( input clk,rst,
                  input [0:127]data_in,key_in,
                  output reg [0:127]data_out,
						//output reg [0:3]key_no,
						output reg [0:127]key_1,key_2,key_3,key_4,key_5,key_6,key_7,key_8,key_9,key_10
                );

reg [0:6]enc_state;
reg [0:31]state0,state1,state2,state3;
reg [0:31]aes_matrix0_step1,aes_matrix1_step1,aes_matrix2_step1,aes_matrix3_step1;

reg b;
reg [0:127]op_reg;

//wire [0:127]key_out;
reg rst_key_schedule;
reg [0:127]key_in_key_schedule;
reg [0:3]round_no_key_schedule;
wire [0:127]key_out_key_schedule;

wire [0:127]subbyte0=128'h637c777bf26b6fc53001672bfed7ab76;
wire [0:127]subbyte1=128'hca82c97dfa5947f0add4a2af9ca472c0;
wire [0:127]subbyte2=128'hb7fd9326363ff7cc34a5e5f171d83115;
wire [0:127]subbyte3=128'h04c723c31896059a071280e2eb27b275;
wire [0:127]subbyte4=128'h09832c1a1b6e5aa0523bd6b329e32f84;
wire [0:127]subbyte5=128'h53d100ed20fcb15b6acbbe394a4c58cf;
wire [0:127]subbyte6=128'hd0efaafb434d338545f9027f503c9fa8;
wire [0:127]subbyte7=128'h51a3408f929d38f5bcb6da2110fff3d2;
wire [0:127]subbyte8=128'hcd0c13ec5f974417c4a77e3d645d1973;
wire [0:127]subbyte9=128'h60814fdc222a908846eeb814de5e0bdb;
wire [0:127]subbytea=128'he0323a0a4906245cc2d3ac629195e479;
wire [0:127]subbyteb=128'he7c8376d8dd54ea96c56f4ea657aae08;
wire [0:127]subbytec=128'hba78252e1ca6b4c6e8dd741f4bbd8b8a;
wire [0:127]subbyted=128'h703eb5664803f60e613557b986c11d9e;
wire [0:127]subbytee=128'he1f8981169d98e949b1e87e9ce5528df;
wire [0:127]subbytef=128'h8ca1890dbfe6426841992d0fb054bb16;

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

function [0:127]mix_col;
  input [0:7]one1,two1,three1,four1,one2,two2,three2,four2,one3,two3,three3,four3,one4,two4,three4,four4;
  reg [0:7]temp1,temp2;
  begin
    //first column of matrix
    temp1=mul_02(one1);
    temp2=mul_03(two1);
    mix_col[0:7]=((temp1 ^ temp2) ^ three1) ^ four1;
    
    temp1=mul_02(two1);
    temp2=mul_03(three1);
    mix_col[8:15]=((one1 ^ temp1) ^ temp2) ^ four1;
    
    temp1=mul_02(three1);
    temp2=mul_03(four1);
    mix_col[16:23]=((one1 ^ two1) ^ temp1) ^ temp2;
    
    temp1=mul_02(four1);
    temp2=mul_03(one1);
    mix_col[24:31]=((temp2 ^ two1) ^ three1) ^ temp1;
    //first 32 bits filled now.
    
    //second column of matrix
    temp1=mul_02(one2);
    temp2=mul_03(two2);
    mix_col[32:39]=((temp1 ^ temp2) ^ three2) ^ four2;
    
    temp1=mul_02(two2);
    temp2=mul_03(three2);
    mix_col[40:47]=((one2 ^ temp1) ^ temp2) ^ four2;
    
    temp1=mul_02(three2);
    temp2=mul_03(four2);
    mix_col[48:55]=((one2 ^ two2) ^ temp1) ^ temp2;
    
    temp1=mul_02(four2);
    temp2=mul_03(one2);
    mix_col[56:63]=((temp2 ^ two2) ^ three2) ^ temp1;
    //total 64 bits filled.
    
    //third column processing
    temp1=mul_02(one3);
    temp2=mul_03(two3);
    mix_col[64:71]=((temp1 ^ temp2) ^ three3) ^ four3;
    
    temp1=mul_02(two3);
    temp2=mul_03(three3);
    mix_col[72:79]=((one3 ^ temp1) ^ temp2) ^ four3;
    
    temp1=mul_02(three3);
    temp2=mul_03(four3);
    mix_col[80:87]=((one3 ^ two3) ^ temp1) ^ temp2;
    
    temp1=mul_02(four3);
    temp2=mul_03(one3);
    mix_col[88:95]=((temp2 ^ two3) ^ three3) ^ temp1;
    //total 96 bits filled.
    
    //fourth column processing
    temp1=mul_02(one4);
    temp2=mul_03(two4);
    mix_col[96:103]=((temp1 ^ temp2) ^ three4) ^ four4;
    
    temp1=mul_02(two4);
    temp2=mul_03(three4);
    mix_col[104:111]=((one4 ^ temp1) ^ temp2) ^ four4;
    
    temp1=mul_02(three4);
    temp2=mul_03(four4);
    mix_col[112:119]=((one4 ^ two4) ^ temp1) ^ temp2;
    
    temp1=mul_02(four4);
    temp2=mul_03(one4);
    mix_col[120:127]=((temp2 ^ two4) ^ three4) ^ temp1;
 
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

//function multiply by 03
function [0:7]mul_03;
  input [0:7]value_03;
  reg [0:7]temp_03;
  begin
    temp_03=mul_02(value_03);
    mul_03=temp_03 ^ value_03;
  end
endfunction

//reg [0:3]key_no;
//reg [0:127]key_value_store;

key_schedule l1 (clk,rst_key_schedule,key_in_key_schedule,round_no_key_schedule,key_out_key_schedule);
//memory_key l12 (key_no,key_value_store);

always @ (posedge clk) begin
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
	 
	 /*$display("value of state0 = %h",state0);
	 $display("value of state1 = %h",state1);
	 $display("value of state2 = %h",state2);
	 $display("value of state3 = %h",state3);*/
	 
	 //$display("value of input key= %h",key_in);
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
		  
		  //key_value_store=key_in;
		  
		  
		  /**$display("value of state0 = %h",state0);
		  $display("value of state1 = %h",state1);
		  $display("value of state2 = %h",state2);
		  $display("value of state3 = %h",state3);*/
        //Part 1 over.
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_in;
        round_no_key_schedule=4'b0000;
        
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
        
        //$display("value of state0 = %h",state0);
        //$display("value of state1 = %h",state1);
        //$display("value of state2 = %h",state2);
        //$display("value of state3 = %h",state3);
        
        //subybyte operation
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
		  
		  /*$display("value of state0 = %h",aes_matrix0_step1);
        $display("value of state1 = %h",aes_matrix1_step1);
        $display("value of state2 = %h",aes_matrix2_step1);
        $display("value of state3 = %h",aes_matrix3_step1);*/
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
		  
		  //key_no=4'b0000;
        
        if(b) begin
          enc_state=7'b0000010;
        end
        else begin
          enc_state=7'b0000001;
        end
      end
      
      2: begin
       
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
		  
		  /*op_reg[0:31]=aes_matrix0_step1;
		  op_reg[32:63]=aes_matrix1_step1;
		  op_reg[64:95]=aes_matrix2_step1;
		  op_reg[96:127]=aes_matrix3_step1;
		  
		  aes_matrix0_step1[0:7]=op_reg[0:7];
		  aes_matrix0_step1[8:15]=op_reg[40:47];
		  aes_matrix0_step1[16:23]=op_reg[80:87];
		  aes_matrix0_step1[24:31]=op_reg[120:127];
		  
		  aes_matrix1_step1[0:7]=op_reg[32:39];
		  aes_matrix1_step1[8:15]=op_reg[72:79];
		  aes_matrix1_step1[16:23]=op_reg[112:119];
		  aes_matrix1_step1[24:31]=op_reg[24:31];
		  
		  aes_matrix2_step1[0:7]=op_reg[64:71];
		  aes_matrix2_step1[8:15]=op_reg[104:111];
		  aes_matrix2_step1[16:23]=op_reg[16:23];
		  aes_matrix2_step1[24:31]=op_reg[56:63];
		  
		  aes_matrix3_step1[0:7]=op_reg[96:103];
		  aes_matrix3_step1[8:15]=op_reg[8:15];
		  aes_matrix3_step1[16:23]=op_reg[48:55];
		  aes_matrix3_step1[24:31]=op_reg[88:95];*/
        
		  /*$display("value of state0 = %h",aes_matrix0_step1);
        $display("value of state1 = %h",aes_matrix1_step1);
        $display("value of state2 = %h",aes_matrix2_step1);
        $display("value of state3 = %h",aes_matrix3_step1);*/
		  
        if(b) begin
          enc_state=7'b0000011;
        end
        else begin
          enc_state=7'b0000010;
        end
      end
      
      3: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0000100;
        end
        else begin
          enc_state=7'b0000011;
        end
      end
      
      4: begin
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
        
        /*$display("value of state0 = %h",state0);
        $display("value of state1 = %h",state1);
        $display("value of state2 = %h",state2);
        $display("value of state3 = %h",state3);*/
        
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
        
        if(b) begin
          enc_state=7'b0001001;
        end
        else begin
          enc_state=7'b0001000;
        end
      end
      
      9: begin
        //add round key operation
		  
		  /*$display("value of state0 = %h",state0);
        $display("value of state1 = %h",state1);
        $display("value of state2 = %h",state2);*/
        //$display(" 1 value of key_out_key_schedule = %h",key_out_key_schedule);
		  
        //Add Round Key operation
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
		  
		  /*$display("value of state0 = %h",state0);
        $display("value of state1 = %h",state1);
        $display("value of state2 = %h",state2);
        $display("value of state3 = %h",state3);*/
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0001;
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
		  
		  key_1=key_out_key_schedule;
        
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
		  
		  /*$display("value of state0 = %h",aes_matrix0_step1);
        $display("value of state1 = %h",aes_matrix1_step1);
        $display("value of state2 = %h",aes_matrix2_step1);
        $display("value of state3 = %h",aes_matrix3_step1);*/
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
		  
		  //key_no=4'b0001;
        
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
        
		  /*$display("value of state0 = %h",aes_matrix0_step1);
        $display("value of state1 = %h",aes_matrix1_step1);
        $display("value of state2 = %h",aes_matrix2_step1);
        $display("value of state3 = %h",aes_matrix3_step1);*/
		  
        if(b) begin
          enc_state=7'b0001100;
        end
        else begin
          enc_state=7'b0001011;
        end 
      end
      
      12: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0001101;
        end
        else begin
          enc_state=7'b0001100;
        end
      end
      
      13: begin
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
        
		  /*$display("value of state0 = %h",state0);
        $display("value of state1 = %h",state1);
        $display("value of state2 = %h",state2);
        $display("value of state3 = %h",state3);*/
		  
        if(b) begin
          enc_state=7'b0001110;
        end
        else begin
          enc_state=7'b0001101;
        end
      end
      
      14: begin
        //empty stage, waiting for key 2 to come from key schedule.
        
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
        
        if(b) begin
          enc_state=7'b0010010;
        end
        else begin
          enc_state=7'b0010000;
        end
      end
      
      18: begin
        //Add Round Key operation
		  
		  //$display(" 2 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
		  
		  /*$display("value of state0 = %h",state0);
        $display("value of state1 = %h",state1);
        $display("value of state2 = %h",state2);
        $display("value of state3 = %h",state3);*/
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0010;
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
		  key_2=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b0010;
		  
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
        
        if(b) begin
          enc_state=7'b0010101;
        end
        else begin
          enc_state=7'b0010100;
        end
      end
      
      21: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0010110;
        end
        else begin
          enc_state=7'b0010101;
        end
      end
      
      22: begin
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
          enc_state=7'b0010111;
        end
        else begin
          enc_state=7'b0010110;
        end
      end
      
      23: begin
        //empty stage, waiting for key 3 to come from key schedule.
        
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
        
        if(b) begin
          enc_state=7'b0011011;
        end
        else begin
          enc_state=7'b0011010;
        end
      end
      
      27: begin
        //Add Round Key operation
		  
		  //$display(" 3 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0011;
        
        /*$display("value of 4 state0 = %h",state0);
        $display("value of 4 state1 = %h",state1);
        $display("value of 4 state2 = %h",state2);
        $display("value of 4 state3 = %h",state3);*/
        
		  key_3=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b0011;
		  
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
        
        if(b) begin
          enc_state=7'b0011110;
        end
        else begin
          enc_state=7'b0011101;
        end
      end
      
      30: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0011111;
        end
        else begin
          enc_state=7'b0011110;
        end
      end
      
      31: begin
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
          enc_state=7'b0100000;
        end
        else begin
          enc_state=7'b0011111;
        end
      end
      
      32: begin
        //empty stage, waiting for key 4 to come from key schedule.
        
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
        
        if(b) begin
          enc_state=7'b0100100;
        end
        else begin
          enc_state=7'b0100011;
        end
      end
      
      36: begin
        //Add Round Key operation
		  
		  //$display(" 4 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0100;
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
		  key_4=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b0100;
		  
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
        
        if(b) begin
          enc_state=7'b0100111;
        end
        else begin
          enc_state=7'b0100110;
        end
      end
      
      39: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0101000;
        end
        else begin
          enc_state=7'b0100111;
        end
      end
      
      40: begin
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
          enc_state=7'b0101001;
        end
        else begin
          enc_state=7'b0101000;
        end
      end
      
      41: begin
        //empty stage, waiting for key 5 to come from key schedule. 
        
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
        
        if(b) begin
          enc_state=7'b0101101;
        end
        else begin
          enc_state=7'b0101100;
        end
      end
      
      45: begin
        //Add Round Key operation
		  
		  //$display(" 5 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0101;
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
		  key_5=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b0101;
		  
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
        
        if(b) begin
          enc_state=7'b0110000;
        end
        else begin
          enc_state=7'b0101111;
        end
      end
      
      48: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0110001;
        end
        else begin
          enc_state=7'b0110000;
        end
      end
      
      49: begin
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
          enc_state=7'b0110010;
        end
        else begin
          enc_state=7'b0110001;
        end
      end
      
      50: begin
        //empty stage, waiting for key 6 to come from key schedule. 
        
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
        
        if(b) begin
          enc_state=7'b0110110;
        end
        else begin
          enc_state=7'b0110101;
        end
      end
      
      54: begin
        //Add Round Key operation
		  
		  //$display(" 6 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0110;
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
		  key_6=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b0110;
		  
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
        
        if(b) begin
          enc_state=7'b0111001;
        end
        else begin
          enc_state=7'b0111000;
        end
      end
      
      57: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b0111010;
        end
        else begin
          enc_state=7'b0111001;
        end
      end
      
      58: begin
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
          enc_state=7'b0111011;
        end
        else begin
          enc_state=7'b0111010;
        end
      end
      
      59: begin
        //empty stage, waiting for key 7 to come from key schedule. 
        
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
        
        if(b) begin
          enc_state=7'b0111111;
        end
        else begin
          enc_state=7'b0111110;
        end
      end
      
      63: begin
        //Add Round Key operation
		  
		  //$display(" 7 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b0111;
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
		  key_7=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b0111;
		  
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
        
        if(b) begin
          enc_state=7'b1000010;
        end
        else begin
          enc_state=7'b1000001;
        end
      end
      
      66: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b1000011;
        end
        else begin
          enc_state=7'b1000010;
        end
      end
      
      67: begin
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
          enc_state=7'b1000100;
        end
        else begin
          enc_state=7'b1000011;
        end
      end
      
      68: begin
        //empty stage, waiting for key 8 to come from key schedule. 
        
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
        
        if(b) begin
          enc_state=7'b1001000;
        end
        else begin
          enc_state=7'b1000111;
        end
      end
      
      72: begin
        //Add Round Key operation
		  
		  //$display(" 8 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b1000;
        
        //$display("value of 4 state0 = %h",state0);
        //$display("value of 4 state1 = %h",state1);
        //$display("value of 4 state2 = %h",state2);
        //$display("value of 4 state3 = %h",state3);
        
		  key_8=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b1000;
		  
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
        
        if(b) begin
          enc_state=7'b1001011;
        end
        else begin
          enc_state=7'b1001010;
        end
      end
      
      75: begin
        //mix column operation.
        op_reg=mix_col(aes_matrix0_step1[0:7],aes_matrix1_step1[0:7],aes_matrix2_step1[0:7],aes_matrix3_step1[0:7],aes_matrix0_step1[8:15],aes_matrix1_step1[8:15],aes_matrix2_step1[8:15],aes_matrix3_step1[8:15],aes_matrix0_step1[16:23],aes_matrix1_step1[16:23],aes_matrix2_step1[16:23],aes_matrix3_step1[16:23],aes_matrix0_step1[24:31],aes_matrix1_step1[24:31],aes_matrix2_step1[24:31],aes_matrix3_step1[24:31]);
        
        if(b) begin
          enc_state=7'b1001100;
        end
        else begin
          enc_state=7'b1001011;
        end
      end
      
      76: begin
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
          enc_state=7'b1001101;
        end
        else begin
          enc_state=7'b1001100;
        end
      end
      
      77: begin
        //empty stage, waiting for key 9 to come from key schedule. 
        
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
        
        if(b) begin
          enc_state=7'b1010001;
        end
        else begin
          enc_state=7'b1010000;
        end
      end
      
      81: begin
        //Add Round Key operation
		  
		  //$display(" 9 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
        
        //key_schedule operation set up.
        rst_key_schedule=1'b1;
        key_in_key_schedule=key_out_key_schedule;
        round_no_key_schedule=4'b1001;
        
        /*$display("value of 4 state0 = %h",state0);
        $display("value of 4 state1 = %h",state1);
        $display("value of 4 state2 = %h",state2);
        $display("value of 4 state3 = %h",state3);*/
        
		  key_9=key_out_key_schedule;
		  
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
        aes_matrix0_step1=subbyte(state0);
        aes_matrix1_step1=subbyte(state1);
        aes_matrix2_step1=subbyte(state2);
        aes_matrix3_step1=subbyte(state3);
        
        //key schedule operation set up.
        rst_key_schedule=1'b0;
        
		  //key_no=4'b1001;
		  
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
        
        if(b) begin
          enc_state=7'b1010100;
        end
        else begin
          enc_state=7'b1010011;
        end
      end
      
      84: begin
        //arranging state matrix
        state0=aes_matrix0_step1;
        state1=aes_matrix1_step1;
        state2=aes_matrix2_step1;
        state3=aes_matrix3_step1;
        
        if(b) begin
          enc_state=7'b1010101;
        end
        else begin
          enc_state=7'b1010100;
        end
      end
      
      85: begin
        //empty stage, waiting for key 10 to come from key schedule. 
        
        if(b) begin
          enc_state=7'b1010110;
        end
        else begin
          enc_state=7'b1010101;
        end
      end
      
      86: begin
        //empty stage, waiting for key 10 to come from key schedule. 
        
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
        if(b) begin
          enc_state=7'b1011010;
        end
        else begin
          enc_state=7'b1011001;
        end
      end
      
      90: begin
        //Add Round Key operation
		  
		  //$display(" 10 value of key_out_key_schedule = %h",key_out_key_schedule);
        state0[0:7]=state0[0:7] ^ key_out_key_schedule[0:7];
		  state0[8:15]=state0[8:15] ^ key_out_key_schedule[32:39];
		  state0[16:23]=state0[16:23] ^ key_out_key_schedule[64:71];
		  state0[24:31]=state0[24:31] ^ key_out_key_schedule[96:103];
		  
        state1[0:7]=state1[0:7] ^ key_out_key_schedule[8:15];
		  state1[8:15]=state1[8:15] ^ key_out_key_schedule[40:47];
		  state1[16:23]=state1[16:23] ^ key_out_key_schedule[72:79];
		  state1[24:31]=state1[24:31] ^ key_out_key_schedule[104:111];
		  
		  state2[0:7]=state2[0:7] ^ key_out_key_schedule[16:23];
		  state2[8:15]=state2[8:15] ^ key_out_key_schedule[48:55];
		  state2[16:23]=state2[16:23] ^ key_out_key_schedule[80:87];
		  state2[24:31]=state2[24:31] ^ key_out_key_schedule[112:119];
		  
		  state3[0:7]=state3[0:7] ^ key_out_key_schedule[24:31];
		  state3[8:15]=state3[8:15] ^ key_out_key_schedule[56:63];
		  state3[16:23]=state3[16:23] ^ key_out_key_schedule[88:95];
		  state3[24:31]=state3[24:31] ^ key_out_key_schedule[120:127];
		  
		  /*$display("value of 4 state0 = %h",state0);
        $display("value of 4 state1 = %h",state1);
        $display("value of 4 state2 = %h",state2);
        $display("value of 4 state3 = %h",state3);*/
        
		  key_10=key_out_key_schedule;
		  
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
        
		  //key_no=4'b1010;
		  
        //Part 4 over.
        //$display("data_out = %h",data_out);
        
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