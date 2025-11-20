# 将当前目录下的 testbench 文件夹加入 Python 模块搜索路径（PYTHONPATH），
# 这样 cocotb 在运行时就能找到你的测试文件（例如 test_dff.py）。
export PYTHONPATH := $(PWD)/testbench:$(PYTHONPATH)

# 指定被测设计（DUT）的语言为 Verilog（也支持 SystemVerilog，cocotb 通常将其归为 Verilog）
TOPLEVEL_LANG = verilog

# 指定要仿真的 Verilog/SystemVerilog 源文件路径。
# 此处使用的是 src 目录下的 dff.sv 文件（一个 D 触发器模块）。
VERILOG_SOURCES = $(PWD)/src/Top.v

# 指定顶层模块（top-level module）的名称，必须与 Verilog 文件中的 module 名称一致。
TOPLEVEL = Top

# 指定包含 cocotb 测试用例的 Python 模块名（即 testbench/ 目录下的 test_dff.py 文件，不含 .py 后缀）。
MODULE = test_Top

# 默认仿真器设为 Verilator，避免未显式指定 SIM 时回退到 Icarus
SIM ?= verilator

# 包含 cocotb 提供的标准仿真 Makefile。
# `cocotb-config --makefiles` 命令会返回 cocotb 安装时生成的 Makefile 路径，
# 从而自动配置仿真器（如 Icarus Verilog、VCS、ModelSim 等）和运行环境。
include $(shell cocotb-config --makefiles)/Makefile.sim

# ---- 辅助目标 --------------------------------------------------------------

# LOG_DIR 指定日志目录（默认 logs/），可通过命令行覆盖
LOG_DIR ?= logs
# SIM_LABEL 用于生成日志文件名，如果未指定 SIM，则回退为 default_sim
SIM_LABEL := $(if $(strip $(SIM)),$(strip $(SIM)),default_sim)

# run-logged、clean 均声明为伪目标
.PHONY: run-logged run-logged-waves clean

# run-logged 目标依赖日志目录；执行时会调用默认 sim 规则，并把所有终端输出同步写入日志文件，
# 同时强制启用 Verilator 波形导出并把 VCD 复制到日志目录（统一命名为 report.*）
run-logged: | $(LOG_DIR)
	@log="$(LOG_DIR)/report.log"; \
	  wave="$(LOG_DIR)/report.vcd"; \
	  echo "[cocotb] 仿真输出将记录到 $$log"; \
	  echo "[cocotb] Verilator 将生成波形文件 $$wave"; \
	  if VERILATOR_TRACE=1 $(MAKE) --no-print-directory sim 2>&1 | tee "$$log"; then \
	    src=""; \
	    if [ -f sim_build/dump.vcd ]; then \
	      src="sim_build/dump.vcd"; \
	    elif [ -f dump.vcd ]; then \
	      src="dump.vcd"; \
	    fi; \
	    if [ -n "$$src" ]; then \
	      cp "$$src" "$$wave"; \
	      echo "[cocotb] 波形文件已保存：$$wave"; \
	      if [ "$$src" = "dump.vcd" ]; then rm -f "$$src"; fi; \
	    else \
	      echo "[cocotb] 未找到波形文件，可能仿真提前失败或未启用追踪"; \
	    fi; \
	  else \
	    exit $$?; \
	  fi

# run-logged-waves 作为 run-logged 的别名，方便记忆
run-logged-waves: run-logged

# clean 目标会删除常见的仿真生成物，如日志目录、构建缓存及 results.xml
clean::
	@echo "[cocotb] 正在清理仿真生成文件"
	@rm -rf $(LOG_DIR) sim_build results.xml

# 日志目录不存在时自动创建
$(LOG_DIR):
	@mkdir -p $@
