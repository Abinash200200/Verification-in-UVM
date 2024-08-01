`include "uvm_macros.svh" // UVM macros
import uvm_pkg::*; // Import UVM package
`include "Interface.sv" // Include the interface definition
`include "Test.sv" // Include the test definition

module tbench_top; // Testbench top module

  //clock and reset signal declaration
  bit clk; // Clock signal
  bit reset; // Reset signal

  //clock generation
  always #5 clk = ~clk; // Clock generation with period of 10 time units

  //reset Generation
  initial begin
    reset = 1; // Assert reset
    #5 reset = 0; // Deassert reset after 5 time units
  end
  
  alu_inf intf(clk, reset); // Instantiate the virtual interface

  ALU DUT (
    .clk(intf.clk), // Connect DUT clock to interface clock
    .reset(intf.reset), // Connect DUT reset to interface reset
    .A(intf.A), // Connect DUT input A to interface A
    .B(intf.B), // Connect DUT input B to interface B
    .Result(intf.Result), // Connect DUT result to interface result
    .sel(intf.sel) // Connect DUT select signal to interface select
  );
  
  initial begin
    uvm_config_db#(virtual alu_inf)::set(null, "*", "inn", intf); // Set the virtual interface in UVM configuration database
    $dumpfile("dump.vcd"); // Set up VCD dump file
    $dumpvars; // Dump all variables
  end
  
  initial begin
    run_test("test"); // Run the test named "test"
  end
endmodule: tbench_top
