module ALU(
  input logic clk, 
  input logic reset,
  input logic [3:0] A, B, 
  output logic [3:0] Result,
  input logic [2:0] sel
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    Result <= 4'b0000; // Clear Result to 0 on reset
  end else begin
    case (sel)
      3'b000: Result <= A + B;        // Add
      3'b001: Result <= A + (~B + 1); // Subtract
      3'b010: Result <= A & B;        // AND
      3'b011: Result <= A | B;        // OR
      3'b100: Result <= A * B;        // Multiply
      3'b101: Result <= A ^ B;        // XOR
      3'b110: Result <= ~(A & B);     // NAND
      3'b111: Result <= ~(A | B);     // NOR
      default: $display("INVALID INPUT SELECTED");
    endcase
  end
end

endmodule
