
module associative_array_revision;

    // Associative array: integer key -> integer value
    int data[int];

    // Variable used by first(), last(), next(), prev()
    int index;

    initial begin

        // ----------------------------------
        // 1. INSERT / STORE ELEMENTS
        // ----------------------------------
        data[10] = 100;
        data[20] = 200;
        data[30] = 300;
        data[40] = 400;

        $display("=== Initial Associative Array ===");

        // Display all entries
        foreach (data[key])
            $display("data[%0d] = %0d", key, data[key]);

        // ----------------------------------
        // 2. ACCESS AN ELEMENT
        // ----------------------------------
        $display("\nValue at key 20 = %0d", data[20]);

        // ----------------------------------
        // 3. CHECK WHETHER A KEY EXISTS
        // ----------------------------------
        if (data.exists(30))
            $display("Key 30 exists");

        if (!data.exists(50))
            $display("Key 50 does not exist");

        // ----------------------------------
        // 4. NUMBER OF ELEMENTS
        // ----------------------------------
        $display("\nNumber of entries = %0d", data.num());

        // ----------------------------------
        // 5. FIRST AND LAST KEY
        // ----------------------------------
        if (data.first(index))
            $display("First key = %0d", index);

        if (data.last(index))
            $display("Last key = %0d", index);

        // ----------------------------------
        // 6. NEXT KEY
        // ----------------------------------
        index = 20;

        if (data.next(index))
            $display("Next key after 20 = %0d", index);

        // ----------------------------------
        // 7. PREVIOUS KEY
        // ----------------------------------
        index = 30;

        if (data.prev(index))
            $display("Previous key before 30 = %0d", index);

        // ----------------------------------
        // 8. DELETE ONE ENTRY
        // ----------------------------------
        data.delete(20);

        $display("\n=== After deleting key 20 ===");

        foreach (data[key])
            $display("data[%0d] = %0d", key, data[key]);

        $display("Number of entries = %0d", data.num());

        // ----------------------------------
        // 9. DELETE ENTIRE ARRAY
        // ----------------------------------
        data.delete();

        $display("\nNumber of entries after delete = %0d",
                 data.num());

        $finish;
    end

endmodule
/*
iverilog -g2012 -o associative_array_revision associative_array_revision.sv
if ($LASTEXITCODE -eq 0) { vvp .\associative_array_revision }
*/