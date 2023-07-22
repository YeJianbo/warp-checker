#!/bin/bash

# 获取当前时间戳
get_timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

# 检测Warp状态
check_warp_status() {
  if curl -6 -s https://ip.sb >/dev/null; then
    echo "$(get_timestamp) - Warp is operational. IPv6 address is available."
    return 0
  else
    echo "$(get_timestamp) - Warp is not operational. Restarting..."
    restart_warp
    return 1
  fi
}

# 重启Warp
restart_warp() {
  echo "$(get_timestamp) - Restarting Warp..."
  warp-go o
  sleep 10 # 等待Warp启动
  warp-go o
  sleep 10
}

# 检查Warp状态
check_warp_status
