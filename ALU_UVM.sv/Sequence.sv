class alu_sequence extends uvm_sequence#(seq_item);

  `uvm_object_utils(alu_sequence) // Macro for UVM object registration

  function new(string name = "alu_sequence"); // Constructor with default name
    super.new(name);
  endfunction

  virtual task body(); // The main sequence task
    repeat(20) begin
      req = seq_item::type_id::create("req"); // Create a new sequence item of type seq_item
      start_item(req);                        // Start the sequence item
      assert(req.randomize());                // Randomize the sequence item and assert success
      finish_item(req);                       // Finish the sequence item
    end
  endtask
  
endclass
