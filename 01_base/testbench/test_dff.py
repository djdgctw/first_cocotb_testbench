# "random" 是 Python 的标准库，随 Python 一起安装
import random
# "cocotb" 不是标准库，我们已在虚拟环境中通过 "pip install cocotb" 安装
import cocotb
# 下面是出于书写便利的导入方式。如果不从 cocotb.clock 和 cocotb.triggers 中显式导入 Clock 和 FallingEdge，
# 那么在代码中每次使用时都必须写成 "cocotb.clock.Clock" 或 "cocotb.triggers.FallingEdge"。
# 不这样做会导致代码冗长且可读性差。因此，这种导入方式是一种良好的编程习惯。
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
import logging

# @cocotb.test() 是一个 Python 装饰器，用于告诉 cocotb 框架：紧接其下的函数是一个 cocotb 测试用例。
@cocotb.test()
# async 是 Python 的保留关键字，表示函数 "test_dff_simple" 是异步的。
# 简单来说，该函数可以在执行过程中等待其他操作完成后再继续。
async def test_dff_simple(dut):
    # 函数定义下方用三个引号括起来的内容是文档字符串（docstring）。
    # 在 cocotb 中，测试函数的 docstring 会在运行测试时显示出来。
    """ 测试输入 d 能正确传递到输出 q """
     # Create a logger for this testbench
    logger = logging.getLogger("my_testbench")
    logger.setLevel(logging.DEBUG) #加上这行后面的就正确显示到日志
    logger.debug("This is a debug message")
    logger.info("This is an info message")
    # 创建时钟对象：第一个参数是 DUT 中的时钟信号，第二个参数是周期，第三个参数是周期的单位。
    clock = Clock(dut.clk, 10, units="us")  # 在 clk 端口上创建一个周期为 10 微秒的时钟
    # clock.start() 也是一个异步函数，调用 cocotb.start_soon() 后会立即启动时钟，
    # 而不会阻塞当前测试函数的执行。时钟将持续运行直到仿真结束。
    cocotb.start_soon(clock.start())  # 启动时钟

    # 一个简单的 Python for 循环，共执行 10 次。
    # 我们的测试将对 10 个随机值进行验证，然后结束。
    for i in range(10):
        # 生成一个随机值，取值为 0 或 1
        val = random.randint(0, 7)
        # 将刚才生成的随机值赋给输入端口 d。
        # 注意：必须使用 .value 属性，直接写 "dut.d = val" 是无效的。
        dut.d.value = val  # 将随机值 val 赋给输入端口 d
        # await 是 Python 的保留关键字，用于等待一个异步操作完成。
        # 此处等待时钟 clk 的下降沿到来。
        await FallingEdge(dut.clk)
        # 打印当前周期的 d 和 q 值到日志
        logger.info(f"周期 {i}: d = {dut.d.value}, q = {dut.q.value}")
        # 检查输出 q 是否等于 val；如果不等，则抛出断言错误，并显示指定的错误信息。
        assert dut.q.value == val, f"在第 {i} 个周期，输出 q 的值不正确。实际得到 {dut.q.value}，期望值为 {val}"