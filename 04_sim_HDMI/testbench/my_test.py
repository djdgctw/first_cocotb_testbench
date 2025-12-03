import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_hdmi_color_bars(dut):
    """
    仿真 HDMI 输出 640x480 彩条
    """
    
    # 1. 启动时钟
    # 640x480 @ 60Hz -> Pixel Clock ~ 25 MHz (40ns)
    # Serial Clock (5x) ~ 125 MHz (8ns)
    
    cocotb.start_soon(Clock(dut.io_clk_pixel, 40, units="ns").start())
    cocotb.start_soon(Clock(dut.io_clk_serial, 8, units="ns").start())

    # 2. 复位
    dut.io_reset.value = 1
    await Timer(100, units="ns")
    dut.io_reset.value = 0
    
    print("Reset released, starting simulation...")

    # 3. 运行仿真
    # 跑足够长的时间以看到 HSync 和 有效数据区域
    # 一行大约需要 800 个像素周期。跑 2000 个周期大概能看到 2-3 行。
    # 2000 pixel clk * 40ns = 80000 ns = 80 us
    
    # 如果你想看完整的一帧，需要跑很久（16ms），生成的文件会很大。
    # 这里我们跑 50微秒，足够看清行同步和彩条数据了。
    
    await Timer(16, units="ms")
    
    print("Simulation finished!")