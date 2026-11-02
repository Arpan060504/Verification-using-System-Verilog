class parent_class;

    virtual function void display();
        $display("Parent class");
    endfunction

endclass


class child_class extends parent_class;

    function void display();
        $display("Child class");
    endfunction

endclass


module tb;

    parent_class p_h;
    child_class c_h;

    initial begin

        // Create a child object
        c_h = new();

        // Upcasting: child handle -> parent handle
        p_h = c_h;

        p_h.display();

        // Downcasting: parent handle -> child handle
        if ($cast(c_h, p_h)) begin
            $display("Downcasting successful");
            c_h.display();
        end
        else begin
            $display("Downcasting failed");
        end

        $finish;

    end

endmodule