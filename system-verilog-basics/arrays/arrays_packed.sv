
module arrays_packed;
    logic [7:0] data;

    initial begin
        data = 8'b10110010;

        $display("Binary = %b", data);
        $display("Hex    = %h", data);
        $display("Bit 7  = %b", data[7]);
        $display("Bit 0  = %b", data[0]);
    end
endmodule
