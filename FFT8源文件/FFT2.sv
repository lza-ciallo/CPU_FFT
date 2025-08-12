typedef struct packed {
    shortint    re;
    shortint    im;
} complex;

module FFT2 (
    input   complex     din_0   ,
    input   complex     din_1   ,
    output  complex     dout_0  ,
    output  complex     dout_1
);

    always_comb begin
        dout_0.re   =   din_0.re    +   din_1.re;
        dout_0.im   =   din_0.im    +   din_1.im;
        dout_1.re   =   din_0.re    -   din_1.re;
        dout_1.im   =   din_0.im    -   din_1.im;
    end

endmodule