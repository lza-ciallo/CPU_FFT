module FFT8_1clk (
    input   logic               clk         ,
    input   logic               rst         ,
    input   complex [7 : 0]     din         ,
    input   logic               valid_in    ,
    output  complex [7 : 0]     dout        ,
    output  logic               valid_out
);

    complex [7 : 0]     dout_temp   [2 : 0];
    complex [7 : 0]     din_temp    [2 : 0];
    logic   [2 : 0]     valid_temp;

    localparam int din_index [3][8] = '{
        '{0, 4, 2, 6, 1, 5, 3, 7},
        '{0, 2, 1, 3, 4, 6, 5, 7},
        '{0, 4, 1, 5, 2, 6, 3, 7}
    };
    localparam int dout_index [3][8] = '{
        '{0, 1, 2, 3, 4, 5, 6, 7},
        '{0, 2, 1, 3, 4, 6, 5, 7},
        '{0, 4, 1, 5, 2, 6, 3, 7}
    };

    generate
        for (genvar i = 0; i < 3; i = i + 1) begin
            for (genvar j = 0; j < 4; j = j + 1) begin
                FFT2 u_FFT2 (
                    .din_0      (din_temp[i][din_index[i][2*j]]     ),
                    .din_1      (din_temp[i][din_index[i][2*j+1]]   ),
                    .dout_0     (dout_temp[i][dout_index[i][2*j]]   ),
                    .dout_1     (dout_temp[i][dout_index[i][2*j+1]] )
                );
            end
        end
    endgenerate

    shortint    sqrt2_div2  =   724;

    always_comb begin
        // stage in-1
        din_temp[0]             =   din;
        valid_temp[0]           =   valid_in;
        // stage 1-2
        for (integer i = 0; i < 3; i = i + 1) begin
            din_temp[1][i]      =   dout_temp[0][i];
        end
        for (integer i = 4; i < 7; i = i + 1) begin
            din_temp[1][i]      =   dout_temp[0][i];
        end
        din_temp[1][3].re       =    dout_temp[0][3].im;
        din_temp[1][3].im       =   -dout_temp[0][3].re;
        din_temp[1][7].re       =    dout_temp[0][7].im;
        din_temp[1][7].im       =   -dout_temp[0][7].re;
        valid_temp[1]           =    valid_temp[0];
        // stage 2-3
        for (integer i = 0; i < 5; i = i + 1) begin
            din_temp[2][i]      =   dout_temp[1][i];
        end
        din_temp[2][5].re       =   sqrt2_div2 * ( dout_temp[1][5].re + dout_temp[1][5].im) / 1024;
        din_temp[2][5].im       =   sqrt2_div2 * (-dout_temp[1][5].re + dout_temp[1][5].im) / 1024;
        din_temp[2][6].re       =    dout_temp[1][6].im;
        din_temp[2][6].im       =   -dout_temp[1][6].re;
        din_temp[2][7].re       =   sqrt2_div2 * (-dout_temp[1][7].re + dout_temp[1][7].im) / 1024;
        din_temp[2][7].im       =   sqrt2_div2 * (-dout_temp[1][7].re - dout_temp[1][7].im) / 1024;
        valid_temp[2]           =   valid_temp[1];
        // stage 3-out
        dout                    =   dout_temp[2];
        valid_out               =   valid_temp[2];
    end

endmodule