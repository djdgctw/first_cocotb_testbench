// Generator : SpinalHDL v1.13.0    git head : d9d72474863badf47d8585d187f3e04ae4749c59
// Component : HdmiFpgaTop

`timescale 1ns/1ps

module HdmiFpgaTop (
  input  wire          io_sys_clk,
  input  wire          io_reset,
  output wire [3:0]    io_hdmi_tx_p,
  output wire [3:0]    io_hdmi_tx_n
);

  wire       [11:0]   vgaArea_vgaCtrl_io_timings_h_colorStart;
  reg        [7:0]    vgaArea_vgaCtrl_io_pixel_payload_r;
  reg        [7:0]    vgaArea_vgaCtrl_io_pixel_payload_g;
  reg        [7:0]    vgaArea_vgaCtrl_io_pixel_payload_b;
  wire                pll_clk_out1;
  wire                pll_clk_out2;
  wire                pll_locked;
  wire                vgaArea_vgaCtrl_io_pixel_ready;
  wire                vgaArea_vgaCtrl_io_VGA_hsync;
  wire                vgaArea_vgaCtrl_io_VGA_vsync;
  wire                vgaArea_vgaCtrl_io_VGA_Coloren;
  wire       [7:0]    vgaArea_vgaCtrl_io_VGA_color_r;
  wire       [7:0]    vgaArea_vgaCtrl_io_VGA_color_g;
  wire       [7:0]    vgaArea_vgaCtrl_io_VGA_color_b;
  wire                vgaArea_vgaCtrl_io_error;
  wire                vgaArea_vgaCtrl_io_frameStart;
  wire       [11:0]   vgaArea_vgaCtrl_io_hCount;
  wire       [11:0]   vgaArea_vgaCtrl_io_vCount;
  wire       [3:0]    hdmiTx_io_gpdi_dp;
  wire       [3:0]    hdmiTx_io_gpdi_dn;
  wire                asyncReset;
  wire       [11:0]   vgaArea_relX;
  wire                when_HDMI_l315;
  wire                when_HDMI_l316;
  wire                when_HDMI_l317;
  wire                when_HDMI_l318;
  wire                when_HDMI_l319;
  wire                when_HDMI_l320;
  wire                when_HDMI_l321;

  clk_wiz_0 pll (
    .clk_in1  (io_sys_clk  ), //i
    .reset    (io_reset    ), //i
    .clk_out1 (pll_clk_out1), //o
    .clk_out2 (pll_clk_out2), //o
    .locked   (pll_locked  )  //o
  );
  VgaCtrl vgaArea_vgaCtrl (
    .io_softReset            (1'b0                                         ), //i
    .io_timings_h_syncStart  (12'h05f                                      ), //i
    .io_timings_h_syncEnd    (12'h31f                                      ), //i
    .io_timings_h_colorStart (vgaArea_vgaCtrl_io_timings_h_colorStart[11:0]), //i
    .io_timings_h_colorEnd   (12'h30f                                      ), //i
    .io_timings_v_syncStart  (12'h001                                      ), //i
    .io_timings_v_syncEnd    (12'h20c                                      ), //i
    .io_timings_v_colorStart (12'h022                                      ), //i
    .io_timings_v_colorEnd   (12'h202                                      ), //i
    .io_pixel_valid          (1'b1                                         ), //i
    .io_pixel_ready          (vgaArea_vgaCtrl_io_pixel_ready               ), //o
    .io_pixel_payload_r      (vgaArea_vgaCtrl_io_pixel_payload_r[7:0]      ), //i
    .io_pixel_payload_g      (vgaArea_vgaCtrl_io_pixel_payload_g[7:0]      ), //i
    .io_pixel_payload_b      (vgaArea_vgaCtrl_io_pixel_payload_b[7:0]      ), //i
    .io_VGA_hsync            (vgaArea_vgaCtrl_io_VGA_hsync                 ), //o
    .io_VGA_vsync            (vgaArea_vgaCtrl_io_VGA_vsync                 ), //o
    .io_VGA_Coloren          (vgaArea_vgaCtrl_io_VGA_Coloren               ), //o
    .io_VGA_color_r          (vgaArea_vgaCtrl_io_VGA_color_r[7:0]          ), //o
    .io_VGA_color_g          (vgaArea_vgaCtrl_io_VGA_color_g[7:0]          ), //o
    .io_VGA_color_b          (vgaArea_vgaCtrl_io_VGA_color_b[7:0]          ), //o
    .io_error                (vgaArea_vgaCtrl_io_error                     ), //o
    .io_frameStart           (vgaArea_vgaCtrl_io_frameStart                ), //o
    .io_hCount               (vgaArea_vgaCtrl_io_hCount[11:0]              ), //o
    .io_vCount               (vgaArea_vgaCtrl_io_vCount[11:0]              ), //o
    .clk_out1                (pll_clk_out1                                 ), //i
    .asyncReset              (asyncReset                                   )  //i
  );
  VgaToHdmi_DVI hdmiTx (
    .io_vgaIn_hsync   (vgaArea_vgaCtrl_io_VGA_hsync       ), //i
    .io_vgaIn_vsync   (vgaArea_vgaCtrl_io_VGA_vsync       ), //i
    .io_vgaIn_Coloren (vgaArea_vgaCtrl_io_VGA_Coloren     ), //i
    .io_vgaIn_color_r (vgaArea_vgaCtrl_io_VGA_color_r[7:0]), //i
    .io_vgaIn_color_g (vgaArea_vgaCtrl_io_VGA_color_g[7:0]), //i
    .io_vgaIn_color_b (vgaArea_vgaCtrl_io_VGA_color_b[7:0]), //i
    .io_gpdi_dp       (hdmiTx_io_gpdi_dp[3:0]             ), //o
    .io_gpdi_dn       (hdmiTx_io_gpdi_dn[3:0]             ), //o
    .asyncReset       (asyncReset                         ), //i
    .clk_out2         (pll_clk_out2                       ), //i
    .clk_out1         (pll_clk_out1                       )  //i
  );
  assign asyncReset = (! pll_locked);
  assign vgaArea_vgaCtrl_io_timings_h_colorStart = 12'h08f;
  assign vgaArea_relX = (vgaArea_vgaCtrl_io_hCount - vgaArea_vgaCtrl_io_timings_h_colorStart);
  always @(*) begin
    vgaArea_vgaCtrl_io_pixel_payload_r = 8'h0;
    if(vgaArea_vgaCtrl_io_pixel_ready) begin
      if(when_HDMI_l315) begin
        vgaArea_vgaCtrl_io_pixel_payload_r = 8'hff;
      end else begin
        if(when_HDMI_l316) begin
          vgaArea_vgaCtrl_io_pixel_payload_r = 8'hff;
        end else begin
          if(when_HDMI_l317) begin
            vgaArea_vgaCtrl_io_pixel_payload_r = 8'h0;
          end else begin
            if(when_HDMI_l318) begin
              vgaArea_vgaCtrl_io_pixel_payload_r = 8'h0;
            end else begin
              if(when_HDMI_l319) begin
                vgaArea_vgaCtrl_io_pixel_payload_r = 8'hff;
              end else begin
                if(when_HDMI_l320) begin
                  vgaArea_vgaCtrl_io_pixel_payload_r = 8'hff;
                end else begin
                  if(when_HDMI_l321) begin
                    vgaArea_vgaCtrl_io_pixel_payload_r = 8'h0;
                  end else begin
                    vgaArea_vgaCtrl_io_pixel_payload_r = 8'h50;
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  always @(*) begin
    vgaArea_vgaCtrl_io_pixel_payload_g = 8'h0;
    if(vgaArea_vgaCtrl_io_pixel_ready) begin
      if(when_HDMI_l315) begin
        vgaArea_vgaCtrl_io_pixel_payload_g = 8'hff;
      end else begin
        if(when_HDMI_l316) begin
          vgaArea_vgaCtrl_io_pixel_payload_g = 8'hff;
        end else begin
          if(when_HDMI_l317) begin
            vgaArea_vgaCtrl_io_pixel_payload_g = 8'hff;
          end else begin
            if(when_HDMI_l318) begin
              vgaArea_vgaCtrl_io_pixel_payload_g = 8'hff;
            end else begin
              if(when_HDMI_l319) begin
                vgaArea_vgaCtrl_io_pixel_payload_g = 8'h0;
              end else begin
                if(when_HDMI_l320) begin
                  vgaArea_vgaCtrl_io_pixel_payload_g = 8'h0;
                end else begin
                  if(when_HDMI_l321) begin
                    vgaArea_vgaCtrl_io_pixel_payload_g = 8'h0;
                  end else begin
                    vgaArea_vgaCtrl_io_pixel_payload_g = 8'h50;
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  always @(*) begin
    vgaArea_vgaCtrl_io_pixel_payload_b = 8'h0;
    if(vgaArea_vgaCtrl_io_pixel_ready) begin
      if(when_HDMI_l315) begin
        vgaArea_vgaCtrl_io_pixel_payload_b = 8'hff;
      end else begin
        if(when_HDMI_l316) begin
          vgaArea_vgaCtrl_io_pixel_payload_b = 8'h0;
        end else begin
          if(when_HDMI_l317) begin
            vgaArea_vgaCtrl_io_pixel_payload_b = 8'hff;
          end else begin
            if(when_HDMI_l318) begin
              vgaArea_vgaCtrl_io_pixel_payload_b = 8'h0;
            end else begin
              if(when_HDMI_l319) begin
                vgaArea_vgaCtrl_io_pixel_payload_b = 8'hff;
              end else begin
                if(when_HDMI_l320) begin
                  vgaArea_vgaCtrl_io_pixel_payload_b = 8'h0;
                end else begin
                  if(when_HDMI_l321) begin
                    vgaArea_vgaCtrl_io_pixel_payload_b = 8'hff;
                  end else begin
                    vgaArea_vgaCtrl_io_pixel_payload_b = 8'h50;
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  assign when_HDMI_l315 = (vgaArea_relX < 12'h050);
  assign when_HDMI_l316 = (vgaArea_relX < 12'h0a0);
  assign when_HDMI_l317 = (vgaArea_relX < 12'h0f0);
  assign when_HDMI_l318 = (vgaArea_relX < 12'h140);
  assign when_HDMI_l319 = (vgaArea_relX < 12'h190);
  assign when_HDMI_l320 = (vgaArea_relX < 12'h1e0);
  assign when_HDMI_l321 = (vgaArea_relX < 12'h230);
  assign io_hdmi_tx_p = hdmiTx_io_gpdi_dp;
  assign io_hdmi_tx_n = hdmiTx_io_gpdi_dn;

endmodule

module VgaToHdmi_DVI (
  input  wire          io_vgaIn_hsync,
  input  wire          io_vgaIn_vsync,
  input  wire          io_vgaIn_Coloren,
  input  wire [7:0]    io_vgaIn_color_r,
  input  wire [7:0]    io_vgaIn_color_g,
  input  wire [7:0]    io_vgaIn_color_b,
  output reg  [3:0]    io_gpdi_dp,
  output reg  [3:0]    io_gpdi_dn,
  input  wire          asyncReset,
  input  wire          clk_out2,
  input  wire          clk_out1
);

  wire                oddr_clk_D1;
  wire                oddr_clk_D2;
  wire                oddr_r_D1;
  wire                oddr_r_D2;
  wire                oddr_g_D1;
  wire                oddr_g_D2;
  wire                oddr_b_D1;
  wire                oddr_b_D2;
  wire       [9:0]    Encoder_Red_io_TMDS_data;
  wire       [9:0]    Encoder_Green_io_TMDS_data;
  wire       [9:0]    Encoder_Blue_io_TMDS_data;
  wire                cdcFifo_io_push_ready;
  wire                cdcFifo_io_pop_valid;
  wire       [29:0]   cdcFifo_io_pop_payload;
  wire       [2:0]    cdcFifo_io_pushOccupancy;
  wire       [2:0]    cdcFifo_io_popOccupancy;
  wire                oddr_clk_Q;
  wire                oddr_r_Q;
  wire                oddr_g_Q;
  wire                oddr_b_Q;
  wire                buf_clk_O;
  wire                buf_clk_OB;
  wire                buf_r_O;
  wire                buf_r_OB;
  wire                buf_g_O;
  wire                buf_g_OB;
  wire                buf_b_O;
  wire                buf_b_OB;
  wire       [2:0]    _zz_count_mod5;
  wire       [0:0]    _zz_count_mod5_1;
  wire       [2:0]    _zz_count_mod5_2;
  wire       [9:0]    _zz_shiftR;
  wire       [7:0]    _zz_shiftR_1;
  wire       [9:0]    _zz_shiftG;
  wire       [7:0]    _zz_shiftG_1;
  wire       [9:0]    _zz_shiftB;
  wire       [7:0]    _zz_shiftB_1;
  wire       [9:0]    _zz_shiftC;
  wire       [7:0]    _zz_shiftC_1;
  wire       [9:0]    tmdsRed;
  wire       [9:0]    tmdsBlue;
  wire       [9:0]    tmdsGreen;
  wire       [1:0]    bcd;
  wire       [29:0]   tmdsAll;
  wire       [9:0]    tmdsRed_fast;
  wire       [9:0]    tmdsGreen_fast;
  wire       [9:0]    tmdsBlue_fast;
  reg        [2:0]    count_mod5;
  wire                shift_ld;
  reg        [9:0]    shiftR;
  reg        [9:0]    shiftG;
  reg        [9:0]    shiftB;
  reg        [9:0]    shiftC;
  wire                ser_clk;
  wire                ser_red;
  wire                ser_green;
  wire                ser_blue;

  assign _zz_count_mod5_1 = 1'b0;
  assign _zz_count_mod5 = {2'd0, _zz_count_mod5_1};
  assign _zz_count_mod5_2 = (count_mod5 + 3'b001);
  assign _zz_shiftR_1 = shiftR[9 : 2];
  assign _zz_shiftR = {2'd0, _zz_shiftR_1};
  assign _zz_shiftG_1 = shiftG[9 : 2];
  assign _zz_shiftG = {2'd0, _zz_shiftG_1};
  assign _zz_shiftB_1 = shiftB[9 : 2];
  assign _zz_shiftB = {2'd0, _zz_shiftB_1};
  assign _zz_shiftC_1 = shiftC[9 : 2];
  assign _zz_shiftC = {2'd0, _zz_shiftC_1};
  TmdsEncoder_HDMI Encoder_Red (
    .io_VD        (io_vgaIn_color_r[7:0]        ), //i
    .io_CD        (2'b00                        ), //i
    .io_VDE       (io_vgaIn_Coloren             ), //i
    .io_TMDS_data (Encoder_Red_io_TMDS_data[9:0]), //o
    .clk_out1     (clk_out1                     ), //i
    .asyncReset   (asyncReset                   )  //i
  );
  TmdsEncoder_HDMI Encoder_Green (
    .io_VD        (io_vgaIn_color_g[7:0]          ), //i
    .io_CD        (2'b00                          ), //i
    .io_VDE       (io_vgaIn_Coloren               ), //i
    .io_TMDS_data (Encoder_Green_io_TMDS_data[9:0]), //o
    .clk_out1     (clk_out1                       ), //i
    .asyncReset   (asyncReset                     )  //i
  );
  TmdsEncoder_HDMI Encoder_Blue (
    .io_VD        (io_vgaIn_color_b[7:0]         ), //i
    .io_CD        (bcd[1:0]                      ), //i
    .io_VDE       (io_vgaIn_Coloren              ), //i
    .io_TMDS_data (Encoder_Blue_io_TMDS_data[9:0]), //o
    .clk_out1     (clk_out1                      ), //i
    .asyncReset   (asyncReset                    )  //i
  );
  StreamFifoCC cdcFifo (
    .io_push_valid    (1'b1                         ), //i
    .io_push_ready    (cdcFifo_io_push_ready        ), //o
    .io_push_payload  (tmdsAll[29:0]                ), //i
    .io_pop_valid     (cdcFifo_io_pop_valid         ), //o
    .io_pop_ready     (1'b1                         ), //i
    .io_pop_payload   (cdcFifo_io_pop_payload[29:0] ), //o
    .io_pushOccupancy (cdcFifo_io_pushOccupancy[2:0]), //o
    .io_popOccupancy  (cdcFifo_io_popOccupancy[2:0] ), //o
    .clk_out1         (clk_out1                     ), //i
    .asyncReset       (asyncReset                   ), //i
    .clk_out2         (clk_out2                     )  //i
  );
  ODDR #(
    .DDR_CLK_EDGE ("SAME_EDGE"),
    .INIT         (0          ),
    .SRTYPE       ("SYNC"     )
  ) oddr_clk (
    .Q  (oddr_clk_Q ), //o
    .C  (clk_out2   ), //i
    .CE (1'b1       ), //i
    .D1 (oddr_clk_D1), //i
    .D2 (oddr_clk_D2), //i
    .R  (asyncReset ), //i
    .S  (1'b0       )  //i
  );
  ODDR #(
    .DDR_CLK_EDGE ("SAME_EDGE"),
    .INIT         (0          ),
    .SRTYPE       ("SYNC"     )
  ) oddr_r (
    .Q  (oddr_r_Q  ), //o
    .C  (clk_out2  ), //i
    .CE (1'b1      ), //i
    .D1 (oddr_r_D1 ), //i
    .D2 (oddr_r_D2 ), //i
    .R  (asyncReset), //i
    .S  (1'b0      )  //i
  );
  ODDR #(
    .DDR_CLK_EDGE ("SAME_EDGE"),
    .INIT         (0          ),
    .SRTYPE       ("SYNC"     )
  ) oddr_g (
    .Q  (oddr_g_Q  ), //o
    .C  (clk_out2  ), //i
    .CE (1'b1      ), //i
    .D1 (oddr_g_D1 ), //i
    .D2 (oddr_g_D2 ), //i
    .R  (asyncReset), //i
    .S  (1'b0      )  //i
  );
  ODDR #(
    .DDR_CLK_EDGE ("SAME_EDGE"),
    .INIT         (0          ),
    .SRTYPE       ("SYNC"     )
  ) oddr_b (
    .Q  (oddr_b_Q  ), //o
    .C  (clk_out2  ), //i
    .CE (1'b1      ), //i
    .D1 (oddr_b_D1 ), //i
    .D2 (oddr_b_D2 ), //i
    .R  (asyncReset), //i
    .S  (1'b0      )  //i
  );
  OBUFDS buf_clk (
    .I  (ser_clk   ), //i
    .O  (buf_clk_O ), //o
    .OB (buf_clk_OB)  //o
  );
  OBUFDS buf_r (
    .I  (ser_red ), //i
    .O  (buf_r_O ), //o
    .OB (buf_r_OB)  //o
  );
  OBUFDS buf_g (
    .I  (ser_green), //i
    .O  (buf_g_O  ), //o
    .OB (buf_g_OB )  //o
  );
  OBUFDS buf_b (
    .I  (ser_blue), //i
    .O  (buf_b_O ), //o
    .OB (buf_b_OB)  //o
  );
  assign bcd = {io_vgaIn_vsync,io_vgaIn_hsync};
  assign tmdsRed = Encoder_Red_io_TMDS_data;
  assign tmdsGreen = Encoder_Green_io_TMDS_data;
  assign tmdsBlue = Encoder_Blue_io_TMDS_data;
  assign tmdsAll = {{tmdsRed,tmdsGreen},tmdsBlue};
  assign tmdsRed_fast = cdcFifo_io_pop_payload[29 : 20];
  assign tmdsGreen_fast = cdcFifo_io_pop_payload[19 : 10];
  assign tmdsBlue_fast = cdcFifo_io_pop_payload[9 : 0];
  assign shift_ld = (count_mod5 == 3'b100);
  assign oddr_clk_D1 = shiftC[0];
  assign oddr_clk_D2 = shiftC[1];
  assign ser_clk = oddr_clk_Q;
  assign oddr_r_D1 = shiftR[0];
  assign oddr_r_D2 = shiftR[1];
  assign ser_red = oddr_r_Q;
  assign oddr_g_D1 = shiftG[0];
  assign oddr_g_D2 = shiftG[1];
  assign ser_green = oddr_g_Q;
  assign oddr_b_D1 = shiftB[0];
  assign oddr_b_D2 = shiftB[1];
  assign ser_blue = oddr_b_Q;
  always @(*) begin
    io_gpdi_dp[3] = buf_clk_O;
    io_gpdi_dp[2] = buf_r_O;
    io_gpdi_dp[1] = buf_g_O;
    io_gpdi_dp[0] = buf_b_O;
  end

  always @(*) begin
    io_gpdi_dn[3] = buf_clk_OB;
    io_gpdi_dn[2] = buf_r_OB;
    io_gpdi_dn[1] = buf_g_OB;
    io_gpdi_dn[0] = buf_b_OB;
  end

  always @(posedge clk_out2 or posedge asyncReset) begin
    if(asyncReset) begin
      count_mod5 <= 3'b000;
      shiftR <= 10'h0;
      shiftG <= 10'h0;
      shiftB <= 10'h0;
      shiftC <= 10'h0;
    end else begin
      count_mod5 <= ((count_mod5 == 3'b100) ? _zz_count_mod5 : _zz_count_mod5_2);
      shiftR <= (shift_ld ? tmdsRed_fast : _zz_shiftR);
      shiftG <= (shift_ld ? tmdsGreen_fast : _zz_shiftG);
      shiftB <= (shift_ld ? tmdsBlue_fast : _zz_shiftB);
      shiftC <= (shift_ld ? 10'h3e0 : _zz_shiftC);
    end
  end


endmodule

module VgaCtrl (
  input  wire          io_softReset,
  input  wire [11:0]   io_timings_h_syncStart,
  input  wire [11:0]   io_timings_h_syncEnd,
  input  wire [11:0]   io_timings_h_colorStart,
  input  wire [11:0]   io_timings_h_colorEnd,
  input  wire [11:0]   io_timings_v_syncStart,
  input  wire [11:0]   io_timings_v_syncEnd,
  input  wire [11:0]   io_timings_v_colorStart,
  input  wire [11:0]   io_timings_v_colorEnd,
  input  wire          io_pixel_valid,
  output wire          io_pixel_ready,
  input  wire [7:0]    io_pixel_payload_r,
  input  wire [7:0]    io_pixel_payload_g,
  input  wire [7:0]    io_pixel_payload_b,
  output wire          io_VGA_hsync,
  output wire          io_VGA_vsync,
  output wire          io_VGA_Coloren,
  output wire [7:0]    io_VGA_color_r,
  output wire [7:0]    io_VGA_color_g,
  output wire [7:0]    io_VGA_color_b,
  output wire          io_error,
  output wire          io_frameStart,
  output wire [11:0]   io_hCount,
  output wire [11:0]   io_vCount,
  input  wire          clk_out1,
  input  wire          asyncReset
);

  wire                when_VGACtrl_l106;
  reg        [11:0]   h_counter;
  wire                h_syncStart;
  wire                h_syncEnd;
  wire                h_colorStart;
  wire                h_colorEnd;
  reg                 h_sync;
  reg                 h_colorEn;
  reg        [11:0]   v_counter;
  wire                v_syncStart;
  wire                v_syncEnd;
  wire                v_colorStart;
  wire                v_colorEnd;
  reg                 v_sync;
  reg                 v_colorEn;
  wire                coloren;

  assign when_VGACtrl_l106 = 1'b1;
  assign h_syncStart = (io_timings_h_syncStart == h_counter);
  assign h_syncEnd = (io_timings_h_syncEnd == h_counter);
  assign h_colorStart = (io_timings_h_colorStart == h_counter);
  assign h_colorEnd = (io_timings_h_colorEnd == h_counter);
  assign v_syncStart = (io_timings_v_syncStart == v_counter);
  assign v_syncEnd = (io_timings_v_syncEnd == v_counter);
  assign v_colorStart = (io_timings_v_colorStart == v_counter);
  assign v_colorEnd = (io_timings_v_colorEnd == v_counter);
  assign coloren = (h_colorEn && v_colorEn);
  assign io_VGA_hsync = h_sync;
  assign io_VGA_vsync = v_sync;
  assign io_VGA_color_r = io_pixel_payload_r;
  assign io_VGA_color_g = io_pixel_payload_g;
  assign io_VGA_color_b = io_pixel_payload_b;
  assign io_VGA_Coloren = coloren;
  assign io_hCount = h_counter;
  assign io_vCount = v_counter;
  assign io_pixel_ready = coloren;
  assign io_frameStart = v_syncEnd;
  assign io_error = (coloren && (! io_pixel_valid));
  always @(posedge clk_out1 or posedge asyncReset) begin
    if(asyncReset) begin
      h_counter <= 12'h0;
      h_sync <= 1'b1;
      h_colorEn <= 1'b0;
      v_counter <= 12'h0;
      v_sync <= 1'b1;
      v_colorEn <= 1'b0;
    end else begin
      if(when_VGACtrl_l106) begin
        h_counter <= (h_counter + 12'h001);
        if(h_syncEnd) begin
          h_counter <= 12'h0;
        end
      end
      if(h_syncStart) begin
        h_sync <= 1'b0;
      end
      if(h_syncEnd) begin
        h_sync <= 1'b1;
      end
      if(h_colorStart) begin
        h_colorEn <= 1'b1;
      end
      if(h_colorEnd) begin
        h_colorEn <= 1'b0;
      end
      if(io_softReset) begin
        h_sync <= 1'b0;
        h_colorEn <= 1'b0;
        h_counter <= 12'h0;
      end
      if(h_syncEnd) begin
        v_counter <= (v_counter + 12'h001);
        if(v_syncEnd) begin
          v_counter <= 12'h0;
        end
      end
      if(v_syncStart) begin
        v_sync <= 1'b0;
      end
      if(v_syncEnd) begin
        v_sync <= 1'b1;
      end
      if(v_colorStart) begin
        v_colorEn <= 1'b1;
      end
      if(v_colorEnd) begin
        v_colorEn <= 1'b0;
      end
      if(io_softReset) begin
        v_sync <= 1'b0;
        v_colorEn <= 1'b0;
        v_counter <= 12'h0;
      end
    end
  end


endmodule

module StreamFifoCC (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire [29:0]   io_push_payload,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire [29:0]   io_pop_payload,
  output wire [2:0]    io_pushOccupancy,
  output wire [2:0]    io_popOccupancy,
  input  wire          clk_out1,
  input  wire          asyncReset,
  input  wire          clk_out2
);

  reg        [29:0]   ram_spinal_port1;
  wire       [2:0]    popToPushGray_buffercc_io_dataOut;
  wire                hdmiTx_toplevel_asyncReset_asyncAssertSyncDeassert_buffercc_io_dataOut;
  wire       [2:0]    pushToPopGray_buffercc_io_dataOut;
  wire       [2:0]    _zz_pushCC_pushPtrGray;
  wire       [1:0]    _zz_ram_port;
  wire       [2:0]    _zz_popCC_popPtrGray;
  reg                 _zz_1;
  wire       [2:0]    popToPushGray;
  wire       [2:0]    pushToPopGray;
  reg        [2:0]    pushCC_pushPtr;
  wire       [2:0]    pushCC_pushPtrPlus;
  wire                io_push_fire;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [2:0]    pushCC_pushPtrGray;
  wire       [2:0]    pushCC_popPtrGray;
  wire                pushCC_full;
  wire                _zz_io_pushOccupancy;
  wire                _zz_io_pushOccupancy_1;
  wire                hdmiTx_toplevel_asyncReset_asyncAssertSyncDeassert;
  wire                hdmiTx_toplevel_asyncReset_synchronized;
  reg        [2:0]    popCC_popPtr;
  (* keep , syn_keep *) wire       [2:0]    popCC_popPtrPlus /* synthesis syn_keep = 1 */ ;
  wire       [2:0]    popCC_popPtrGray;
  wire       [2:0]    popCC_pushPtrGray;
  wire                popCC_addressGen_valid;
  reg                 popCC_addressGen_ready;
  wire       [1:0]    popCC_addressGen_payload;
  wire                popCC_empty;
  wire                popCC_addressGen_fire;
  wire                popCC_readArbitation_valid;
  wire                popCC_readArbitation_ready;
  wire       [1:0]    popCC_readArbitation_payload;
  reg                 popCC_addressGen_rValid;
  reg        [1:0]    popCC_addressGen_rData;
  wire                when_Stream_l477;
  wire                popCC_readPort_cmd_valid;
  wire       [1:0]    popCC_readPort_cmd_payload;
  wire       [29:0]   popCC_readPort_rsp;
  wire                popCC_addressGen_toFlowFire_valid;
  wire       [1:0]    popCC_addressGen_toFlowFire_payload;
  wire                popCC_readArbitation_translated_valid;
  wire                popCC_readArbitation_translated_ready;
  wire       [29:0]   popCC_readArbitation_translated_payload;
  wire                popCC_readArbitation_fire;
  (* altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [2:0]    popCC_ptrToPush;
  reg        [2:0]    popCC_ptrToOccupancy;
  wire                _zz_io_popOccupancy;
  wire                _zz_io_popOccupancy_1;
  reg [29:0] ram [0:3];

  assign _zz_pushCC_pushPtrGray = (pushCC_pushPtrPlus >>> 1'b1);
  assign _zz_ram_port = pushCC_pushPtr[1:0];
  assign _zz_popCC_popPtrGray = (popCC_popPtr >>> 1'b1);
  always @(posedge clk_out1) begin
    if(_zz_1) begin
      ram[_zz_ram_port] <= io_push_payload;
    end
  end

  always @(posedge clk_out2) begin
    if(popCC_readPort_cmd_valid) begin
      ram_spinal_port1 <= ram[popCC_readPort_cmd_payload];
    end
  end

  (* keep_hierarchy = "TRUE" *) BufferCC popToPushGray_buffercc (
    .io_dataIn  (popToPushGray[2:0]                    ), //i
    .io_dataOut (popToPushGray_buffercc_io_dataOut[2:0]), //o
    .clk_out1   (clk_out1                              ), //i
    .asyncReset (asyncReset                            )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_1 hdmiTx_toplevel_asyncReset_asyncAssertSyncDeassert_buffercc (
    .io_dataIn  (hdmiTx_toplevel_asyncReset_asyncAssertSyncDeassert                    ), //i
    .io_dataOut (hdmiTx_toplevel_asyncReset_asyncAssertSyncDeassert_buffercc_io_dataOut), //o
    .clk_out2   (clk_out2                                                              ), //i
    .asyncReset (asyncReset                                                            )  //i
  );
  (* keep_hierarchy = "TRUE" *) BufferCC_2 pushToPopGray_buffercc (
    .io_dataIn                               (pushToPopGray[2:0]                     ), //i
    .io_dataOut                              (pushToPopGray_buffercc_io_dataOut[2:0] ), //o
    .clk_out2                                (clk_out2                               ), //i
    .hdmiTx_toplevel_asyncReset_synchronized (hdmiTx_toplevel_asyncReset_synchronized)  //i
  );
  always @(*) begin
    _zz_1 = 1'b0;
    if(io_push_fire) begin
      _zz_1 = 1'b1;
    end
  end

  assign pushCC_pushPtrPlus = (pushCC_pushPtr + 3'b001);
  assign io_push_fire = (io_push_valid && io_push_ready);
  assign pushCC_popPtrGray = popToPushGray_buffercc_io_dataOut;
  assign pushCC_full = ((pushCC_pushPtrGray[2 : 1] == (~ pushCC_popPtrGray[2 : 1])) && (pushCC_pushPtrGray[0 : 0] == pushCC_popPtrGray[0 : 0]));
  assign io_push_ready = (! pushCC_full);
  assign _zz_io_pushOccupancy = (pushCC_popPtrGray[1] ^ _zz_io_pushOccupancy_1);
  assign _zz_io_pushOccupancy_1 = pushCC_popPtrGray[2];
  assign io_pushOccupancy = (pushCC_pushPtr - {_zz_io_pushOccupancy_1,{_zz_io_pushOccupancy,(pushCC_popPtrGray[0] ^ _zz_io_pushOccupancy)}});
  assign hdmiTx_toplevel_asyncReset_asyncAssertSyncDeassert = (1'b0 ^ 1'b0);
  assign hdmiTx_toplevel_asyncReset_synchronized = hdmiTx_toplevel_asyncReset_asyncAssertSyncDeassert_buffercc_io_dataOut;
  assign popCC_popPtrPlus = (popCC_popPtr + 3'b001);
  assign popCC_popPtrGray = (_zz_popCC_popPtrGray ^ popCC_popPtr);
  assign popCC_pushPtrGray = pushToPopGray_buffercc_io_dataOut;
  assign popCC_empty = (popCC_popPtrGray == popCC_pushPtrGray);
  assign popCC_addressGen_valid = (! popCC_empty);
  assign popCC_addressGen_payload = popCC_popPtr[1:0];
  assign popCC_addressGen_fire = (popCC_addressGen_valid && popCC_addressGen_ready);
  always @(*) begin
    popCC_addressGen_ready = popCC_readArbitation_ready;
    if(when_Stream_l477) begin
      popCC_addressGen_ready = 1'b1;
    end
  end

  assign when_Stream_l477 = (! popCC_readArbitation_valid);
  assign popCC_readArbitation_valid = popCC_addressGen_rValid;
  assign popCC_readArbitation_payload = popCC_addressGen_rData;
  assign popCC_readPort_rsp = ram_spinal_port1;
  assign popCC_addressGen_toFlowFire_valid = popCC_addressGen_fire;
  assign popCC_addressGen_toFlowFire_payload = popCC_addressGen_payload;
  assign popCC_readPort_cmd_valid = popCC_addressGen_toFlowFire_valid;
  assign popCC_readPort_cmd_payload = popCC_addressGen_toFlowFire_payload;
  assign popCC_readArbitation_translated_valid = popCC_readArbitation_valid;
  assign popCC_readArbitation_ready = popCC_readArbitation_translated_ready;
  assign popCC_readArbitation_translated_payload = popCC_readPort_rsp;
  assign io_pop_valid = popCC_readArbitation_translated_valid;
  assign popCC_readArbitation_translated_ready = io_pop_ready;
  assign io_pop_payload = popCC_readArbitation_translated_payload;
  assign popCC_readArbitation_fire = (popCC_readArbitation_valid && popCC_readArbitation_ready);
  assign _zz_io_popOccupancy = (popCC_pushPtrGray[1] ^ _zz_io_popOccupancy_1);
  assign _zz_io_popOccupancy_1 = popCC_pushPtrGray[2];
  assign io_popOccupancy = ({_zz_io_popOccupancy_1,{_zz_io_popOccupancy,(popCC_pushPtrGray[0] ^ _zz_io_popOccupancy)}} - popCC_ptrToOccupancy);
  assign pushToPopGray = pushCC_pushPtrGray;
  assign popToPushGray = popCC_ptrToPush;
  always @(posedge clk_out1 or posedge asyncReset) begin
    if(asyncReset) begin
      pushCC_pushPtr <= 3'b000;
      pushCC_pushPtrGray <= 3'b000;
    end else begin
      if(io_push_fire) begin
        pushCC_pushPtrGray <= (_zz_pushCC_pushPtrGray ^ pushCC_pushPtrPlus);
      end
      if(io_push_fire) begin
        pushCC_pushPtr <= pushCC_pushPtrPlus;
      end
    end
  end

  always @(posedge clk_out2 or posedge hdmiTx_toplevel_asyncReset_synchronized) begin
    if(hdmiTx_toplevel_asyncReset_synchronized) begin
      popCC_popPtr <= 3'b000;
      popCC_addressGen_rValid <= 1'b0;
      popCC_ptrToPush <= 3'b000;
      popCC_ptrToOccupancy <= 3'b000;
    end else begin
      if(popCC_addressGen_fire) begin
        popCC_popPtr <= popCC_popPtrPlus;
      end
      if(popCC_addressGen_ready) begin
        popCC_addressGen_rValid <= popCC_addressGen_valid;
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToPush <= popCC_popPtrGray;
      end
      if(popCC_readArbitation_fire) begin
        popCC_ptrToOccupancy <= popCC_popPtr;
      end
    end
  end

  always @(posedge clk_out2) begin
    if(popCC_addressGen_ready) begin
      popCC_addressGen_rData <= popCC_addressGen_payload;
    end
  end


endmodule

//TmdsEncoder_HDMI_2 replaced by TmdsEncoder_HDMI

//TmdsEncoder_HDMI_1 replaced by TmdsEncoder_HDMI

module TmdsEncoder_HDMI (
  input  wire [7:0]    io_VD,
  input  wire [1:0]    io_CD,
  input  wire          io_VDE,
  output reg  [9:0]    io_TMDS_data,
  input  wire          clk_out1,
  input  wire          asyncReset
);

  wire       [3:0]    _zz_DCountOnes;
  wire       [3:0]    _zz_DCountOnes_1;
  wire       [3:0]    _zz_DCountOnes_2;
  wire       [0:0]    _zz_DCountOnes_3;
  wire       [3:0]    _zz_DCountOnes_4;
  wire       [0:0]    _zz_DCountOnes_5;
  wire       [3:0]    _zz_DCountOnes_6;
  wire       [3:0]    _zz_DCountOnes_7;
  wire       [0:0]    _zz_DCountOnes_8;
  wire       [3:0]    _zz_DCountOnes_9;
  wire       [0:0]    _zz_DCountOnes_10;
  wire       [3:0]    _zz_DCountOnes_11;
  wire       [3:0]    _zz_DCountOnes_12;
  wire       [3:0]    _zz_DCountOnes_13;
  wire       [0:0]    _zz_DCountOnes_14;
  wire       [3:0]    _zz_DCountOnes_15;
  wire       [0:0]    _zz_DCountOnes_16;
  wire       [3:0]    _zz_DCountOnes_17;
  wire       [3:0]    _zz_DCountOnes_18;
  wire       [0:0]    _zz_DCountOnes_19;
  wire       [3:0]    _zz_DCountOnes_20;
  wire       [0:0]    _zz_DCountOnes_21;
  wire       [3:0]    _zz_dw_disp;
  wire       [3:0]    _zz_dw_disp_1;
  wire       [3:0]    _zz_dw_disp_2;
  wire       [3:0]    _zz_dw_disp_3;
  wire       [0:0]    _zz_dw_disp_4;
  wire       [3:0]    _zz_dw_disp_5;
  wire       [0:0]    _zz_dw_disp_6;
  wire       [3:0]    _zz_dw_disp_7;
  wire       [3:0]    _zz_dw_disp_8;
  wire       [0:0]    _zz_dw_disp_9;
  wire       [3:0]    _zz_dw_disp_10;
  wire       [0:0]    _zz_dw_disp_11;
  wire       [3:0]    _zz_dw_disp_12;
  wire       [3:0]    _zz_dw_disp_13;
  wire       [3:0]    _zz_dw_disp_14;
  wire       [0:0]    _zz_dw_disp_15;
  wire       [3:0]    _zz_dw_disp_16;
  wire       [0:0]    _zz_dw_disp_17;
  wire       [3:0]    _zz_dw_disp_18;
  wire       [3:0]    _zz_dw_disp_19;
  wire       [0:0]    _zz_dw_disp_20;
  wire       [3:0]    _zz_dw_disp_21;
  wire       [0:0]    _zz_dw_disp_22;
  wire       [3:0]    _zz_delta;
  wire       [0:0]    _zz_delta_1;
  wire       [3:0]    _zz_dc_bias_new;
  wire       [3:0]    _zz_dc_bias_new_1;
  reg        [9:0]    _zz_TMDS_Control_data;
  wire       [1:0]    _zz_TMDS_Control_data_1;
  reg        [3:0]    dc_bias;
  wire       [3:0]    DCountOnes;
  wire                XNOR_1;
  wire                qm_0;
  wire                qm_1;
  wire                qm_2;
  wire                qm_3;
  wire                qm_4;
  wire                qm_5;
  wire                qm_6;
  wire                qm_7;
  wire                qm_8;
  wire       [3:0]    dw_disp;
  wire                sign_eq;
  wire                inv_dw;
  wire                condition;
  wire       [3:0]    delta;
  wire       [3:0]    dc_bias_new;
  wire       [8:0]    qm_bits;
  wire       [7:0]    qm_low;
  wire       [9:0]    TMDS_data_Video;
  wire       [9:0]    ctrlTokens_0;
  wire       [9:0]    ctrlTokens_1;
  wire       [9:0]    ctrlTokens_2;
  wire       [9:0]    ctrlTokens_3;
  wire       [9:0]    TMDS_Control_data;

  assign _zz_DCountOnes = (_zz_DCountOnes_1 + _zz_DCountOnes_6);
  assign _zz_DCountOnes_1 = (_zz_DCountOnes_2 + _zz_DCountOnes_4);
  assign _zz_DCountOnes_3 = io_VD[0];
  assign _zz_DCountOnes_2 = {3'd0, _zz_DCountOnes_3};
  assign _zz_DCountOnes_5 = io_VD[1];
  assign _zz_DCountOnes_4 = {3'd0, _zz_DCountOnes_5};
  assign _zz_DCountOnes_6 = (_zz_DCountOnes_7 + _zz_DCountOnes_9);
  assign _zz_DCountOnes_8 = io_VD[2];
  assign _zz_DCountOnes_7 = {3'd0, _zz_DCountOnes_8};
  assign _zz_DCountOnes_10 = io_VD[3];
  assign _zz_DCountOnes_9 = {3'd0, _zz_DCountOnes_10};
  assign _zz_DCountOnes_11 = (_zz_DCountOnes_12 + _zz_DCountOnes_17);
  assign _zz_DCountOnes_12 = (_zz_DCountOnes_13 + _zz_DCountOnes_15);
  assign _zz_DCountOnes_14 = io_VD[4];
  assign _zz_DCountOnes_13 = {3'd0, _zz_DCountOnes_14};
  assign _zz_DCountOnes_16 = io_VD[5];
  assign _zz_DCountOnes_15 = {3'd0, _zz_DCountOnes_16};
  assign _zz_DCountOnes_17 = (_zz_DCountOnes_18 + _zz_DCountOnes_20);
  assign _zz_DCountOnes_19 = io_VD[6];
  assign _zz_DCountOnes_18 = {3'd0, _zz_DCountOnes_19};
  assign _zz_DCountOnes_21 = io_VD[7];
  assign _zz_DCountOnes_20 = {3'd0, _zz_DCountOnes_21};
  assign _zz_dw_disp = (_zz_dw_disp_1 + _zz_dw_disp_12);
  assign _zz_dw_disp_1 = (_zz_dw_disp_2 + _zz_dw_disp_7);
  assign _zz_dw_disp_2 = (_zz_dw_disp_3 + _zz_dw_disp_5);
  assign _zz_dw_disp_4 = qm_0;
  assign _zz_dw_disp_3 = {3'd0, _zz_dw_disp_4};
  assign _zz_dw_disp_6 = qm_1;
  assign _zz_dw_disp_5 = {3'd0, _zz_dw_disp_6};
  assign _zz_dw_disp_7 = (_zz_dw_disp_8 + _zz_dw_disp_10);
  assign _zz_dw_disp_9 = qm_2;
  assign _zz_dw_disp_8 = {3'd0, _zz_dw_disp_9};
  assign _zz_dw_disp_11 = qm_3;
  assign _zz_dw_disp_10 = {3'd0, _zz_dw_disp_11};
  assign _zz_dw_disp_12 = (_zz_dw_disp_13 + _zz_dw_disp_18);
  assign _zz_dw_disp_13 = (_zz_dw_disp_14 + _zz_dw_disp_16);
  assign _zz_dw_disp_15 = qm_4;
  assign _zz_dw_disp_14 = {3'd0, _zz_dw_disp_15};
  assign _zz_dw_disp_17 = qm_5;
  assign _zz_dw_disp_16 = {3'd0, _zz_dw_disp_17};
  assign _zz_dw_disp_18 = (_zz_dw_disp_19 + _zz_dw_disp_21);
  assign _zz_dw_disp_20 = qm_6;
  assign _zz_dw_disp_19 = {3'd0, _zz_dw_disp_20};
  assign _zz_dw_disp_22 = qm_7;
  assign _zz_dw_disp_21 = {3'd0, _zz_dw_disp_22};
  assign _zz_delta_1 = condition;
  assign _zz_delta = {3'd0, _zz_delta_1};
  assign _zz_dc_bias_new = (dc_bias - delta);
  assign _zz_dc_bias_new_1 = (dc_bias + delta);
  assign _zz_TMDS_Control_data_1 = io_CD;
  initial begin
  `ifndef SYNTHESIS
    dc_bias = {$urandom};
  `endif
  end

  always @(*) begin
    case(_zz_TMDS_Control_data_1)
      2'b00 : _zz_TMDS_Control_data = ctrlTokens_0;
      2'b01 : _zz_TMDS_Control_data = ctrlTokens_1;
      2'b10 : _zz_TMDS_Control_data = ctrlTokens_2;
      default : _zz_TMDS_Control_data = ctrlTokens_3;
    endcase
  end

  assign DCountOnes = (_zz_DCountOnes + _zz_DCountOnes_11);
  assign XNOR_1 = ((4'b0100 < DCountOnes) || ((DCountOnes == 4'b0100) && (io_VD[0] == 1'b0)));
  assign qm_0 = io_VD[0];
  assign qm_1 = ((qm_0 ^ io_VD[1]) ^ XNOR_1);
  assign qm_2 = ((qm_1 ^ io_VD[2]) ^ XNOR_1);
  assign qm_3 = ((qm_2 ^ io_VD[3]) ^ XNOR_1);
  assign qm_4 = ((qm_3 ^ io_VD[4]) ^ XNOR_1);
  assign qm_5 = ((qm_4 ^ io_VD[5]) ^ XNOR_1);
  assign qm_6 = ((qm_5 ^ io_VD[6]) ^ XNOR_1);
  assign qm_7 = ((qm_6 ^ io_VD[7]) ^ XNOR_1);
  assign qm_8 = (! XNOR_1);
  assign dw_disp = (_zz_dw_disp + 4'b1100);
  assign sign_eq = (dw_disp[3] == dc_bias[3]);
  assign inv_dw = (((dw_disp == 4'b0000) || (dc_bias == 4'b0000)) ? (! qm_8) : sign_eq);
  assign condition = ((qm_8 ^ (! sign_eq)) && (! ((dw_disp == 4'b0000) || (dc_bias == 4'b0000))));
  assign delta = (dw_disp - _zz_delta);
  assign dc_bias_new = (inv_dw ? _zz_dc_bias_new : _zz_dc_bias_new_1);
  assign qm_bits = {qm_8,{qm_7,{qm_6,{qm_5,{qm_4,{qm_3,{qm_2,{qm_1,qm_0}}}}}}}};
  assign qm_low = (inv_dw ? (~ qm_bits[7 : 0]) : qm_bits[7 : 0]);
  assign TMDS_data_Video = {{inv_dw,qm_8},qm_low};
  assign ctrlTokens_0 = 10'h354;
  assign ctrlTokens_1 = 10'h0ab;
  assign ctrlTokens_2 = 10'h154;
  assign ctrlTokens_3 = 10'h2ab;
  assign TMDS_Control_data = _zz_TMDS_Control_data;
  always @(posedge clk_out1) begin
    io_TMDS_data <= (io_VDE ? TMDS_data_Video : TMDS_Control_data);
    dc_bias <= (io_VDE ? dc_bias_new : 4'b0000);
  end


endmodule

module BufferCC_2 (
  input  wire [2:0]    io_dataIn,
  output wire [2:0]    io_dataOut,
  input  wire          clk_out2,
  input  wire          hdmiTx_toplevel_asyncReset_synchronized
);

  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [2:0]    buffers_0;
  (* async_reg = "true" *) reg        [2:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk_out2 or posedge hdmiTx_toplevel_asyncReset_synchronized) begin
    if(hdmiTx_toplevel_asyncReset_synchronized) begin
      buffers_0 <= 3'b000;
      buffers_1 <= 3'b000;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC_1 (
  input  wire          io_dataIn,
  output wire          io_dataOut,
  input  wire          clk_out2,
  input  wire          asyncReset
);

  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk_out2 or posedge asyncReset) begin
    if(asyncReset) begin
      buffers_0 <= 1'b1;
      buffers_1 <= 1'b1;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule

module BufferCC (
  input  wire [2:0]    io_dataIn,
  output wire [2:0]    io_dataOut,
  input  wire          clk_out1,
  input  wire          asyncReset
);

  (* async_reg = "true" , altera_attribute = "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW" *) reg        [2:0]    buffers_0;
  (* async_reg = "true" *) reg        [2:0]    buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk_out1 or posedge asyncReset) begin
    if(asyncReset) begin
      buffers_0 <= 3'b000;
      buffers_1 <= 3'b000;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
