
class account_c1;

    int balance;

    // Function to return the current balance
    function int summary();
        return balance;
    endfunction

    // Task to deposit cash
    task deposit(int cash);
        balance = balance + cash;

        $display("Deposited = %0d, New balance = %0d",
                 cash, balance);
    endtask

endclass


module tb;

    account_c1 acc;

    initial begin

        // Create account object
        acc = new();

        // First deposit
        acc.deposit(2000);

        $display("Balance is %0d", acc.summary());
        $display("The value of balance is %0d", acc.balance);

        // Second deposit
        acc.deposit(2000);

        $display("Balance is %0d", acc.summary());
        $display("The value of balance is %0d", acc.balance);

        $finish;

    end

endmodule
/*
iverilog -g2012 -o sv_oop_account sv_oop_account.sv
if ($LASTEXITCODE -eq 0) { vvp .\sv_oop_account }
*/