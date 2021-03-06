// cpu types
`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns
import cpu_types_pkg::*;
module icaches_tb;
  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if ccif ();
  datapath_cache_if dcif ();

  // test program
  test PROG (CLK, nRST, dcif, ccif);

  // DUT
  `ifndef MAPPED
    icaches DUT(CLK, nRST,dcif, ccif);
  `endif

endmodule

program test (input logic CLK, output logic nRST, datapath_cache_if dcif, caches_if ccif);
  initial begin
  /*
    @(posedge CLK);
    nRST = 0;
    ruif.ihit = 0;
    ruif.dhit = 0;
    ruif.MemRead = 0;
    ruif.MemWrite = 0;
    ruif.halt = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);
  */
  @(posedge CLK);
  nRST = 0;
  dcif.imemaddr = 32'hFFFF;
  dcif.imemREN = 1;
  ccif.iwait = 1;
  ccif.iload = 32'hF0FF;
  @(posedge CLK);
  nRST = 1;
  @(posedge CLK);
  if(ccif.iREN == 1 && dcif.ihit == 0)
  begin
    $display("Test 1 Passed");
  end
  else begin
    $display("Test 1 Failed");
  end

  ccif.iwait = 0;
  @(posedge CLK);
  if (32'hF0FF == dcif.imemload)
   begin
    $display("Test 2 load instruction from MEM Passed");  
   end 
   else begin
    $display("Test 2 load instruction MEM Failed");
   end

  @(posedge CLK);
  nRST = 0;
  @(posedge CLK);
  nRST = 1;

  dcif.imemaddr = 32'hAAAA;
  dcif.imemREN = 1;
  ccif.iwait = 1;
  @(posedge CLK);
  if(ccif.iREN == 1 && dcif.ihit == 0)
  begin
    $display("Test 3 Passed");
  end
  else begin
    $display("Test 3 Failed");
  end

  @(posedge CLK);
  @(posedge CLK);
  @(posedge CLK);
  @(posedge CLK);
  @(posedge CLK);

  ccif.iload = 32'hAAA0;
  ccif.iwait = 0;
  @(posedge CLK);
  if (32'hAAA0 == dcif.imemload)
   begin
    $display("Test 4 load instruction from MEM Passed");  
   end 
   else begin
    $display("Test 4 load instruction from MEM Failed");
   end

  @(posedge CLK);
  dcif.imemaddr = 32'hAAAA;
  @(posedge CLK);
  if(ccif.iREN == 0 && 32'hAAA0 == dcif.imemload)
  begin
    $display("Test 5 load instruction from icache Passed");
  end
  else begin
    $display("Test 5 load instruction from icache Failed");
  end  
   

  end
endprogram
