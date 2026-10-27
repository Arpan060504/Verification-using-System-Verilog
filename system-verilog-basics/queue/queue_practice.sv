module queue_practice;
    int q[$];
    int value;

    initial begin
        q.push_back(10);
        q.push_back(20);
        q.push_back(30);

        $display("Queue after insertion:");
        foreach (q[i])
            $display("q[%0d] = %0d", i, q[i]);

        $display("Queue size = %0d", q.size());

        value = q.pop_front();
        $display("Removed from front = %0d", value);

        $display("Queue after pop_front:");
        foreach (q[i])
            $display("q[%0d] = %0d", i, q[i]);

        value = q.pop_back();
        $display("Removed from back = %0d", value);

        $display("Queue after pop_back:");
        foreach (q[i])
            $display("q[%0d] = %0d", i, q[i]);

        $finish;
    end
endmodule