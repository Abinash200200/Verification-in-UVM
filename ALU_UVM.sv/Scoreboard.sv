class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard) // Macro for UVM component registration
  
  uvm_tlm_analysis_fifo#(seq_item) item_collected; // FIFO for collecting sequence items
  seq_item seq; // Sequence item for storing collected data
  
  function new(string name, uvm_component parent); // Constructor with name and parent parameters
    super.new(name, parent);
  endfunction: new
  
  //////////////////BUILD PHASE////////////////////
  function void build_phase(uvm_phase phase); // Build phase function
    super.build_phase(phase);
    item_collected = new("item_collected", this); // Initialize the FIFO
  endfunction: build_phase
  
  ///////////// RUN PHASE////////////////////////////
  virtual task run_phase(uvm_phase phase); // Run phase task
    forever begin
      item_collected.get(seq); // Get the sequence item from the FIFO
      
      // Check operation based on 'sel' signal and compare results
      case (seq.sel)
        3'b000: // Add
          if (seq.A + seq.B == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of SUM = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end
        
        3'b001: // Subtract
          if (seq.A + (~seq.B + 1) == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of DIFFERENCE = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end
        
        3'b010: // AND
          if (seq.A & seq.B == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A & B = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end
        
        3'b011: // OR
          if (seq.A | seq.B == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A | B = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end
        
        3'b100: // Multiply
          if (seq.A * seq.B == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of PRODUCT = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end
        
        3'b101: // XOR
          if (seq.A ^ seq.B == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A xor B = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end

        3'b110: // NAND
          if (~(seq.A & seq.B) == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A nand B = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end

        3'b111: // NOR
          if (~(seq.A | seq.B) == seq.Result) begin
            $display("------------------------SCOREBOARD-----------------------------------------");
            `uvm_info(get_type_name(), $sformatf(" TEST PASS "), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A = %0d", seq.A), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of B = %0d", seq.B), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf(" Value of A nor B = %0d", seq.Result), UVM_LOW)
            $display("-----------------------------------------------------------------------------");
          end else begin
            `uvm_info(get_type_name(), $sformatf(" TEST FAILED "), UVM_LOW)
          end

        default: // Handle unexpected cases
          `uvm_info(get_type_name(), $sformatf(" DEFAULT VALUE IS INITIATED "), UVM_LOW)
      endcase
    end
  endtask : run_phase
endclass : scoreboard
