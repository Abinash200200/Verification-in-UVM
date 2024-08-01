class driver extends uvm_driver#(seq_item);

  `uvm_component_utils(driver) // Macro for UVM component registration
  
  virtual alu_inf vif; // Virtual interface handle
  
  function new(string name, uvm_component parent); // Constructor with name and parent parameters
    super.new(name, parent);
  endfunction
  
  //////////////   BUILD PHASE   //////////////////////////////
  function void build_phase(uvm_phase phase); // Build phase function
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_inf)::get(this, "", "inn", vif)) // Get the virtual interface from the configuration database
      `uvm_fatal("No vif found", {"virtual interface must be set for: ", get_full_name(), ".vif"}); // Fatal error if vif is not found
  endfunction: build_phase
  
  //////////////   RUN PHASE   //////////////////////////////
  virtual task run_phase(uvm_phase phase); // Run phase task
    forever begin
      seq_item_port.get_next_item(req); // Get the next sequence item
      drive(); // Call the drive task
      seq_item_port.item_done(); // Indicate the item is done
    end
  endtask: run_phase
 
  //////////////   DRIVE() TASK   //////////////////////////////
  
  virtual task drive(); // Drive task to drive signals to the DUT
    @(posedge vif.clk); // Wait for a positive edge of the clock
    vif.A <= req.A; // Drive A to the virtual interface
    vif.B <= req.B; // Drive B to the virtual interface
    vif.sel <= req.sel; // Drive sel to the virtual interface
    repeat(2) @(posedge vif.clk); // Wait for two clock cycles
    req.Result <= vif.Result; // Capture the result from the virtual interface
  endtask: drive
  
endclass: driver
