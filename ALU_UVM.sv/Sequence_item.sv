class seq_item extends uvm_sequence_item;
  
  rand bit [3:0] A;         // 4-bit random input A
  rand bit [3:0] B;         // 4-bit random input B
  randc bit [2:0] sel;      // 3-bit random cyclic selection input
  bit [3:0] Result;         // 4-bit output Result
  
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(A, UVM_ALL_ON)      // Macro to include A in UVM automation
  `uvm_field_int(B, UVM_ALL_ON)      // Macro to include B in UVM automation
  `uvm_field_int(sel, UVM_ALL_ON)    // Macro to include sel in UVM automation
  `uvm_field_int(Result, UVM_ALL_ON) // Macro to include Result in UVM automation
  `uvm_object_utils_end
  
  function new(string name = "seq_item"); // Constructor with default name
    super.new(name);
  endfunction
  
  constraint cons { B < A; }; // Constraint to ensure B is less than A
  
endclass
