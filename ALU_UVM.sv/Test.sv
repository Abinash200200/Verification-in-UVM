`include "Environment.sv" // Include the environment class definition

class test extends uvm_test; // Test class extending uvm_test
  `uvm_component_utils(test) // UVM component registration macro
  
  alu_sequence seq; // Sequence instance
  env ENV; // Environment instance
  
  function new(string name = "test", uvm_component parent = null); // Constructor with default name and parent
    super.new(name, parent);
  endfunction: new
  
  virtual function void build_phase(uvm_phase phase); // Build phase function
    super.build_phase(phase);
    
    seq = alu_sequence::type_id::create("seq"); // Create sequence instance
    ENV = env::type_id::create("ENV", this); // Create environment instance
  endfunction : build_phase
  
  task run_phase(uvm_phase phase); // Run phase task
    phase.raise_objection(this); // Raise objection to indicate test is running
    
    seq.start(ENV.agnt.alu_sqncr); // Start the sequence with the sequencer from the environment
    
    phase.drop_objection(this); // Drop objection to indicate test is finished
  endtask: run_phase
  
endclass: test
