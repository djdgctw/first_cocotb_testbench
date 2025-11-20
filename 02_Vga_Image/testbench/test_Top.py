import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
import numpy as np
from PIL import Image

# 水平 / 垂直时序常量，和 Spinal 里的 setAS_h640_v480_r60 一致
H_SYNC_START  = 0x05F  # 95
H_SYNC_END    = 0x31F  # 799
H_COLOR_START = 0x08F  # 143
H_COLOR_END   = 0x30F  # 783

V_SYNC_START  = 0x001  # 1
V_SYNC_END    = 0x20C  # 524
V_COLOR_START = 0x022  # 34
V_COLOR_END   = 0x202  # 514

H_PERIOD     = 800  # 一行 800 个计数

# 复位后的期望值
RESET_H_COUNTER  = 0
RESET_H_SYNC     = 1
RESET_H_COLOREN  = 0
RESET_V_COUNTER  = 0
RESET_V_SYNC     = 1
RESET_V_COLOREN  = 0

#等待指定数量的时钟周期
async def wait_cycles(dut, cycles):
    for _ in range(cycles):
        await RisingEdge(dut.clk)
@cocotb.test()
async def test_top(dut):
     # 启动 25MHz 时钟
    cocotb.start_soon(Clock(dut.clk, 40, units='ns').start())
    # 等几个周期让复位稳定
    dut.reset.value = 1
    await wait_cycles(dut, 2)

    # 这里 VgaCtrl 是带 async reset 的，所以 reset=1 时寄存器应该已经清零
    # （更保险也可以再加一个 RisingEdge(dut.clk) 再测）
    assert int(dut.vgaCtrl_1.h_counter.value)  == RESET_H_COUNTER
    assert int(dut.vgaCtrl_1.h_sync.value)     == RESET_H_SYNC
    assert int(dut.vgaCtrl_1.h_colorEn.value)  == RESET_H_COLOREN
    assert int(dut.vgaCtrl_1.v_counter.value)  == RESET_V_COUNTER
    assert int(dut.vgaCtrl_1.v_sync.value)     == RESET_V_SYNC
    assert int(dut.vgaCtrl_1.v_colorEn.value)  == RESET_V_COLOREN

    dut._log.info("复位检测成功")

    # 释放复位
    dut.reset.value = 0
    await wait_cycles(dut, 2)

    # ========= 等到进入第一帧的可见区起点 =========
    dut._log.info("等待进入第一帧的可见区起点...")

    # 等到第一个可见像素：Coloren==1 且 v/h 在可见区内
    while True:
        await RisingEdge(dut.clk)

        coloren = int(dut.io_VGA_Coloren.value)
        v_cnt   = int(dut.vgaCtrl_1.v_counter.value)
        h_cnt   = int(dut.vgaCtrl_1.h_counter.value)

        if (coloren == 1 and
            (V_COLOR_START <= v_cnt < V_COLOR_END) and
            (H_COLOR_START <= h_cnt < H_COLOR_END)):
            dut._log.info(f"到达可见区起点: v={v_cnt}, h={h_cnt}")
            break

    # ========= 整帧图像采样 =========
    width  = H_COLOR_END - H_COLOR_START   # 640
    height = V_COLOR_END - V_COLOR_START   # 480

    dut._log.info(f"开始采样一帧图像: 宽={width}, 高={height}")

    frame = np.zeros((height, width, 3), dtype=np.uint8)

    visible_width  = width
    half_width     = visible_width // 2   # 左半/右半分界

    # 对每一行
    for y in range(height):
        for x in range(width):
            # 当前位置应该已经在某个 Coloren==1 的像素上
            coloren = int(dut.io_VGA_Coloren.value)
            assert coloren == 1, f"期望 Coloren=1，但在 (y={y},x={x}) 读到 {coloren}"

            # 读颜色
            r = int(dut.io_VGA_color_r.value)
            g = int(dut.io_VGA_color_g.value)
            b = int(dut.io_VGA_color_b.value)

            # 颜色检查：左半黑，右半红
            if x < half_width:
                exp = (0, 0, 0)
            else:
                exp = (255, 0, 0)

            if (r, g, b) != exp:
                raise AssertionError(
                    f"像素颜色错误 at (y={y}, x={x}): "
                    f"got ({r},{g},{b}), expected {exp}"
                )

            # 存进 frame 数组
            frame[y, x, :] = [r, g, b]

            # 走到下一个“可见像素”
            # 先一步时钟
            await RisingEdge(dut.clk)
            # 如果中间经过消隐（Coloren==0），就一直等到下一个 Coloren==1
            while int(dut.io_VGA_Coloren.value) == 0:
                await RisingEdge(dut.clk)

        # 行结束后，我们现在停在下一行的第一个可见像素
        dut._log.debug(f"完成第 {y} 行采样")

    dut._log.info("一帧颜色条检查通过！")

    # ========= 存成 PNG 图片 =========
    img = Image.fromarray(frame, mode="RGB")
    img.save("/home/fyt/Spinal_FPGA/study_doc/cocotb_sim_VGA/logs/frame0.png")
    dut._log.info("已将一帧图像保存为 frame0.png")