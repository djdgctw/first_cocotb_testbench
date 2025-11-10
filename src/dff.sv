`timescale 1us/1ns

module dff (
    output logic [3:0]q,
    input logic clk, [3:0]d
);

always @(posedge clk) begin
    q <= d;
end

endmodule