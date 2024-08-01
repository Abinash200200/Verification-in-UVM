`include "Agent.sv"
`include "Scoreboard.sv"

class env extends uvm_env;
  
  agent agnt; // Instance of the agent
  scoreboard scb; // Instance of the scoreboard
  
  `uvm_component_utils(env) // Macro for UVM component registration
  
  function new(string name, uvm_component parent); // Constructor with name and parent parameters
    super.new(name, parent);
  endfunction: new
 
  //////////////////BUILD PHASE////////////////////
  function void build_phase(uvm_phase phase); // Build phase function
    super.build_phase(phase);
    
    agnt = agent::type_id::create("agnt", this); // Create the agent
    scb = scoreboard::type_id::create("scb", this); // Create the scoreboard
  endfunction: build_phase
  
  //////////////CONNECT PHASE///////////////////////
  function void connect_phase(uvm_phase phase); // Connect phase function
    agnt.alu_mon.item_collected_port.connect(scb.item_collected.analysis_export); // Connect the monitor's analysis port to the scoreboard's analysis export
  endfunction: connect_phase
    
endclass: env
