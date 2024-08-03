module testb();

reg clk,arstn,transaction , time_up ;
reg [1:0]destination,ticket_count;
reg [7:0]Input_money ;
wire [1:0]ticket_out ,count;
wire [7:0]refund,change;
wire done;

Top dut(clk, arstn, transaction,destination, ticket_count,Input_money, ticket_out, count ,refund, change ,done);

 always #5 clk = ~clk;
 
 task reset(); begin
    arstn = 0;
    {clk,destination,Input_money,transaction,time_up,ticket_count} = 0;
    #5;
    arstn = 1;
    end
 endtask
 
 initial begin
    reset;
    destination = 2;
    ticket_count=3;
    transaction = 1;
    Input_money = 100;
   repeat(2) 
    @(posedge clk) transaction = 0;
 end
 
 initial begin
    #500000
        $finish; 
 end
endmodule