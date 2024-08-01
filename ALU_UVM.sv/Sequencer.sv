class sequencer extends uvm_sequencer#(seq_item);

  `uvm_component_utils(sequencer) // Macro for UVM component registration

  function new(string name, uvm_component parent); // Constructor with name and parent parameters
    super.new(name, parent);
  endfunction
  
endclass
