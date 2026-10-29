
module dynamic_array1;
    int dyn1[], dyn2[];

    initial begin
        dyn1 = new[5];
        dyn1 = '{1, 2, 3, 4, 5};

        dyn2 = dyn1;

        $display("dyn1:");
        foreach (dyn1[i])
            $display("dyn1[%0d] = %0d", i, dyn1[i]);

        dyn2 = '{5, 6, 7, 8, 9};

        // Resize dyn2 to 11 elements, preserving existing values
        dyn2 = new[11](dyn2);

        $display("\ndyn2 after resizing:");
        foreach (dyn2[i])
            $display("dyn2[%0d] = %0d", i, dyn2[i]);

        $display("Size of dyn2 = %0d", dyn2.size());

        // Delete all elements
        dyn2.delete();

        $display("Size after deletion = %0d", dyn2.size());

        $finish;
    end
endmodule

/*
iverilog -g2012 -o dynamic_array1 dynamic_array1.sv
if ($LASTEXITCODE -eq 0) { vvp .\dynamic_array1 }
 */