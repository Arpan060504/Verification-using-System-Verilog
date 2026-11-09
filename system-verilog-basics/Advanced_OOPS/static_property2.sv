class example;

    static int data = 0;

    function static void display();
        data++;
        $display("Data = %0d", data);
    endfunction

endclass

module tb;

    initial begin
        example::display();
        example::display();

        $finish;
    end

endmodule