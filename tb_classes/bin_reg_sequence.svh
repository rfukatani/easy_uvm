/*
   Copyright 2013 Ray Salemi

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
class bin_reg_sequence extends uvm_reg_sequence #(my_sequence #(sequence_item));
   `uvm_object_utils(bin_reg_sequence);
   
   function new(string name = "reg");
      super.new(name);
   endfunction : new
   

   task body();
      uvm_reg_bit_bash_seq reg_seq;
      
      sequence_item command;
      reg_block_slave reg_model_h;
      uvm_reg_data_t write_data;
      uvm_reg_data_t read_data;
      uvm_status_e status;
      
      command = sequence_item::type_id::create("command");
      $cast(reg_model_h, this.reg_model_h);
         
      /* 2014.08.29
      start_item(command);
      command.op = rst_op;
      finish_item(command);
      */

      `uvm_info("REG", " starting reg sequence", UVM_LOW);
      
      write_data = 3;
      my_write(0,write_data);
      my_read(0,read_data);
      
      reg_seq = uvm_reg_bit_bash_seq::type_id::create("reg_single_bit_bash_seq");
      reg_seq.model = this.reg_model_h;
      reg_seq.start(null,this);
      
      
   endtask : body
endclass : bin_reg_sequence



