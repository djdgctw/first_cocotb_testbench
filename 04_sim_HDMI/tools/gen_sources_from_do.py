#!/usr/bin/env python3
import sys
from pathlib import Path


def parse_do_file(do_path: Path):
    """
    解析 Vivado 生成的 ModelSim compile.do 文件，提取所有 vcom/vlog 命令里的源文件路径。
    返回 (vhdl_files, vlog_files)，都是绝对路径、去重、排序后的列表。
    """
    vhdl_files = set()
    vlog_files = set()

    if not do_path.is_file():
        print(f"ERROR: do file not found: {do_path}", file=sys.stderr)
        sys.exit(1)

    # Vivado 的路径是相对 compile.do 所在目录的，这里先记下来
    base_dir = do_path.parent

    # 处理续行符 "\"：把多行 vcom / vlog 命令拼成一行来解析
    logical_lines = []
    buf = ""
    with do_path.open("r", encoding="utf-8", errors="ignore") as f:
        for raw in f:
            line = raw.strip()
            if not line or line.startswith("#"):
                continue

            if buf:
                buf += " " + line
            else:
                buf = line

            if buf.endswith("\\"):
                buf = buf[:-1].rstrip()
            else:
                logical_lines.append(buf)
                buf = ""
        if buf:
            logical_lines.append(buf)

    # 从 vcom / vlog 命令中提取文件路径
    for line in logical_lines:
        if line.startswith("vcom") or line.startswith("vlog"):
            parts = line.split()
            for token in parts:
                # 跳过选项
                if token.startswith("-") or token.startswith("+"):
                    continue
                # 去掉引号
                token = token.strip('"')
                lower = token.lower()
                if lower.endswith((".vhd", ".vhdl", ".v", ".sv")):
                    # 把相对路径变成绝对路径（相对于 compile.do 所在目录）
                    path = (base_dir / token).resolve()
                    if lower.endswith((".vhd", ".vhdl")):
                        vhdl_files.add(str(path))
                    else:
                        vlog_files.add(str(path))

    return sorted(vhdl_files), sorted(vlog_files)


def emit_makefile(vhdl_files, vlog_files):
    """
    输出为 Makefile 片段，方便直接 include。
    注意第一行要带 "\"，否则会触发 missing separator。
    """
    if vhdl_files:
        print("VHDL_SOURCES += \\")
        for p in vhdl_files:
            print(f"  {p} \\")
        print()
    if vlog_files:
        print("VERILOG_SOURCES += \\")
        for p in vlog_files:
            print(f"  {p} \\")
        print()


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} path/to/compile.do", file=sys.stderr)
        sys.exit(1)

    do_path = Path(sys.argv[1]).expanduser().resolve()
    vhdl_files, vlog_files = parse_do_file(do_path)
    emit_makefile(vhdl_files, vlog_files)


if __name__ == "__main__":
    main()
