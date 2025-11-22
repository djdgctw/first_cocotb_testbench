# import cocotb
# import random
# import logging
# from cocotb.clock import Clock
# from cocotb.triggers import RisingEdge
# logging.basicConfig(encoding="utf-8", level=logging.INFO)

# def to_signed(val: int, bits: int) -> int:
#     """把 0..2^bits-1 当作 bits 位两补码，翻译成有符号整数"""
#     if val & (1 << (bits - 1)):
#         val -= 1 << bits
#     return val


# def fmt_u8(val: int) -> str:
#     """格式化 8bit 无符号：十进制 + 十六进制 + 二进制"""
#     val &= 0xFF
#     return f"{val:3d} (0x{val:02X}, 0b{val:08b})"


# def fmt_s8(val: int) -> str:
#     """格式化 8bit 有符号：十进制 + 对应无符号显示"""
#     u = val & 0xFF
#     s = to_signed(u, 8)
#     return f"{s:4d} [u8={u:3d}, 0x{u:02X}]"


# def fmt_u9(val: int) -> str:
#     """格式化 9bit 无符号"""
#     val &= 0x1FF
#     return f"{val:3d} (0x{val:03X}, 0b{val:09b})"


# def fmt_s9(val: int) -> str:
#     """格式化 9bit 有符号，两补码"""
#     u = val & 0x1FF
#     s = to_signed(u, 9)
#     return f"{s:4d} [u9={u:3d}, 0x{u:03X}]"


# def to_signed(val, bits):
#     """把 0~2^bits-1 的无符号数，解释成有符号整数"""
#     if val & (1 << (bits - 1)):
#         val -= 1 << bits
#     return val


# async def wait_cycles(clk, cycles: int):
#     for _ in range(cycles):
#         await RisingEdge(clk)

# def log_case(logger, a_val: int, b_val: int, raw_sum: int):
#     a_u8 = a_val & 0xFF
#     b_u8 = b_val & 0xFF
#     s_u9 = raw_sum & 0x1FF

#     a_s8 = to_signed(a_u8, 8)
#     b_s8 = to_signed(b_u8, 8)
#     s_s9 = to_signed(s_u9, 9)

#     golden_signed = a_s8 + b_s8
#     golden_bits   = golden_signed & 0x1FF

#     s_lo     = s_u9 & 0xFF
#     s_carry  = (s_u9 >> 8) & 0x1
#     golden_u = a_u8 + b_u8
#     golden_lo    = golden_u & 0xFF
#     golden_carry = (golden_u >> 8) & 0x1

#     logger.info(
#         "\n"
#         f"== CURRENT CASE ==\n"
#         f"a: u8={fmt_u8(a_u8)}, s8={a_s8}\n"
#         f"b: u8={fmt_u8(b_u8)}, s8={b_s8}\n"
#         f"sum(raw): u9={fmt_u9(s_u9)}, s9={s_s9}\n"
#         f"\n"
#         f"[VIEW1: signed add]\n"
#         f"  a_s8 + b_s8 = {a_s8} + {b_s8} = {golden_signed}\n"
#         f"  golden_bits(9bit two's complement) = {golden_bits} -> u9={fmt_u9(golden_bits)}\n"
#         f"\n"
#         f"[VIEW2: unsigned + carry]\n"
#         f"  a_u8 + b_u8 = {a_u8} + {b_u8} = {golden_u}\n"
#         f"  golden: carry={golden_carry}, lo={golden_lo}\n"
#         f"  DUT:    carry={s_carry}, lo={s_lo}\n"
#     )

# @cocotb.test()
# async def test_add_signed_9bit(dut):
#     logger = logging.getLogger("simple_test")
#     logger.setLevel(logging.INFO)
#     logger.info("test start")

#     cocotb.start_soon(Clock(dut.clk, 10, unit="ns").start())

#     dut.a.value = 0
#     dut.b.value = 0
#     await RisingEdge(dut.clk)
#     await RisingEdge(dut.clk)

#     for _ in range(10):
#         a_val = random.randint(0, 255)
#         b_val = random.randint(0, 255)

#         dut.a.value = a_val
#         dut.b.value = b_val

#         await wait_cycles(dut.clk, 2)

#         raw_sum = int(dut.sum.value) & 0x1FF

