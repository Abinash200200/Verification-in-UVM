class monitor extends uvm_monitor;

  `uvm_component_utils(monitor) // Macro for UVM component registration
  
  virtual alu_inf vif; // Virtual interface handle
  uvm_analysis_port#(seq_item) item_collected_port; // Analysis port for seq_item
  seq_item seq_collected; // Sequence item to collect data
  
  function new(string name, uvm_component parent); // Constructor with name and parent parameters
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this); // Initialize the analysis port
    seq_collected = new(); // Initialize the sequence item
  endfunction: new
  
  //////////////   BUILD PHASE   //////////////////////////////
  function void build_phase(uvm_phase phase); // Build phase function
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_inf)::get(this, "", "inn", vif)) // Get the virtual interface from the configuration database
      `uvm_fatal("No vif found", {"virtual interface must be set for: ", get_full_name(), ".vif"}); // Fatal error if vif is not found
  endfunction: build_phase
    
  //////////////   RUN PHASE   //////////////////////////////
  virtual task run_phase(uvm_phase phase); // Run phase task
    forever begin
      @(posedge vif.clk); // Wait for a positive edge of the clock
      seq_collected.A = vif.A; // Collect A from the virtual interface
      seq_collected.B = vif.B; // Collect B from the virtual interface
      seq_collected.sel = vif.sel; // Collect sel from the virtual interface
        
      @(posedge vif.clk); // Wait for the next positive edge of the clock
      seq_collected.Result = vif.Result; // Collect Result from the virtual interface
      $display("Values in seq_collected in monitor"); // Display message for debugging
      seq_collected.print(); // Print the collected sequence item
      @(posedge vif.clk); // Wait for the next positive edge of the clock
      $cast(item_collected, seq_collected.clone()); // Clone the collected sequence item
      item_collected_port.write(item_collected); // Write the collected item to the analysis port
    end
  endtask: run_phase
  
endclass: monitor
