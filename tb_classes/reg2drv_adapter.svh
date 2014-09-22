class reg2drv_adapter extends uvm_reg_adapter;

  `uvm_object_utils(reg2drv_adapter)


  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    string message;
    sequence_item cmd = sequence_item::type_id::create("sequence_item");
    
    //start_item(command);
    cmd.read = (rw.kind == UVM_READ) ? 1 : 0;
    cmd.B = rw.addr;
    cmd.A = rw.data;
    cmd.op = (rw.kind == UVM_READ) ? read_op : write_op;
    //finish_item(command);
    
    message = $sformatf("status:%0b,addr:%0h,data:%0h,OP:%s",rw.status,rw.addr,rw.data,cmd.op.name);
    `uvm_info("reg2drv/reg2bus",message,UVM_HIGH)
    
    return cmd;
  endfunction

  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    sequence_item cmd;
    string message;
    
    if (!$cast(cmd,bus_item)) begin
      `uvm_fatal("NOT_CMD_TYPE","Provided bus_item is not of the correct type")
      return;
    end
    
    rw.status = UVM_IS_OK;
    rw.kind = cmd.read ? UVM_READ : UVM_WRITE;
    rw.addr = cmd.B;
    rw.data = cmd.result;
    message = $sformatf("status:%0b,addr:%0h,data:%0h",rw.status,rw.addr,rw.data);
    `uvm_info("reg2drv/bus2reg",message,UVM_HIGH)
  endfunction


  function new(string name="reg2drv_adapter");
     super.new(name);
  endfunction

endclass
