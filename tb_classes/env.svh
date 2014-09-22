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

class env extends uvm_env;
   `uvm_component_utils(env);

   sequencer       sequencer_h;
   coverage        coverage_h;
   scoreboard      scoreboard_h;
   driver          driver_h;
   command_monitor command_monitor_h;
   result_monitor  result_monitor_h;
   reg_block_slave reg_model_h;//2014.08.28
   
   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      // stimulus
      sequencer_h  = new("sequencer_h",this);
      driver_h     = driver::type_id::create("driver_h",this);
      // monitors
      command_monitor_h    = command_monitor::type_id::create("command_monitor_h",this);
      result_monitor_h = result_monitor::type_id::create("result_monitor",this);
      // analysis
      coverage_h    = coverage::type_id::create ("coverage_h",this);
      scoreboard_h  = scoreboard::type_id::create("scoreboard",this);
      
      
      //2014.08.28
      if (reg_model_h == null) begin
            reg_model_h = reg_block_slave::type_id::create("reg_model_h",this);
            reg_model_h.build();
            reg_model_h.lock_model();
      end
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      reg2drv_adapter reg2drv = new;
      reg_model_h.default_map.set_sequencer(sequencer_h, reg2drv);//mapとのシークエンサーのコネクト
      reg_model_h.default_map.set_auto_predict(1);//implicit predicr
      
      driver_h.seq_item_port.connect(sequencer_h.seq_item_export);

      command_monitor_h.ap.connect(coverage_h.analysis_export);
      command_monitor_h.ap.connect(scoreboard_h.cmd_f.analysis_export);
      result_monitor_h.ap.connect(scoreboard_h.analysis_export);
      scoreboard_h.reg_model_h = reg_model_h;
   endfunction : connect_phase
   
   //2014.08.28
   function void end_of_elaboration();
        reg_model_h.print();
   endfunction

endclass : env


   