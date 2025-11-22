module add(a, b, sum,clk,c,d,P);
  input [7:0] a, b;
  input [17:0] c,d;
  input clk;
  output [8:0] sum;
  output [35:0] P;
 
 c_addsub_0 addsub_0 (
  .A(a),      // input wire [7 : 0] A
  .B(b),      // input wire [7 : 0] B
  .CLK(clk),  // input wire CLK
  .CE(1'b1),    // input wire CE
  .S(sum)      // output wire [8 : 0] S
); 
mult_gen_0 your_instance_name (
  .CLK(clk),  // input wire CLK
  .A(c),      // input wire [17 : 0] A
  .B(d),      // input wire [17 : 0] B
  .P(P)      // output wire [35 : 0] P
);
endmodule