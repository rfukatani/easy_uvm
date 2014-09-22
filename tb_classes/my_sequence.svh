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
class my_sequence #(type REQ = uvm_sequence_item,type RSP = REQ) extends uvm_reg_sequence #(uvm_sequence #(REQ));
   `uvm_object_utils(my_sequence);
   reg_block_slave reg_model_h;
   
   function new(string name = "reg");
      super.new(name);
   endfunction : new
   

   virtual task body();
   endtask : body
   
   
   task my_read(int addr,ref uvm_reg_data_t data);
      uvm_status_e status;

      $display("\ndesired value:%0d@before read",reg_model_h.SESSION[0].get());
      reg_model_h.SESSION[addr].read(status, data);
      $display("READ:%0d,STATUS:%0b",data,status);
      $display("desired value:%0d@after read\n",reg_model_h.SESSION[0].get());
   endtask
   
   task my_write(int addr,uvm_reg_data_t data);
      uvm_status_e status;

      $display("\ndesired value:%0d@before write",reg_model_h.SESSION[0].get());
      reg_model_h.SESSION[addr].write(status, data, .parent(this));
      $display("WROTE:%0d,STATUS:%0b",data,status);
      $display("desired value:%0d@after write\n",reg_model_h.SESSION[0].get());
   endtask
   
endclass : my_sequence



