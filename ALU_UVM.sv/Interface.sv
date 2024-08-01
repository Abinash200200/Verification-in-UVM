interface alu_inf(
  input logic clk,   // Clock signal
  input logic reset  // Reset signal
);

  logic [3:0] A;      // 4-bit input A
  logic [3:0] B;      // 4-bit input B
  logic [2:0] sel;    // 3-bit selection input
  logic [3:0] Result; // 4-bit output Result
      
endinterface
