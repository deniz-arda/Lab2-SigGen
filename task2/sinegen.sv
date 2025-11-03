module sinegen #(
    parameter A_WIDTH = 8,
              D_WIDTH = 8
)(
    // interface signals
    input logic clk, // clock
    input logic rst, // reset
    input logic en, // enable
    input logic [D_WIDTH-1:0] incr, // increment for addr counter
    output logic [D_WIDTH-1:0] dout1,
    output logic [D_WIDTH-1:0] dout2 //output data
);

    logic [A_WIDTH-1:0] address; // interconnect wire

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (8'd3), // set the frequency of the sinusoidal waves constant
    .count (address)
);

rom2ports #(8, 8) sineRom (
    .clk (clk),
    .addr1 (address),
    .addr2 (address + incr), // increment controls the phase difference
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule
