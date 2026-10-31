class example;

    function void display();

        static int count = 0;

        count++;

        $display("Count = %0d", count);

    endfunction

endclass

module tb;

    example ex1;

    initial begin
        ex1 = new();

        ex1.display();
        ex1.display();
        ex1.display();

        $finish;
    end

endmodule