
module unpacked_2d;

    logic [7:0] matrix [0:1][0:2];
    integer r, c;

    initial begin
        for (r = 0; r < 2; r = r + 1) begin
            for (c = 0; c < 3; c = c + 1) begin
                matrix[r][c] = r * 10 + c;
            end
        end

        for (r = 0; r < 2; r = r + 1) begin
            for (c = 0; c < 3; c = c + 1) begin
                $display("matrix[%0d][%0d] = %0d",
                         r, c, matrix[r][c]);
            end
        end
    end

endmodule
/*
iverilog -g2012 -o sim2 unpacked_2d.sv
if ($LASTEXITCODE -eq 0) { vvp .\sim2 }
*/