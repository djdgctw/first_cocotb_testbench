# 将当前目录下的 testbench 文件夹加入 Python 模块搜索路径
export PYTHONPATH := $(PWD)/testbench:$(PYTHONPATH)

export LANG := en_US.UTF-8
export LC_ALL := en_US.UTF-8
export PYTHONIOENCODING := utf-8

# ===== 路径配置 =====
PROJECT_ROOT ?= /home/fyt/B/Prj_SpinalHDL_Vivado/01_HDMI/project_HDMI
IP_SIM_SCRIPTS_DIR := $(PROJECT_ROOT)/project_HDMI.ip_user_files/sim_scripts

# ===== cocotb 核心配置 =====
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(PWD)/src/HdmiCocotbTop.v

# =======================================================
# Xilinx 库与仿真参数
# =======================================================
XILINX_VIVADO_DIR ?= /opt/Xilinx/Vivado/2022.2
XILINX_LIB_DIR ?= /home/fyt/Modelsim/lib

# 链接库
SIM_ARGS += -L $(XILINX_LIB_DIR)/unisims_ver \
            -L $(XILINX_LIB_DIR)/unimacro_ver \
            -L $(XILINX_LIB_DIR)/secureip \
            glbl

# 指定 WLF 输出路径
VSIM_WLF ?= $(PWD)/sim_build/vsim.wlf
SIM_ARGS += -wlf $(VSIM_WLF)

# =======================================================
# 【核心】波形录制配置
# =======================================================
# 1. 开启信号可见性
SIM_ARGS += -voptargs=+acc

# 2. 指定执行 wave.do (使用花括号包裹，防止转义错误)
# 注意：确保你的 wave.do 文件就在 Makefile 同级目录下
SIM_ARGS += -do {do $(PWD)/wave.do}

# 添加 glbl 源码
VERILOG_SOURCES += $(XILINX_VIVADO_DIR)/data/verilog/src/glbl.v

# Include IP 源码
MK_DIR := $(PWD)/mk
include $(wildcard $(MK_DIR)/ip_*.mk)

# Cocotb 顶层设置
COCOTB_TOPLEVEL = HdmiCocotbTop
COCOTB_TEST_MODULES = my_test
SIM ?= ModelSim

# 引入 Cocotb 标准 Makefile
include $(shell cocotb-config --makefiles)/Makefile.sim

# ===== 辅助目标 =====
LOG_DIR ?= logs
# 固定输出基名，用户要求“输出文件都叫 report”
REPORT_BASENAME ?= report
SIM_LABEL := $(if $(strip $(SIM)),$(strip $(SIM)),default_sim)
# 统一导出文件名（不再使用时间戳），便于脚本/IDE 固定引用
REPORT_LOG  ?= $(LOG_DIR)/$(REPORT_BASENAME).log
REPORT_WLF  ?= $(LOG_DIR)/$(REPORT_BASENAME).wlf
REPORT_XML  ?= $(LOG_DIR)/$(REPORT_BASENAME).xml

.PHONY: all run-logged clean gen_ip_mk

all: clean run-logged

run-logged: | $(LOG_DIR)
	@echo "[cocotb] Starting simulation..."; \
	  log="$(REPORT_LOG)"; \
	  wave="$(REPORT_WLF)"; \
	  xml_tmp="results.xml"; \
	  if $(MAKE) --no-print-directory sim 2>&1 | tee "$$log"; then \
	    if [ -f "$(VSIM_WLF)" ]; then \
	      cp -f "$(VSIM_WLF)" "$$wave"; \
	      echo "✅ 波形已生成: $$wave"; \
	      echo "✅ 日志路径:  $$log"; \
	    else \
	      echo "❌ 警告: 仿真成功但未找到波形文件!"; \
	      echo "❌ 请检查 sim_build 目录: $(VSIM_WLF)"; \
	    fi; \
	    if [ -f "$$xml_tmp" ]; then \
	      mv -f "$$xml_tmp" "$(REPORT_XML)"; \
	    fi; \
	  else \
	    echo "❌ 仿真失败"; \
	    exit 1; \
	  fi
clean::
	@rm -rf $(LOG_DIR) sim_build results.xml
	@rm -f *.log

gen_ip_mk:
	@mkdir -p $(MK_DIR)
	@for do in $$(find "$(IP_SIM_SCRIPTS_DIR)" -type f -path "*/modelsim/compile.do"); do \
	    ip_simdir=$$(dirname "$$do"); \
	    ip_dir=$$(dirname "$$ip_simdir"); \
	    ip_name=$$(basename "$$ip_dir"); \
	    out="$(MK_DIR)/ip_$${ip_name}_sources.mk"; \
	    python3 tools/gen_sources_from_do.py "$$do" > "$$out"; \
	done

$(LOG_DIR):
	@mkdir -p $@
