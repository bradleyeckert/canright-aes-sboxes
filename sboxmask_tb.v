`timescale 1ns/1ps

module sbox_tb;

  reg  [7:0] A = 0;
// M, N are supposed to be uncorrelated random input and output masks.
  reg  [7:0] M = 0;
  reg  [7:0] N = 0;
  wire [7:0] S, Si;                     // actual, but still masked by N

// Instantiate the sboxes
  bSbox sbe((A^M), M, N, 1'b1, S);      // forward (encrypt)
  bSbox sbd((A^M), M, N, 1'b0, Si);     // inverse (decrypt)

  wire [7:0] actual_s = S ^ N;
  wire [7:0] actual_si = Si ^ N;
  reg [15:0] v;
  wire [7:0] s = v[15:8];               // expected
  wire [7:0] si = v[7:0];
  wire mismatch = (s != actual_s) || (si != actual_si);

  reg       CLK = 1'b1;
  always #5 CLK = ~CLK;

  reg [7:0] a;
  always @(posedge CLK) begin
    A <= A + 1;
    if (A == 8'hFF) begin
      N <= N + 1;
      M <= ~N + 3;
    end
  end

// A brute force search for errors would need 2^24 cycles (1.68 seconds).
// Rather than do that, M is derived from N and the run is 6.7 ms.
// The 2^16 cycle test resulted in 0 errors.

  integer errors = 0;
  initial
    begin
      $display("Starting testbench %m, checking for mismatch...");
      forever begin
        @(posedge CLK);
        if (mismatch) begin
          $display("A=%d: EXPECTED(%d,%d), ACTUAL(%d,%d, M=%d, N=%d ) at %t",
          A, s, si, actual_s, actual_si, M, N, $time);
          errors = errors + 1;
        end
      end
    end

// The golden values: a -> s:si
  always @* begin
    case(A)
    8'h00: v = 16'h6352;
    8'h01: v = 16'h7c09;
    8'h02: v = 16'h776a;
    8'h03: v = 16'h7bd5;
    8'h04: v = 16'hf230;
    8'h05: v = 16'h6b36;
    8'h06: v = 16'h6fa5;
    8'h07: v = 16'hc538;
    8'h08: v = 16'h30bf;
    8'h09: v = 16'h0140;
    8'h0a: v = 16'h67a3;
    8'h0b: v = 16'h2b9e;
    8'h0c: v = 16'hfe81;
    8'h0d: v = 16'hd7f3;
    8'h0e: v = 16'habd7;
    8'h0f: v = 16'h76fb;
    8'h10: v = 16'hca7c;
    8'h11: v = 16'h82e3;
    8'h12: v = 16'hc939;
    8'h13: v = 16'h7d82;
    8'h14: v = 16'hfa9b;
    8'h15: v = 16'h592f;
    8'h16: v = 16'h47ff;
    8'h17: v = 16'hf087;
    8'h18: v = 16'had34;
    8'h19: v = 16'hd48e;
    8'h1a: v = 16'ha243;
    8'h1b: v = 16'haf44;
    8'h1c: v = 16'h9cc4;
    8'h1d: v = 16'ha4de;
    8'h1e: v = 16'h72e9;
    8'h1f: v = 16'hc0cb;
    8'h20: v = 16'hb754;
    8'h21: v = 16'hfd7b;
    8'h22: v = 16'h9394;
    8'h23: v = 16'h2632;
    8'h24: v = 16'h36a6;
    8'h25: v = 16'h3fc2;
    8'h26: v = 16'hf723;
    8'h27: v = 16'hcc3d;
    8'h28: v = 16'h34ee;
    8'h29: v = 16'ha54c;
    8'h2a: v = 16'he595;
    8'h2b: v = 16'hf10b;
    8'h2c: v = 16'h7142;
    8'h2d: v = 16'hd8fa;
    8'h2e: v = 16'h31c3;
    8'h2f: v = 16'h154e;
    8'h30: v = 16'h0408;
    8'h31: v = 16'hc72e;
    8'h32: v = 16'h23a1;
    8'h33: v = 16'hc366;
    8'h34: v = 16'h1828;
    8'h35: v = 16'h96d9;
    8'h36: v = 16'h0524;
    8'h37: v = 16'h9ab2;
    8'h38: v = 16'h0776;
    8'h39: v = 16'h125b;
    8'h3a: v = 16'h80a2;
    8'h3b: v = 16'he249;
    8'h3c: v = 16'heb6d;
    8'h3d: v = 16'h278b;
    8'h3e: v = 16'hb2d1;
    8'h3f: v = 16'h7525;
    8'h40: v = 16'h0972;
    8'h41: v = 16'h83f8;
    8'h42: v = 16'h2cf6;
    8'h43: v = 16'h1a64;
    8'h44: v = 16'h1b86;
    8'h45: v = 16'h6e68;
    8'h46: v = 16'h5a98;
    8'h47: v = 16'ha016;
    8'h48: v = 16'h52d4;
    8'h49: v = 16'h3ba4;
    8'h4a: v = 16'hd65c;
    8'h4b: v = 16'hb3cc;
    8'h4c: v = 16'h295d;
    8'h4d: v = 16'he365;
    8'h4e: v = 16'h2fb6;
    8'h4f: v = 16'h8492;
    8'h50: v = 16'h536c;
    8'h51: v = 16'hd170;
    8'h52: v = 16'h0048;
    8'h53: v = 16'hed50;
    8'h54: v = 16'h20fd;
    8'h55: v = 16'hfced;
    8'h56: v = 16'hb1b9;
    8'h57: v = 16'h5bda;
    8'h58: v = 16'h6a5e;
    8'h59: v = 16'hcb15;
    8'h5a: v = 16'hbe46;
    8'h5b: v = 16'h3957;
    8'h5c: v = 16'h4aa7;
    8'h5d: v = 16'h4c8d;
    8'h5e: v = 16'h589d;
    8'h5f: v = 16'hcf84;
    8'h60: v = 16'hd090;
    8'h61: v = 16'hefd8;
    8'h62: v = 16'haaab;
    8'h63: v = 16'hfb00;
    8'h64: v = 16'h438c;
    8'h65: v = 16'h4dbc;
    8'h66: v = 16'h33d3;
    8'h67: v = 16'h850a;
    8'h68: v = 16'h45f7;
    8'h69: v = 16'hf9e4;
    8'h6a: v = 16'h0258;
    8'h6b: v = 16'h7f05;
    8'h6c: v = 16'h50b8;
    8'h6d: v = 16'h3cb3;
    8'h6e: v = 16'h9f45;
    8'h6f: v = 16'ha806;
    8'h70: v = 16'h51d0;
    8'h71: v = 16'ha32c;
    8'h72: v = 16'h401e;
    8'h73: v = 16'h8f8f;
    8'h74: v = 16'h92ca;
    8'h75: v = 16'h9d3f;
    8'h76: v = 16'h380f;
    8'h77: v = 16'hf502;
    8'h78: v = 16'hbcc1;
    8'h79: v = 16'hb6af;
    8'h7a: v = 16'hdabd;
    8'h7b: v = 16'h2103;
    8'h7c: v = 16'h1001;
    8'h7d: v = 16'hff13;
    8'h7e: v = 16'hf38a;
    8'h7f: v = 16'hd26b;
    8'h80: v = 16'hcd3a;
    8'h81: v = 16'h0c91;
    8'h82: v = 16'h1311;
    8'h83: v = 16'hec41;
    8'h84: v = 16'h5f4f;
    8'h85: v = 16'h9767;
    8'h86: v = 16'h44dc;
    8'h87: v = 16'h17ea;
    8'h88: v = 16'hc497;
    8'h89: v = 16'ha7f2;
    8'h8a: v = 16'h7ecf;
    8'h8b: v = 16'h3dce;
    8'h8c: v = 16'h64f0;
    8'h8d: v = 16'h5db4;
    8'h8e: v = 16'h19e6;
    8'h8f: v = 16'h7373;
    8'h90: v = 16'h6096;
    8'h91: v = 16'h81ac;
    8'h92: v = 16'h4f74;
    8'h93: v = 16'hdc22;
    8'h94: v = 16'h22e7;
    8'h95: v = 16'h2aad;
    8'h96: v = 16'h9035;
    8'h97: v = 16'h8885;
    8'h98: v = 16'h46e2;
    8'h99: v = 16'heef9;
    8'h9a: v = 16'hb837;
    8'h9b: v = 16'h14e8;
    8'h9c: v = 16'hde1c;
    8'h9d: v = 16'h5e75;
    8'h9e: v = 16'h0bdf;
    8'h9f: v = 16'hdb6e;
    8'ha0: v = 16'he047;
    8'ha1: v = 16'h32f1;
    8'ha2: v = 16'h3a1a;
    8'ha3: v = 16'h0a71;
    8'ha4: v = 16'h491d;
    8'ha5: v = 16'h0629;
    8'ha6: v = 16'h24c5;
    8'ha7: v = 16'h5c89;
    8'ha8: v = 16'hc26f;
    8'ha9: v = 16'hd3b7;
    8'haa: v = 16'hac62;
    8'hab: v = 16'h620e;
    8'hac: v = 16'h91aa;
    8'had: v = 16'h9518;
    8'hae: v = 16'he4be;
    8'haf: v = 16'h791b;
    8'hb0: v = 16'he7fc;
    8'hb1: v = 16'hc856;
    8'hb2: v = 16'h373e;
    8'hb3: v = 16'h6d4b;
    8'hb4: v = 16'h8dc6;
    8'hb5: v = 16'hd5d2;
    8'hb6: v = 16'h4e79;
    8'hb7: v = 16'ha920;
    8'hb8: v = 16'h6c9a;
    8'hb9: v = 16'h56db;
    8'hba: v = 16'hf4c0;
    8'hbb: v = 16'heafe;
    8'hbc: v = 16'h6578;
    8'hbd: v = 16'h7acd;
    8'hbe: v = 16'hae5a;
    8'hbf: v = 16'h08f4;
    8'hc0: v = 16'hba1f;
    8'hc1: v = 16'h78dd;
    8'hc2: v = 16'h25a8;
    8'hc3: v = 16'h2e33;
    8'hc4: v = 16'h1c88;
    8'hc5: v = 16'ha607;
    8'hc6: v = 16'hb4c7;
    8'hc7: v = 16'hc631;
    8'hc8: v = 16'he8b1;
    8'hc9: v = 16'hdd12;
    8'hca: v = 16'h7410;
    8'hcb: v = 16'h1f59;
    8'hcc: v = 16'h4b27;
    8'hcd: v = 16'hbd80;
    8'hce: v = 16'h8bec;
    8'hcf: v = 16'h8a5f;
    8'hd0: v = 16'h7060;
    8'hd1: v = 16'h3e51;
    8'hd2: v = 16'hb57f;
    8'hd3: v = 16'h66a9;
    8'hd4: v = 16'h4819;
    8'hd5: v = 16'h03b5;
    8'hd6: v = 16'hf64a;
    8'hd7: v = 16'h0e0d;
    8'hd8: v = 16'h612d;
    8'hd9: v = 16'h35e5;
    8'hda: v = 16'h577a;
    8'hdb: v = 16'hb99f;
    8'hdc: v = 16'h8693;
    8'hdd: v = 16'hc1c9;
    8'hde: v = 16'h1d9c;
    8'hdf: v = 16'h9eef;
    8'he0: v = 16'he1a0;
    8'he1: v = 16'hf8e0;
    8'he2: v = 16'h983b;
    8'he3: v = 16'h114d;
    8'he4: v = 16'h69ae;
    8'he5: v = 16'hd92a;
    8'he6: v = 16'h8ef5;
    8'he7: v = 16'h94b0;
    8'he8: v = 16'h9bc8;
    8'he9: v = 16'h1eeb;
    8'hea: v = 16'h87bb;
    8'heb: v = 16'he93c;
    8'hec: v = 16'hce83;
    8'hed: v = 16'h5553;
    8'hee: v = 16'h2899;
    8'hef: v = 16'hdf61;
    8'hf0: v = 16'h8c17;
    8'hf1: v = 16'ha12b;
    8'hf2: v = 16'h8904;
    8'hf3: v = 16'h0d7e;
    8'hf4: v = 16'hbfba;
    8'hf5: v = 16'he677;
    8'hf6: v = 16'h42d6;
    8'hf7: v = 16'h6826;
    8'hf8: v = 16'h41e1;
    8'hf9: v = 16'h9969;
    8'hfa: v = 16'h2d14;
    8'hfb: v = 16'h0f63;
    8'hfc: v = 16'hb055;
    8'hfd: v = 16'h5421;
    8'hfe: v = 16'hbb0c;
    8'hff: v = 16'h167d;
    default: v = 0;
    endcase
  end

endmodule

