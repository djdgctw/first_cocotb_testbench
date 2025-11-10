#!/usr/bin/env bash
# shellcheck disable=SC2001
#
# 简易 Git 提交/推送脚本（适用于 Linux Bash）
# 用法示例：
#   ./commit_push.ps1 -m "feat: update" -b main -u "djdgctw" -e "3027610893@qq.com"
# 说明：
#   - 未配置 user.name / user.email 时可通过 -u/-e 设置；
#   - 自动忽略并清理 .idea 目录；
#   - 默认分支 main，默认提交信息 "auto commit"。

set -euo pipefail

message="auto commit"
branch="main"
username=""
useremail=""

usage() {
  cat <<'EOF'
用法：
  ./commit_push.ps1 [选项]
选项：
  -m, --message    提交信息（默认：auto commit）
  -b, --branch     分支名称（默认：main）
  -u, --user       Git 配置 user.name（仅在未设置时使用）
  -e, --email      Git 配置 user.email（仅在未设置时使用）
  -h, --help       显示本帮助
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -m|--message)
        message="$2"; shift 2;;
      -b|--branch)
        branch="$2"; shift 2;;
      -u|--user)
        username="$2"; shift 2;;
      -e|--email)
        useremail="$2"; shift 2;;
      -h|--help)
        usage; exit 0;;
      *)
        echo "未知参数: $1" >&2
        usage
        exit 1;;
    esac
  done
}

ensure_git_repo() {
  if [[ ! -d .git ]]; then
    git init >/dev/null
    echo "已初始化 Git 仓库"
  fi
}

ensure_git_identity() {
  local name email
  name=$(git config user.name 2>/dev/null || true)
  email=$(git config user.email 2>/dev/null || true)

  if [[ -z "$name" ]]; then
    if [[ -z "$username" ]]; then
      echo "Git user.name 未配置，请通过 -u/--user 指定" >&2
      exit 1
    fi
    git config user.name "$username"
    echo "已设置 user.name=$username"
  fi

  if [[ -z "$email" ]]; then
    if [[ -z "$useremail" ]]; then
      echo "Git user.email 未配置，请通过 -e/--email 指定" >&2
      exit 1
    fi
    git config user.email "$useremail"
    echo "已设置 user.email=$useremail"
  fi
}

clean_idea() {
  if [[ -d .idea ]]; then
    touch .gitignore
    if ! grep -Fxq ".idea/" .gitignore; then
      printf "\n.idea/\n" >> .gitignore
      echo "已在 .gitignore 中添加 .idea/"
    fi
    git rm -r --cached .idea >/dev/null 2>&1 || true
    echo "已从暂存区移除 .idea/"
  fi
}

ensure_branch() {
  local current has_head
  if git rev-parse --verify HEAD >/dev/null 2>&1; then
    current=$(git rev-parse --abbrev-ref HEAD)
    has_head=1
  else
    current=""
    has_head=0
  fi

  if [[ "$has_head" -eq 0 ]]; then
    git symbolic-ref HEAD "refs/heads/$branch" >/dev/null 2>&1 || true
    echo "已设置默认分支为 $branch"
    return
  fi

  if [[ "$current" != "$branch" ]]; then
    git branch -M "$branch"
    echo "已切换/重命名当前分支 -> $branch"
  fi
}

commit_and_push() {
  git add -A
  if git diff --cached --quiet; then
    echo "没有需要提交的更改"
  else
    git commit -m "$message"
    echo "已创建提交: $message"
  fi

  if ! git remote get-url origin >/dev/null 2>&1; then
    echo "未检测到 origin 远程仓库，请先执行: git remote add origin <url>"
    return
  fi

  git push -u origin "$branch"
}

main() {
  parse_args "$@"
  ensure_git_repo
  ensure_git_identity
  clean_idea
  ensure_branch
  commit_and_push
  echo "Push 完成"
}

main "$@"
