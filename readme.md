## 使用方法
1. make run-logged SIM=Verilator  // 生成并运行
2. make clean  // 清空生成目录
3. bash ./commit_push.sh -m "cocotb学习初代框架" -b main //提交到github上

## 项目结构
### 01_base
1. 创建一个简单的Verilog模块，并使用Cocotb进行测试,有基本的语法结构
### 02_Vga_image
1. 创建一个VGA显示图片的模块，并使用Cocotb进行测试，可以把仿真结果转为图片
### 03_modelsim_vivado_ip_sim
1.基于 Cocotb + ModelSim，联合仿真 Vivado 生成的 c_addsub（加法器）与 mult_gen（乘法器）IP，通过自动解析 IP 仿真依赖、精确处理管线延迟，实现对加法（8+8→9bit）与乘法（18×18→36bit）功能的同步随机验证。

### 04_sim_HDMI
1. 基于 Cocotb + ModelSim 的 HDMI 仿真工程；顶层 `HdmiCocotbTop.v`，跑 640x480 彩条，产物固定输出为 `logs/report.log`、`logs/report.wlf`，支持vivado硬件原语仿真。
2. 运行：`make -C 04_sim_HDMI run-logged`；查看波形：`vsim -view 04_sim_HDMI/logs/report.wlf`。
