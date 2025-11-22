# 将当前目录下的 testbench 文件夹加入 Python 模块搜索路径（PYTHONPATH），
# 这样 cocotb 在运行时就能找到你的测试文件（例如 my_test.py）。
export PYTHONPATH := $(PWD)/testbench:$(PYTHONPATH)

# ===== 强制使用 UTF-8，尽量避免 cocotb 日志中文乱码 =====
export LANG := en_US.UTF-8
export LC_ALL := en_US.UTF-8
export PYTHONIOENCODING := utf-8

# ===== Vivado 工程根路径（你只要改这一行就能复用这套逻辑） =====
# 这里指向含有 project_HDMI.xpr 的工程目录
PROJECT_ROOT ?= /home/fyt/B/Prj_SpinalHDL_Vivado/01_HDMI/project_HDMI

# Vivado 生成 IP 仿真脚本的目录（默认结构）
IP_SIM_SCRIPTS_DIR := $(PROJECT_ROOT)/project_HDMI.ip_user_files/sim_scripts

# ===== cocotb 仿真配置 =====

# 指定被测设计（DUT）的语言为 Verilog
TOPLEVEL_LANG = verilog

# 顶层 Verilog 源文件
VERILOG_SOURCES = $(PWD)/src/add.v

# 自动 include 所有由 gen_ip_mk 生成的 IP 源文件列表
MK_DIR := $(PWD)/mk
include $(wildcard $(MK_DIR)/ip_*.mk)

# 顶层 RTL 模块名（你的 add 包了一层 c_addsub_0）
COCOTB_TOPLEVEL = add

# 测试用例 Python 模块名（testbench/my_test.py）
COCOTB_TEST_MODULES = my_test

# 默认仿真器设为 ModelSim
SIM ?= ModelSim

# 包含 cocotb 提供的标准仿真 Makefile（里面定义了 sim / results.xml 等目标）
include $(shell cocotb-config --makefiles)/Makefile.sim

# ===== 辅助目标 & 日志 =====

LOG_DIR ?= logs
SIM_LABEL := $(if $(strip $(SIM)),$(strip $(SIM)),default_sim)

.PHONY: all run-logged clean gen_ip_mk

# all：先 clean，再跑一次带日志的仿真
all: clean run-logged

# 带日志运行：调用 cocotb 自带的 sim 目标，并把终端输出 tee 到日志文件里
run-logged: | $(LOG_DIR)
	@ts=$$(date +%Y%m%d_%H%M%S); \
	  log="$(LOG_DIR)/$(SIM_LABEL)_$$ts.log"; \
	  echo "[cocotb] simulation output will be saved to $$log"; \
	  $(MAKE) --no-print-directory sim 2>&1 | tee "$$log"

# 清理仿真生成物
clean::
	@echo "[cocotb] cleaning simulation artifacts"
	@rm -rf $(LOG_DIR) sim_build results.xml
	@rm -f *.log

# 一键扫描 Vivado 工程下所有 IP 的 compile.do，生成 mk/ip_<ipname>_sources.mk
gen_ip_mk:
	@mkdir -p $(MK_DIR)
	@echo "[gen_ip_mk] removing old mk/ip_*.mk files..."
	@rm -f $(MK_DIR)/ip_*.mk
	@echo "[scan] searching Vivado IP modelsim/compile.do in $(IP_SIM_SCRIPTS_DIR) ..."
	@for do in $$(find "$(IP_SIM_SCRIPTS_DIR)" -type f -path "*/modelsim/compile.do"); do \
	    ip_simdir=$$(dirname "$$do"); \
	    ip_dir=$$(dirname "$$ip_simdir"); \
	    ip_name=$$(basename "$$ip_dir"); \
	    out="$(MK_DIR)/ip_$${ip_name}_sources.mk"; \
	    echo "[gen] $$do --> $$out"; \
	    python3 tools/gen_sources_from_do.py "$$do" > "$$out"; \
	done
	@echo "[gen_ip_mk] done."

# 日志目录不存在时自动创建
$(LOG_DIR):
	@mkdir -p $@
