`define CLK_PERIOD  10

module tb_FFT8;

    logic               clk         ;
    logic               rst         ;
    complex [7 : 0]     din         ;
    logic               valid_in    ;
    complex [7 : 0]     dout        ;
    logic               valid_out   ;

    // Pipelined FFT8 uses 6 clk cycle,
    // while single cycle FFT8 uses 3 clk cycle,
    // hence 3 NOPs need to insert in gcc code.
    FFT8 u_FFT8 (.*);
    // FFT8_1clk u_FFT8_1clk (.*);

    shortint in_re[8]   =   {8528, -4736, 1327, 5274, -195, 4419, 6660, 1914}       ;
    shortint in_im[8]   =   {317, -8800, -4191, 4635, -139, -240, -7263, 9072}      ;

    shortint out_re[8]  =   {23191, -6242, -22401, 5311, 9449, 29832, 23093, 5991}  ;
    shortint out_im[8]  =   {-6609, 6971, 19137, 2135, -15943, 4607, 4127, -11889}  ;

    integer wrong_num = 0;

    initial begin
        clk         =   0;
        rst         =   1;
        valid_in    =   0;
        forever begin
            #(`CLK_PERIOD / 2) clk <= ~clk;
        end
    end

    initial begin
        @ (negedge clk) rst = 0;
        @ (negedge clk) begin
            rst         =   1;
            valid_in    =   1;
            for (integer i = 0; i < 8; i = i + 1) begin
                din[i].re   <=  in_re[i];
                din[i].im   <=  in_im[i];
            end

        end
        @ (negedge clk) valid_in = 0;
        while (valid_out != 1) begin
            @ (negedge clk);
        end
        for (integer i = 0; i < 8; i = i + 1) begin
            if (dout[i].re != out_re[i]) begin
                if (dout[i].re == out_re[i] + 1 || dout[i].re == out_re[i] - 1) begin
                    $display("Warning in %d, dout.re = %d, ref_re = %d", i, dout[i].re, out_re[i]);
                end
                else begin
                    $display("Error in %d, dout.re = %d, ref_re = %d", i, dout[i].re, out_re[i]);
                    wrong_num = wrong_num + 1;
                end
            end
            if (dout[i].im != out_im[i]) begin
                if (dout[i].im == out_im[i] + 1 || dout[i].im == out_im[i] - 1) begin
                    $display("Warning in %d, dout.im = %d, ref_im = %d", i, dout[i].im, out_im[i]);
                end
                else begin
                    $display("Error in %d, dout.im = %d, ref_im = %d", i, dout[i].im, out_im[i]);
                    wrong_num = wrong_num + 1;
                end
            end
        end
        $display("wrong_num = %d", wrong_num);
        $finish(0);
    end

endmodule