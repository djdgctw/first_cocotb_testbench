// Generator : SpinalHDL v1.13.0    git head : d9d72474863badf47d8585d187f3e04ae4749c59
// Component : Top

`timescale 1ns/1ps

module Top (
  output wire          io_VGA_hsync,
  output wire          io_VGA_vsync,
  output wire          io_VGA_Coloren,
  output wire [7:0]    io_VGA_color_r,
  output wire [7:0]    io_VGA_color_g,
  output wire [7:0]    io_VGA_color_b,
  input  wire          clk,
  input  wire          reset
);

  wire       [11:0]   vgaCtrl_1_io_timings_h_colorStart;
  wire       [11:0]   vgaCtrl_1_io_timings_h_colorEnd;
  reg                 vgaCtrl_1_io_pixel_valid;
  reg        [7:0]    vgaCtrl_1_io_pixel_payload_r;
  reg        [7:0]    vgaCtrl_1_io_pixel_payload_g;
  reg        [7:0]    vgaCtrl_1_io_pixel_payload_b;
  wire                vgaCtrl_1_io_pixel_ready;
  wire                vgaCtrl_1_io_VGA_hsync;
  wire                vgaCtrl_1_io_VGA_vsync;
  wire                vgaCtrl_1_io_VGA_Coloren;
  wire       [7:0]    vgaCtrl_1_io_VGA_color_r;
  wire       [7:0]    vgaCtrl_1_io_VGA_color_g;
  wire       [7:0]    vgaCtrl_1_io_VGA_color_b;
  wire                vgaCtrl_1_io_error;
  wire                vgaCtrl_1_io_frameStart;
  wire       [11:0]   vgaCtrl_1_io_hCount;
  wire       [11:0]   vgaCtrl_1_io_vCount;
  wire       [11:0]   _zz_hMid;
  wire       [11:0]   hVisibleWidth;
  wire       [11:0]   hMid;
  wire                when_VGACtrl_l199;
  wire                when_VGACtrl_l203;

  assign _zz_hMid = (hVisibleWidth >>> 1);
  VgaCtrl vgaCtrl_1 (
    .io_softReset            (1'b0                                   ), //i
    .io_timings_h_syncStart  (12'h05f                                ), //i
    .io_timings_h_syncEnd    (12'h31f                                ), //i
    .io_timings_h_colorStart (vgaCtrl_1_io_timings_h_colorStart[11:0]), //i
    .io_timings_h_colorEnd   (vgaCtrl_1_io_timings_h_colorEnd[11:0]  ), //i
    .io_timings_v_syncStart  (12'h001                                ), //i
    .io_timings_v_syncEnd    (12'h20c                                ), //i
    .io_timings_v_colorStart (12'h022                                ), //i
    .io_timings_v_colorEnd   (12'h202                                ), //i
    .io_pixel_valid          (vgaCtrl_1_io_pixel_valid               ), //i
    .io_pixel_ready          (vgaCtrl_1_io_pixel_ready               ), //o
    .io_pixel_payload_r      (vgaCtrl_1_io_pixel_payload_r[7:0]      ), //i
    .io_pixel_payload_g      (vgaCtrl_1_io_pixel_payload_g[7:0]      ), //i
    .io_pixel_payload_b      (vgaCtrl_1_io_pixel_payload_b[7:0]      ), //i
    .io_VGA_hsync            (vgaCtrl_1_io_VGA_hsync                 ), //o
    .io_VGA_vsync            (vgaCtrl_1_io_VGA_vsync                 ), //o
    .io_VGA_Coloren          (vgaCtrl_1_io_VGA_Coloren               ), //o
    .io_VGA_color_r          (vgaCtrl_1_io_VGA_color_r[7:0]          ), //o
    .io_VGA_color_g          (vgaCtrl_1_io_VGA_color_g[7:0]          ), //o
    .io_VGA_color_b          (vgaCtrl_1_io_VGA_color_b[7:0]          ), //o
    .io_error                (vgaCtrl_1_io_error                     ), //o
    .io_frameStart           (vgaCtrl_1_io_frameStart                ), //o
    .io_hCount               (vgaCtrl_1_io_hCount[11:0]              ), //o
    .io_vCount               (vgaCtrl_1_io_vCount[11:0]              ), //o
    .clk                     (clk                                    ), //i
    .reset                   (reset                                  )  //i
  );
  assign vgaCtrl_1_io_timings_h_colorEnd = 12'h30f;
  assign vgaCtrl_1_io_timings_h_colorStart = 12'h08f;
  assign hVisibleWidth = (vgaCtrl_1_io_timings_h_colorEnd - vgaCtrl_1_io_timings_h_colorStart);
  assign hMid = (vgaCtrl_1_io_timings_h_colorStart + _zz_hMid);
  always @(*) begin
    vgaCtrl_1_io_pixel_valid = 1'b0;
    if(vgaCtrl_1_io_pixel_ready) begin
      if(when_VGACtrl_l199) begin
        vgaCtrl_1_io_pixel_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    vgaCtrl_1_io_pixel_payload_r = 8'h0;
    if(vgaCtrl_1_io_pixel_ready) begin
      if(when_VGACtrl_l199) begin
        if(when_VGACtrl_l203) begin
          vgaCtrl_1_io_pixel_payload_r = 8'h0;
        end else begin
          vgaCtrl_1_io_pixel_payload_r = 8'hff;
        end
      end
    end
  end

  always @(*) begin
    vgaCtrl_1_io_pixel_payload_g = 8'h0;
    if(vgaCtrl_1_io_pixel_ready) begin
      if(when_VGACtrl_l199) begin
        if(when_VGACtrl_l203) begin
          vgaCtrl_1_io_pixel_payload_g = 8'h0;
        end else begin
          vgaCtrl_1_io_pixel_payload_g = 8'h0;
        end
      end
    end
  end

  always @(*) begin
    vgaCtrl_1_io_pixel_payload_b = 8'h0;
    if(vgaCtrl_1_io_pixel_ready) begin
      if(when_VGACtrl_l199) begin
        if(when_VGACtrl_l203) begin
          vgaCtrl_1_io_pixel_payload_b = 8'h0;
        end else begin
          vgaCtrl_1_io_pixel_payload_b = 8'h0;
        end
      end
    end
  end

  assign when_VGACtrl_l199 = ((vgaCtrl_1_io_timings_h_colorStart <= vgaCtrl_1_io_hCount) && (vgaCtrl_1_io_hCount <= vgaCtrl_1_io_timings_h_colorEnd));
  assign when_VGACtrl_l203 = (vgaCtrl_1_io_hCount <= hMid);
  assign io_VGA_hsync = vgaCtrl_1_io_VGA_hsync;
  assign io_VGA_vsync = vgaCtrl_1_io_VGA_vsync;
  assign io_VGA_Coloren = vgaCtrl_1_io_VGA_Coloren;
  assign io_VGA_color_r = vgaCtrl_1_io_VGA_color_r;
  assign io_VGA_color_g = vgaCtrl_1_io_VGA_color_g;
  assign io_VGA_color_b = vgaCtrl_1_io_VGA_color_b;

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
  input  wire          clk,
  input  wire          reset
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
  always @(posedge clk or posedge reset) begin
    if(reset) begin
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
