// File sbox.vhdl translated with vhd2vl v2.4 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 1995

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002, 2005, 2008-2010 Larry Doolittle - LBNL
//     http://doolittle.icarus.com/~larry/vhd2vl/
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.


module sbox(
input_byte,
output_byte
);

input [7:0] input_byte;
output [7:0] output_byte;

wire [7:0] input_byte;
reg [7:0] output_byte;



  always @(*) begin
    case(input_byte[7:0])
      8'h 01 : output_byte <= 8'h 7c;
      8'h 02 : output_byte <= 8'h 77;
      8'h 03 : output_byte <= 8'h 7b;
      8'h 04 : output_byte <= 8'h f2;
      8'h 05 : output_byte <= 8'h 6b;
      8'h 06 : output_byte <= 8'h 6f;
      8'h 07 : output_byte <= 8'h c5;
      8'h 08 : output_byte <= 8'h 30;
      8'h 09 : output_byte <= 8'h 01;
      8'h 0a : output_byte <= 8'h 67;
      8'h 0b : output_byte <= 8'h 2b;
      8'h 0c : output_byte <= 8'h fe;
      8'h 0d : output_byte <= 8'h d7;
      8'h 0e : output_byte <= 8'h ab;
      8'h 0f : output_byte <= 8'h 76;
      8'h 10 : output_byte <= 8'h ca;
      8'h 11 : output_byte <= 8'h 82;
      8'h 12 : output_byte <= 8'h c9;
      8'h 13 : output_byte <= 8'h 7d;
      8'h 14 : output_byte <= 8'h fa;
      8'h 15 : output_byte <= 8'h 59;
      8'h 16 : output_byte <= 8'h 47;
      8'h 17 : output_byte <= 8'h f0;
      8'h 18 : output_byte <= 8'h ad;
      8'h 19 : output_byte <= 8'h d4;
      8'h 1a : output_byte <= 8'h a2;
      8'h 1b : output_byte <= 8'h af;
      8'h 1c : output_byte <= 8'h 9c;
      8'h 1d : output_byte <= 8'h a4;
      8'h 1e : output_byte <= 8'h 72;
      8'h 1f : output_byte <= 8'h c0;
      8'h 20 : output_byte <= 8'h b7;
      8'h 21 : output_byte <= 8'h fd;
      8'h 22 : output_byte <= 8'h 93;
      8'h 23 : output_byte <= 8'h 26;
      8'h 24 : output_byte <= 8'h 36;
      8'h 25 : output_byte <= 8'h 3f;
      8'h 26 : output_byte <= 8'h f7;
      8'h 27 : output_byte <= 8'h cc;
      8'h 28 : output_byte <= 8'h 34;
      8'h 29 : output_byte <= 8'h a5;
      8'h 2a : output_byte <= 8'h e5;
      8'h 2b : output_byte <= 8'h f1;
      8'h 2c : output_byte <= 8'h 71;
      8'h 2d : output_byte <= 8'h d8;
      8'h 2e : output_byte <= 8'h 31;
      8'h 2f : output_byte <= 8'h 15;
      8'h 30 : output_byte <= 8'h 04;
      8'h 31 : output_byte <= 8'h c7;
      8'h 32 : output_byte <= 8'h 23;
      8'h 33 : output_byte <= 8'h c3;
      8'h 34 : output_byte <= 8'h 18;
      8'h 35 : output_byte <= 8'h 96;
      8'h 36 : output_byte <= 8'h 05;
      8'h 37 : output_byte <= 8'h 9a;
      8'h 38 : output_byte <= 8'h 07;
      8'h 39 : output_byte <= 8'h 12;
      8'h 3a : output_byte <= 8'h 80;
      8'h 3b : output_byte <= 8'h e2;
      8'h 3c : output_byte <= 8'h eb;
      8'h 3d : output_byte <= 8'h 27;
      8'h 3e : output_byte <= 8'h b2;
      8'h 3f : output_byte <= 8'h 75;
      8'h 40 : output_byte <= 8'h 09;
      8'h 41 : output_byte <= 8'h 83;
      8'h 42 : output_byte <= 8'h 2c;
      8'h 43 : output_byte <= 8'h 1a;
      8'h 44 : output_byte <= 8'h 1b;
      8'h 45 : output_byte <= 8'h 6e;
      8'h 46 : output_byte <= 8'h 5a;
      8'h 47 : output_byte <= 8'h a0;
      8'h 48 : output_byte <= 8'h 52;
      8'h 49 : output_byte <= 8'h 3b;
      8'h 4a : output_byte <= 8'h d6;
      8'h 4b : output_byte <= 8'h b3;
      8'h 4c : output_byte <= 8'h 29;
      8'h 4d : output_byte <= 8'h e3;
      8'h 4e : output_byte <= 8'h 2f;
      8'h 4f : output_byte <= 8'h 84;
      8'h 50 : output_byte <= 8'h 53;
      8'h 51 : output_byte <= 8'h d1;
      8'h 52 : output_byte <= 8'h 00;
      8'h 53 : output_byte <= 8'h ed;
      8'h 54 : output_byte <= 8'h 20;
      8'h 55 : output_byte <= 8'h fc;
      8'h 56 : output_byte <= 8'h b1;
      8'h 57 : output_byte <= 8'h 5b;
      8'h 58 : output_byte <= 8'h 6a;
      8'h 59 : output_byte <= 8'h cb;
      8'h 5a : output_byte <= 8'h be;
      8'h 5b : output_byte <= 8'h 39;
      8'h 5c : output_byte <= 8'h 4a;
      8'h 5d : output_byte <= 8'h 4c;
      8'h 5e : output_byte <= 8'h 58;
      8'h 5f : output_byte <= 8'h cf;
      8'h 60 : output_byte <= 8'h d0;
      8'h 61 : output_byte <= 8'h ef;
      8'h 62 : output_byte <= 8'h aa;
      8'h 63 : output_byte <= 8'h fb;
      8'h 64 : output_byte <= 8'h 43;
      8'h 65 : output_byte <= 8'h 4d;
      8'h 66 : output_byte <= 8'h 33;
      8'h 67 : output_byte <= 8'h 85;
      8'h 68 : output_byte <= 8'h 45;
      8'h 69 : output_byte <= 8'h f9;
      8'h 6a : output_byte <= 8'h 02;
      8'h 6b : output_byte <= 8'h 7f;
      8'h 6c : output_byte <= 8'h 50;
      8'h 6d : output_byte <= 8'h 3c;
      8'h 6e : output_byte <= 8'h 9f;
      8'h 6f : output_byte <= 8'h a8;
      8'h 70 : output_byte <= 8'h 51;
      8'h 71 : output_byte <= 8'h a3;
      8'h 72 : output_byte <= 8'h 40;
      8'h 73 : output_byte <= 8'h 8f;
      8'h 74 : output_byte <= 8'h 92;
      8'h 75 : output_byte <= 8'h 9d;
      8'h 76 : output_byte <= 8'h 38;
      8'h 77 : output_byte <= 8'h f5;
      8'h 78 : output_byte <= 8'h bc;
      8'h 79 : output_byte <= 8'h b6;
      8'h 7a : output_byte <= 8'h da;
      8'h 7b : output_byte <= 8'h 21;
      8'h 7c : output_byte <= 8'h 10;
      8'h 7d : output_byte <= 8'h ff;
      8'h 7e : output_byte <= 8'h f3;
      8'h 7f : output_byte <= 8'h d2;
      8'h 80 : output_byte <= 8'h cd;
      8'h 81 : output_byte <= 8'h 0c;
      8'h 82 : output_byte <= 8'h 13;
      8'h 83 : output_byte <= 8'h ec;
      8'h 84 : output_byte <= 8'h 5f;
      8'h 85 : output_byte <= 8'h 97;
      8'h 86 : output_byte <= 8'h 44;
      8'h 87 : output_byte <= 8'h 17;
      8'h 88 : output_byte <= 8'h c4;
      8'h 89 : output_byte <= 8'h a7;
      8'h 8a : output_byte <= 8'h 7e;
      8'h 8b : output_byte <= 8'h 3d;
      8'h 8c : output_byte <= 8'h 64;
      8'h 8d : output_byte <= 8'h 5d;
      8'h 8e : output_byte <= 8'h 19;
      8'h 8f : output_byte <= 8'h 73;
      8'h 90 : output_byte <= 8'h 60;
      8'h 91 : output_byte <= 8'h 81;
      8'h 92 : output_byte <= 8'h 4f;
      8'h 93 : output_byte <= 8'h dc;
      8'h 94 : output_byte <= 8'h 22;
      8'h 95 : output_byte <= 8'h 2a;
      8'h 96 : output_byte <= 8'h 90;
      8'h 97 : output_byte <= 8'h 88;
      8'h 98 : output_byte <= 8'h 46;
      8'h 99 : output_byte <= 8'h ee;
      8'h 9a : output_byte <= 8'h b8;
      8'h 9b : output_byte <= 8'h 14;
      8'h 9c : output_byte <= 8'h de;
      8'h 9d : output_byte <= 8'h 5e;
      8'h 9e : output_byte <= 8'h 0b;
      8'h 9f : output_byte <= 8'h db;
      8'h a0 : output_byte <= 8'h e0;
      8'h a1 : output_byte <= 8'h 32;
      8'h a2 : output_byte <= 8'h 3a;
      8'h a3 : output_byte <= 8'h 0a;
      8'h a4 : output_byte <= 8'h 49;
      8'h a5 : output_byte <= 8'h 06;
      8'h a6 : output_byte <= 8'h 24;
      8'h a7 : output_byte <= 8'h 5c;
      8'h a8 : output_byte <= 8'h c2;
      8'h a9 : output_byte <= 8'h d3;
      8'h aa : output_byte <= 8'h ac;
      8'h ab : output_byte <= 8'h 62;
      8'h ac : output_byte <= 8'h 91;
      8'h ad : output_byte <= 8'h 95;
      8'h ae : output_byte <= 8'h e4;
      8'h af : output_byte <= 8'h 79;
      8'h b0 : output_byte <= 8'h e7;
      8'h b1 : output_byte <= 8'h c8;
      8'h b2 : output_byte <= 8'h 37;
      8'h b3 : output_byte <= 8'h 6d;
      8'h b4 : output_byte <= 8'h 8d;
      8'h b5 : output_byte <= 8'h d5;
      8'h b6 : output_byte <= 8'h 4e;
      8'h b7 : output_byte <= 8'h a9;
      8'h b8 : output_byte <= 8'h 6c;
      8'h b9 : output_byte <= 8'h 56;
      8'h ba : output_byte <= 8'h f4;
      8'h bb : output_byte <= 8'h ea;
      8'h bc : output_byte <= 8'h 65;
      8'h bd : output_byte <= 8'h 7a;
      8'h be : output_byte <= 8'h ae;
      8'h bf : output_byte <= 8'h 08;
      8'h c0 : output_byte <= 8'h ba;
      8'h c1 : output_byte <= 8'h 78;
      8'h c2 : output_byte <= 8'h 25;
      8'h c3 : output_byte <= 8'h 2e;
      8'h c4 : output_byte <= 8'h 1c;
      8'h c5 : output_byte <= 8'h a6;
      8'h c6 : output_byte <= 8'h b4;
      8'h c7 : output_byte <= 8'h c6;
      8'h c8 : output_byte <= 8'h e8;
      8'h c9 : output_byte <= 8'h dd;
      8'h ca : output_byte <= 8'h 74;
      8'h cb : output_byte <= 8'h 1f;
      8'h cc : output_byte <= 8'h 4b;
      8'h cd : output_byte <= 8'h bd;
      8'h ce : output_byte <= 8'h 8b;
      8'h cf : output_byte <= 8'h 8a;
      8'h d0 : output_byte <= 8'h 70;
      8'h d1 : output_byte <= 8'h 3e;
      8'h d2 : output_byte <= 8'h b5;
      8'h d3 : output_byte <= 8'h 66;
      8'h d4 : output_byte <= 8'h 48;
      8'h d5 : output_byte <= 8'h 03;
      8'h d6 : output_byte <= 8'h f6;
      8'h d7 : output_byte <= 8'h 0e;
      8'h d8 : output_byte <= 8'h 61;
      8'h d9 : output_byte <= 8'h 35;
      8'h da : output_byte <= 8'h 57;
      8'h db : output_byte <= 8'h b9;
      8'h dc : output_byte <= 8'h 86;
      8'h dd : output_byte <= 8'h c1;
      8'h de : output_byte <= 8'h 1d;
      8'h df : output_byte <= 8'h 9e;
      8'h e0 : output_byte <= 8'h e1;
      8'h e1 : output_byte <= 8'h f8;
      8'h e2 : output_byte <= 8'h 98;
      8'h e3 : output_byte <= 8'h 11;
      8'h e4 : output_byte <= 8'h 69;
      8'h e5 : output_byte <= 8'h d9;
      8'h e6 : output_byte <= 8'h 8e;
      8'h e7 : output_byte <= 8'h 94;
      8'h e8 : output_byte <= 8'h 9b;
      8'h e9 : output_byte <= 8'h 1e;
      8'h ea : output_byte <= 8'h 87;
      8'h eb : output_byte <= 8'h e9;
      8'h ec : output_byte <= 8'h ce;
      8'h ed : output_byte <= 8'h 55;
      8'h ee : output_byte <= 8'h 28;
      8'h ef : output_byte <= 8'h df;
      8'h f0 : output_byte <= 8'h 8c;
      8'h f1 : output_byte <= 8'h a1;
      8'h f2 : output_byte <= 8'h 89;
      8'h f3 : output_byte <= 8'h 0d;
      8'h f4 : output_byte <= 8'h bf;
      8'h f5 : output_byte <= 8'h e6;
      8'h f6 : output_byte <= 8'h 42;
      8'h f7 : output_byte <= 8'h 68;
      8'h f8 : output_byte <= 8'h 41;
      8'h f9 : output_byte <= 8'h 99;
      8'h fa : output_byte <= 8'h 2d;
      8'h fb : output_byte <= 8'h 0f;
      8'h fc : output_byte <= 8'h b0;
      8'h fd : output_byte <= 8'h 54;
      8'h fe : output_byte <= 8'h bb;
      8'h ff : output_byte <= 8'h 16;
      default : output_byte <= 8'h 00;
    endcase
  end


endmodule
