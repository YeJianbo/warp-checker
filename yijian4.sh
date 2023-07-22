#!/bin/bash

LOG_FILE="/var/log/warp_checker.log"

# 下载脚本并保存到本地
download_script() {
  url="https://sh.151376.xyz/sh/warp-checker4.sh"
  curl -o warp-checkers.sh "$url"
}

# 添加cron作业器
add_cron_job() {
  # 检查脚本是否已经存在于当前用户的Home目录下
  local script_path="$HOME/warp-checkers.sh"
  if [ ! -f "$script_path" ]; then
    echo "未找到脚本，请先下载脚本。"
    exit 1
  fi

  # 添加cron作业器，并将输出重定向到日志文件
  local cron_job="*/1 * * * * bash $script_path >> $LOG_FILE 2>&1"
  (crontab -l ; echo "$cron_job") | crontab -
  echo "已成功添加cron作业器，日志输出到 $LOG_FILE"
}

# 主函数
main() {
  download_script
  add_cron_job
}

# 执行主函数
main
