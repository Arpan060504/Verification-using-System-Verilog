class counter;

    static int count = 0;

    function void increment();
        count++;
    endfunction

endclass


module tb;

    counter c1, c2;

    initial begin

        c1 = new();
        c2 = new();

        c1.increment();
        c1.increment();
        c2.increment();

        $display("Count = %0d", counter::count);

    end

endmodule
/*
iverilog -g2012 -o sv_static_counter sv_static_counter.sv
if ($LASTEXITCODE -eq 0) { vvp .\sv_static_counter }
*/