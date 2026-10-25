module dynamic_resize;
    int arr[];

    initial begin
        arr = new[3];
        arr[0] = 10;
        arr[1] = 20;
        arr[2] = 30;

        arr = new[5](arr);

        $display("Size = %0d", arr.size());
        foreach (arr[i])
            $display("arr[%0d] = %0d", i, arr[i]);

        $finish;
    end
endmodule