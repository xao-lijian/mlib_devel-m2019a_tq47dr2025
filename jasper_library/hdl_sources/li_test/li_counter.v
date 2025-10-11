`timescale 1ns / 1ps

module li_counter #(
    parameter MAX_COUNT = 65536  // 定义计数器的最大值，这里使用4位可以表示的最大数
)(
    input wire clk_in,             // 时钟信号
    input wire reset,           // 异步复位信号
    input wire enable,          // 使能信号
    output reg [31:0] count     // 4位计数输出，根据需要可以调整位宽
);

// 内部信号，用于判断计数器是否达到最大值
wire at_max = (count == MAX_COUNT);

// 计数器逻辑
always @(posedge clk_in or posedge reset) begin
    if (reset) begin
        // 异步复位，将计数器清零
        count <= 32'b0;
    end else if (enable && !at_max) begin
        // 如果使能信号为高，且计数器未达到最大值，计数器递增
        count <= count + 1;
    end else if (at_max) begin
        // 如果计数器达到最大值，根据需要可以选择重置或者保持当前值
        count <= 32'b0;  // 这里选择重置为0
    end else begin
        // 如果使能信号为低，计数器保持当前值
        // 无需额外操作，因为默认行为就是保持不变
    end
end

endmodule
