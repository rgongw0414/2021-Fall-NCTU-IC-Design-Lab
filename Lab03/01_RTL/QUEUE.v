module QUEUE #(
    parameter DATA_WIDTH = 16,           // Bit-width of data
    parameter DEPTH = 256,               // #entries of QUEUE
    parameter ADDR_WIDTH = $clog2(DEPTH) // Bit-width of each entry address
)(
    input  wire                    clk,
    input  wire                    rst_n,

    // Enqueue interface
    input  wire                    enq_valid,
    input  wire [DATA_WIDTH-1:0]   enq_data,
    output wire                    full,

    // Dequeue interface
    input  wire                    deq_ready,
    output wire [DATA_WIDTH-1:0]   deq_data,
    output wire                    empty
);

    // FIFO memory
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers and counter
    reg [ADDR_WIDTH-1:0] head;
    reg [ADDR_WIDTH-1:0] tail;
    reg [ADDR_WIDTH:0]   count;
    reg [ADDR_WIDTH:0]   i; // Loop variable idx; width must be able to accommodate i == DEPTH, otherwise DC will report exceeding loop limit

    // Assign output flags
    assign full  = (count == DEPTH);
    assign empty = (count == 0);
    assign deq_data = mem[head];

    // Enqueue logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < DEPTH; i = i + 1) begin // width must be able to accommodate i == DEPTH, otherwise DC will report exceeding loop limit
                mem[i] <= {DATA_WIDTH{1'b0}};
            end
        end 
        else if (enq_valid && !full) begin
            mem[tail] <= enq_data;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tail <= 0;
        end 
        else if (enq_valid && !full) begin
            tail <= tail + 1;
        end
    end

    // Dequeue logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            head <= 0;
        end 
        else if (deq_ready && !empty) begin
            head <= head + 1;
        end
    end

    // Count logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
        end 
        else begin
            case ({enq_valid && !full, deq_ready && !empty})
                2'b10:   count <= count + 1; // Enqueue only
                2'b01:   count <= count - 1; // Dequeue only
                default: count <= count;   // No change or both enq_valid and deq_ready asserted
            endcase
        end
    end
endmodule
