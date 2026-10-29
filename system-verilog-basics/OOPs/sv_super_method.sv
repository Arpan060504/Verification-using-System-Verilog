class parent;

    int data_p;

    function new(int value);
        data_p = value;
    endfunction

    function void display();
        $display("Parent: data_p = %0d", data_p);
    endfunction

endclass


class child extends parent;

    int data_c;

    function new(int p_value, int c_value);

        super.new(p_value);

        data_c = c_value;

    endfunction

    function void display();

        $display("Child: data_c = %0d", data_c);

        super.display();

    endfunction

endclass


module tb;

    child c_h;

    initial begin

        c_h = new(10, 20);

        c_h.display();

        $finish;

    end

endmodule
/*
iverilog -g2012 -o sv_super_method sv_super_method.sv
if ($LASTEXITCODE -eq 0) { vvp .\sv_super_method }
*/