class example;

    static int count = 0;

    function void increment();
        count++;
    endfunction

endclass

module tb;

    example ex1, ex2;

    initial begin
        ex1 = new();
        ex2 = new();

        ex1.increment();
        $display("Count = %0d", example::count);

        ex2.increment();
        $display("Count = %0d", example::count);

        $finish;
    end

endmodule