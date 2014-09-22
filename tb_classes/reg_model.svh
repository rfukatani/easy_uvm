//–¢ŽÀ‘•

//
//------------------------------------------------------------------------------
//   Copyright 2011 Mentor Graphics Corporation
//   Copyright 2011 Synopsys, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//------------------------------------------------------------------------------

`ifndef REG_SLAVE
`define REG_SLAVE

class reg_slave_SESSION extends uvm_reg;

   rand uvm_reg_field value;
   
   function new(string name = "slave_SESSION");
      super.new(name,32,UVM_CVR_ALL);
   endfunction: new

   virtual function void build();
      this.value = uvm_reg_field::type_id::create("value");
      this.value.configure(this, 8, 0, "RW", 0, 32'h0, 1, 0, 1);
   endfunction

   
   `uvm_object_utils(reg_slave_SESSION)
   
   /*function void configure(
   		uvm_reg 	parent,
   	int 	unsigned 	size,
   	int 	unsigned 	lsb_pos,
   		string 	access,
   		bit 	volatile,
   		uvm_reg_data_t 	reset,
   		bit 	has_reset,
   		bit 	is_rand,
   		bit 	individually_accessible)
	*/
   
endclass


class mem_slave_DMA_RAM extends uvm_mem;

   function new(string name = "slave_DMA_RAM");
      super.new(name,'h400,32,"RW",UVM_CVR_ALL);
   endfunction
   
   `uvm_object_utils(mem_slave_DMA_RAM)
   
endclass


class reg_block_slave extends uvm_reg_block;

   rand reg_slave_SESSION  SESSION[4];
   
   mem_slave_DMA_RAM  DMA_RAM;

   
   function new(string name = "slave");
      super.new(name,UVM_CVR_ALL);
   endfunction

   virtual function void build();

      // create
      foreach (SESSION[i])
         SESSION[i] = reg_slave_SESSION::type_id::create($sformatf("SESSION[%0d]",i));
      //DMA_RAM   = mem_slave_DMA_RAM::type_id::create("DMA_RAM");

      // configure
      foreach (SESSION[i]) begin
         SESSION[i].configure(this,null,$sformatf("SESSION[%0d]",i));
         SESSION[i].build();
      end
      
      // the SV LRM IEEE2009 is not clear if an array of class handles can be assigned to another array if the element types 
      // are assignment compatible OR if the LRM states the element types have to be 'equal' (the LRM states equal types)
      // IUS requires per LRM 'equivalent' element types and does not accept assignment compatible types

      
      //DMA_RAM.configure(this,"");

      // define default map
      default_map = create_map("default_map", 'h0, 4, UVM_LITTLE_ENDIAN);

       foreach (SESSION[i])
         default_map.add_reg(SESSION[i],i,"RW");


      //default_map.add_mem(DMA_RAM, 'h2000, "RW");
      
   endfunction
   
   `uvm_object_utils(reg_block_slave)
   
endclass : reg_block_slave


`endif
