
module unpacked_1d;
    int array_1[0:2];
    int array_2[0:2];

    initial begin
        array_1[0] = 5;
        array_1[1] = -2;
        array_1[2] = 8;

        array_2[0] = 12;
        array_2[1] = 23;
        array_2[2] = 35;

        for (int i = 0; i < 3; i++) begin
            $display("index: %0d, array_1 = %0d, array_2 = %0d",
                     i, array_1[i], array_2[i]);
        end
    end
endmodule
