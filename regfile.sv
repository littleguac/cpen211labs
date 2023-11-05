module regfile(data_in,writenum,write,readnum,clk,data_out);
input [15:0] data_in;
input [2:0] writenum, readnum;
input write, clk;
output reg [15:0] data_out;

reg [15:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
always_ff @(posedge clk)begin
    if(write == 1'b1)begin
        case(writenum)
            3'b000: reg0 = data_in;
            3'b001: reg1 = data_in;
            3'b010: reg2 = data_in;
            3'b011: reg3 = data_in;
            3'b100: reg4 = data_in;
            3'b101: reg5 = data_in;
            3'b110: reg6 = data_in;
            3'b111: reg7 = data_in;
            default: {reg1,reg2,reg3,reg4,reg5,reg6,reg7}= {16{1'bx}};
        endcase
    end
    else if(write == 1'b0)begin
        case(readnum)
            3'b000: data_out = reg0;
            3'b001: data_out = reg1;
            3'b010: data_out = reg2;
            3'b011: data_out = reg3;
            3'b100: data_out = reg4;
            3'b101: data_out = reg5;
            3'b110: data_out = reg6;
            3'b111: data_out = reg7;
            default: {reg1,reg2,reg3,reg4,reg5,reg6,reg7}= {16{1'bx}};
        endcase
    end
end
endmodule