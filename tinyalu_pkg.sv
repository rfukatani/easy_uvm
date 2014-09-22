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
package tinyalu_pkg;
   import uvm_pkg::*;
`include "uvm_macros.svh"
   
      typedef enum bit[2:0] {
                             no_op  = 3'b000,
                             add_op = 3'b001, 
                             and_op = 3'b010,
                             xor_op = 3'b011,
                             mul_op = 3'b100,
                             write_op= 3'b101,
                             read_op= 3'b110,
                             rst_op = 3'b111} operation_t;
      
`include "sequence_item.svh"   
typedef uvm_sequencer #(sequence_item) sequencer;
   
//`include "add_sequence_item.svh"
//`include "random_sequence.svh"
//`include "maxmult_sequence.svh"
`include "reset_sequence.svh"
//`include "runall_sequence.svh"
//`include "add_sequence.svh"
//`include "fibonacci_sequence.svh"
//`include "short_random_sequence.svh"
   
`include "reg_model.svh"
`include "result_transaction.svh"
`include "coverage.svh"
`include "scoreboard.svh"
`include "driver.svh"
`include "command_monitor.svh"
`include "result_monitor.svh"

`include "reg2drv_adapter.svh"   
`include "env.svh"
//`include "parallel_sequence.svh"

`include "tinyalu_base_test.svh"
//`include "full_test.svh"
//`include "fibonacci_test.svh"
//`include "parallel_test.svh"
`include "my_sequence.svh"
//`include "reg_sequence2.svh"
`include "reg_sequence3.svh"
`include "bin_reg_sequence.svh"
`include "reg_test.svh"
   


   
endpackage : tinyalu_pkg
   