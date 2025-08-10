module fft8_top(
    input  logic        pclk,
    input  logic        preset,
    ahblite_interconnection.ahblite_slave  slave0
);

  // instanitate your fft core here

  complex [7:0] din       ;
  complex [7:0] dout      ;
  logic   [7:0] ready_buf ;
  logic         valid_in  ;
  logic         valid_out ;
  logic   [2:0] buf_addr  ;

  FFT8 u_FFT8 (
    .clk          (pclk       ),
    .rst          (preset     ),
    .din          (din        ),
    .valid_in     (valid_in   ),
    .dout         (dout       ),
    .valid_out    (valid_out  )
  );

  assign  valid_in  = &ready_buf;
  assign  buf_addr  = slave0.haddr[3:2];

  always_ff @(posedge pclk or negedge preset) begin
    if (!preset) begin
      slave0.hrdata   <=  0;
      slave0.hready   <=  0;
      slave0.hresp    <=  0;
      for (integer i = 0; i < 8; i = i + 1) begin
        din[i]        <=  0;
      end
    end
    else begin
      if (slave0.hsel) begin
        if (slave0.hwrite) begin
          slave0.hready         <=  1;
          if (~ready_buf[buf_addr]) begin
            din[buf_addr]       <=  slave0.hwdata;
            ready_buf[buf_addr] <=  1;
          end
        end
        else begin
          slave0.hready   <=  valid_out;
          slave0.hrdata   <=  dout[buf_addr];
        end
      end
      else begin
        slave0.hrdata   <=  0;
        slave0.hready   <=  0;
        slave0.hresp    <=  0;
      end

      if (valid_in) begin
        ready_buf <=  0;
        for (integer i = 0; i < 8; i = i + 1) begin
          din[i]  <=  0;
        end
      end
    end
  end

  // ============== end ========================================= //
endmodule

