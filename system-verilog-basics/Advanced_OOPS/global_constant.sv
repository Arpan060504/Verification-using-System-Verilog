package my_pkg;

    // Global constant
    parameter int MAX_SIZE = 100;

endpackage


module tb;

    initial begin
        $display("Maximum size = %0d", my_pkg::MAX_SIZE);

        $finish;
    end

endmodule