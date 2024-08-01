`include "Sequence_items.sv"
`include "Sequencer.sv"
`include "Sequence.sv"
`include "Driver.sv"
`include "Monitor.sv"

class agent extends uvm_agent;

  `uvm_component_utils(agent) // Macro for UVM component registration
  
  sequencer alu_sqncr; // Sequencer for the ALU
  driver alu_driv; // Driver for the ALU
  monitor alu_mon; // Monitor for the ALU
  
  function new(string name, uvm_component parent); // Constructor with name and parent parameters
    super.new(name, parent);
  endfunction: new
  
  //////////////   BUILD PHASE   //////////////////////////////
  function void build_phase(uvm_phase phase); // Build phase function
    super.build_phase(phase);
    
    // Create instances of sequencer, driver, and monitor
    alu_sqncr = sequencer::type_id::create("alu_sqncr", this); // Create the sequencer
    alu_driv = driver::type_id::create("alu_driv", this); // Create the driver
    alu_mon = monitor::type_id::create("alu_mon", this); // Create the monitor
  endfunction: build_phase
  
  //////////////   CONNECT PHASE   //////////////////////////////
  function void connect_phase(uvm_phase phase); // Connect phase function
    alu_driv.seq_item_port.connect(alu_sqncr.seq_item_export); // Connect sequencer to driver
  endfunction: connect_phase
  
endclass: agent
