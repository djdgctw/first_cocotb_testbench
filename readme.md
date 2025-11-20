## 使用方法
1. make run-logged SIM=Verilator  // 生成并运行
2. make clean  // 清空生成目录
3. bash ./commit_push.sh -m "cocotb学习初代框架" -b main //提交到github上

## 项目结构
### 01_base
1. 创建一个简单的Verilog模块，并使用Cocotb进行测试,有基本的语法结构
### 02_Vga_image
1. 创建一个VGA显示图片的模块，并使用Cocotb进行测试，可以把仿真结果转为图片