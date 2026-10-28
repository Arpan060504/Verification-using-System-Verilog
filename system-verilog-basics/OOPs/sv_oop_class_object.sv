// Class 1: Processor
class Processor;

    // Properties
    int id;
    int frequency;

    // Constructor
    function new(int id_arg, int frequency_arg);
    id = id_arg;
    frequency = frequency_arg;
endfunction

    // Method
    function new(int capacity_arg);
    capacity = capacity_arg;
endfunction

endclass


// Class 2: Memory
class Memory;

    // Property
    int capacity;

    // Constructor
    function new(int capacity);
        this.capacity = capacity;
    endfunction

    // Method
    function void display();
        $display("Memory Capacity = %0d MB", capacity);
    endfunction

endclass


// Testbench
module tb;

    // Handles
    Processor cpu1;
    Processor cpu2;
    Memory mem1;

    initial begin

        // Create objects
        cpu1 = new(1, 1000);
        cpu2 = new(2, 2000);
        mem1 = new(4096);

        // Display object properties
        $display("----- Processor 1 -----");
        cpu1.display();

        $display("----- Processor 2 -----");
        cpu2.display();

        $display("----- Memory -----");
        mem1.display();

        $finish;

    end

endmodule
