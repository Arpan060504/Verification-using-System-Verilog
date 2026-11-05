class parent_class;

    virtual function void drive();
        $display("Driving from parent");
    endfunction

endclass


class child_class1 extends parent_class;

    function void drive();
        $display("Driving from child 1");
    endfunction

endclass


class child_class2 extends parent_class;

    function void drive();
        $display("Driving from child 2");
    endfunction

endclass


module tb;

    parent_class p_h;
    child_class1 c1_h;
    child_class2 c2_h;

    initial begin

        p_h = new();
        p_h.drive();

        c1_h = new();
        p_h = c1_h;
        p_h.drive();

        c2_h = new();
        p_h = c2_h;
        p_h.drive();

        $finish;

    end

endmodule