#         # 自动“翻译”一整套视图
#         log_case(logger, a_val, b_val, raw_sum)

#         # 真正的断言：检查 IP 的 9bit 有符号行为
#         a_s8 = to_signed(a_val, 8)
#         b_s8 = to_signed(b_val, 8)
#         golden_signed = a_s8 + b_s8
#         golden_bits   = golden_signed & 0x1FF

#         assert raw_sum == golden_bits, \
#             f"9-bit signed add mismatch: expected bits {golden_bits}, got {raw_sum}"
import cocotb
import random
import logging
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

# pipeline latency settings (in clk cycles)
ADD_LATENCY = 1   # c_addsub_0 latency
MUL_LATENCY = 3   # mult_gen_0 latency (adjust if needed)

logging.basicConfig(level=logging.INFO)


def to_signed(val: int, bits: int) -> int:
    """Interpret val (0 .. 2^bits-1) as signed two's complement."""
    if val & (1 << (bits - 1)):
        val -= 1 << bits
    return val


async def wait_cycles(clk, cycles: int):
    for _ in range(cycles):
        await RisingEdge(clk)


@cocotb.test()
async def test_add_and_mult(dut):
    """
    Random test:
      - 8-bit + 8-bit -> 9-bit (sum)
      - 18-bit × 18-bit (signed) -> 36-bit (P)
    """
    logger = logging.getLogger("simple_test")
    logger.setLevel(logging.INFO)
    logger.info("test_add_and_mult start")

    # start clock: 10 ns period = 100 MHz
    cocotb.start_soon(Clock(dut.clk, 10, unit="ns").start())

    # init
    dut.a.value = 0
    dut.b.value = 0
    dut.c.value = 0
    dut.d.value = 0
    await wait_cycles(dut.clk, 2)

    NUM_CASES = 20
    for i in range(NUM_CASES):
        # ---- generate random inputs ----
        a_val = random.randint(0, 255)              # 8-bit
        b_val = random.randint(0, 255)              # 8-bit
        c_val = random.randint(0, (1 << 18) - 1)    # 18-bit
        d_val = random.randint(0, (1 << 18) - 1)    # 18-bit

        # drive DUT
        dut.a.value = a_val
        dut.b.value = b_val
        dut.c.value = c_val
        dut.d.value = d_val

        # wait long enough for both pipelines
        max_lat = max(ADD_LATENCY, MUL_LATENCY)
        await wait_cycles(dut.clk, max_lat)

        # ---- read DUT outputs ----
        dut_sum = int(dut.sum.value) & 0x1FF              # 9 bits
        dut_p   = int(dut.P.value) & ((1 << 36) - 1)      # 36 bits

        # ---- golden model: ADD (9-bit two's complement) ----
        # treat a, b as 8-bit signed
        a_s = to_signed(a_val, 8)
        b_s = to_signed(b_val, 8)
        golden_sum_signed = a_s + b_s
        golden_sum_bits   = golden_sum_signed & 0x1FF

        # ---- golden model: MULT (18-bit signed × 18-bit signed) ----
        c_s = to_signed(c_val, 18)
        d_s = to_signed(d_val, 18)
        golden_p_signed = c_s * d_s
        golden_p_bits   = golden_p_signed & ((1 << 36) - 1)

        logger.info(
            "[case %02d] "
            "a=%3d (s=%4d), b=%3d (s=%4d), "
            "sum_bits=%4d (golden_bits=%4d); "
            "c=%6d (s=%9d), d=%6d (s=%9d), "
            "P_bits=%12d (golden_bits=%12d)",
            i,
            a_val, a_s,
            b_val, b_s,
            dut_sum, golden_sum_bits,
            c_val, c_s,
            d_val, d_s,
            dut_p, golden_p_bits,
        )

        # ---- assertions ----
        assert dut_sum == golden_sum_bits, (
            f"SUM mismatch: "
            f"a={a_val} (s={a_s}), b={b_val} (s={b_s}), "
            f"got {dut_sum}, expected {golden_sum_bits}"
        )

        assert dut_p == golden_p_bits, (
            f"MULT mismatch: "
            f"c={c_val} (s={c_s}), d={d_val} (s={d_s}), "
            f"got {dut_p}, expected {golden_p_bits}"
        )

    logger.info("test_add_and_mult finished OK")
