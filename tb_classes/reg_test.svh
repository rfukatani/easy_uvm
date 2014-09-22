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
class reg_test extends tinyalu_base_test;
   `uvm_component_utils(reg_test);


   function new(string name, uvm_component parent);
      super.new(name,parent);
      
      //seq_h = new("seq_h");
   endfunction : new

   task run_phase(uvm_phase phase);
      uvm_coreservice_t cs_ = uvm_coreservice_t::get();
      env env_h;
      
      phase.raise_objection(this);
      
      //todo
      $cast(env_h, uvm_top.find("*.env_h"));
      
      begin
         reset_sequence rst_seq;
         rst_seq = reset_sequence::type_id::create("rst_seq", this);
         rst_seq.start(sequencer_h);
      end
      
      env_h.reg_model_h.reset();
      
      begin
         uvm_cmdline_processor opts = uvm_cmdline_processor::get_inst();
         my_sequence #(sequence_item) seq_h;
         

         string            seq_name;
	 uvm_factory factory;
	 string args[$];//for debug

	 factory = cs_.get_factory();
         void'(opts.get_arg_value("+UVM_MY_SEQ=", seq_name));
         
         
         //because no dpi
         //seq_name = "reg_sequence3";
         seq_name = "bin_reg_sequence";

         `uvm_info("REG_TEST",$sformatf("seq name:%s",seq_name),UVM_MEDIUM)
         
         
         if (!$cast(seq_h, factory.create_object_by_name(seq_name,
                                                       get_full_name(),
                                                       "seq_h"))
             || seq_h == null) begin
            `uvm_fatal("TEST/CMD/BADSEQ", {"Sequence ", seq_name,
                                           " is not a known sequence"})
         end
         
         seq_h.reg_model_h = env_h.reg_model_h;
         seq_h.start(sequencer_h);
      end
            
      phase.drop_objection(this);
   endtask : run_phase

endclass


