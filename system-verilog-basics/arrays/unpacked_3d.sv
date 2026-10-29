
module unpacked_3d;
    logic [7:0] mem [0:1][0:1][0:2];

    initial begin
        for (int b = 0; b < 2; b++) begin
            for (int r = 0; r < 2; r++) begin
                for (int c = 0; c < 3; c++) begin
                    mem[b][r][c] = b * 100 + r * 10 + c;

                    $display("mem[%0d][%0d][%0d] = %0d",
                             b, r, c, mem[b][r][c]);
                end
            end
        end
    end
endmodule
