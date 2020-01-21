// This module can be used to test the behavior of the branch predictors
// the module can be modified to test more than one predictor at the same time. 
// A text file named "Outcomes.txt" is needed to provide the branch ID and the 
// input correct outcome results to the predictors. 
// You may modify this testbench to run all tests at the same time, or create three 
// versions to test the three implemenation 
// The testbench displaye the total number of misses by the tested predictor. 

module OneBitTB();
reg clk, reset, outcome;
reg [2:0] pc;

reg [15:0] onebit_misses;

wire miss;

integer fid, Temp;

always #5 clk=~clk;                             // create a free running clock

FourBitBP Pred1(.clk(clk), .branchID(pc), .outcome(outcome), .reset(reset), .miss(miss));    // instintiate the UUT

initial begin  
 
pc=3'b000;                                      // a procedure used to initialize all variables
clk=0;
reset=0;
outcome=0;
onebit_misses = 16'h0000;


fid= $fopen("Outcomes.txt", "r");               // open a file containing the outcomes

wait(clk)
reset=1;
#50 reset=0;

while (! $feof(fid)) begin                      // run the while loop until you reach the end of the file

@(posedge clk);                                // after each posedge of the clock read one line of from the file

Temp = $fscanf(fid, "%d %d \n", pc, outcome);

@(negedge clk);
onebit_misses=onebit_misses + miss;            // increment the total number of misses if applicable

if ($feof(fid)) begin
$fclose(fid);
#2000 $stop;
end 

end
end



endmodule 





