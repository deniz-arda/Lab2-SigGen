module sigdelay #(
    parameter A_WIDTH = 9,
              D_WIDTH = 8  
)(
    input  logic rst,
    input  logic wr,
    input  logic rd,
    input  logic clk,
    input  logic [A_WIDTH-1:0] offset,
    input  logic [D_WIDTH-1:0] mic_signal,
    output logic [D_WIDTH-1:0] delayed_signal
);

    logic [A_WIDTH-1:0] address; // interconnect wire
    logic [A_WIDTH-1:0] write_ptr;
    logic [A_WIDTH-1:0] read_ptr;

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (1'b1),
    .incr (8'd1), // set the frequency of the sinusoidal waves constant
    .count (write_ptr)
);

assign read_ptr = write_ptr - offset;

ram2ports RAM (
    .clk(clk),
    .rd(rd),
    .wr(wr),
    .wr_addr(write_ptr),
    .rd_addr(read_ptr),
    .din(mic_signal),
    .dout(delayed_signal)   
);

endmodule
