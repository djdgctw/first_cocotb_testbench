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
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

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
