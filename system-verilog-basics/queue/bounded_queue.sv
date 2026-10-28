module bounded_queue;
    int q[$:2];

    initial begin
        q.push_back(10);
        q.push_back(20);
        q.push_back(30);

        $display("Queue = %p", q);
        $display("Size = %0d", q.size());

        q.push_back(40);

        $display("Queue after 4th insertion = %p", q);
        $display("Size = %0d", q.size());

        $finish;
    end
endmodule