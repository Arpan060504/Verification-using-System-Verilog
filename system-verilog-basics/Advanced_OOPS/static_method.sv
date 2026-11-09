class example;

    static function void display();
        $display("Static method called!");
    endfunction

endclass

module tb;

    initial begin
        example::display();  // Call using class name

        $finish;
    end

endmodule