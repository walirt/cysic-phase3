#!/bin/bash
echo "-------mock docker start-------"
echo "Command: $0 $@"
if [[ "$1" == "run" ]]; then
  # 使用 nohup 在后台运行 moongate-server，并将输出重定向到日志文件
  nohup /root/moongate-server > /root/moongate-server.log 2>&1 &
  pid=$!
  echo "moongate-server started in background with PID: $pid"
  # 将 PID 保存到文件中，方便后续停止操作
  echo $pid > /root/moongate-server.pid
elif [[ "$1" == "rm" ]]; then
  # 首先尝试从 PID 文件中获取进程 ID
  if [[ -f /root/moongate-server.pid ]]; then
    pid=$(cat /root/moongate-server.pid)
    if [[ -n "$pid" && -e /proc/$pid ]]; then
      kill -TERM "$pid"
      echo "moongate-server stopping..."
      # 等待进程优雅退出，最多等待5秒
      timeout=5
      while [[ -e /proc/$pid ]] && [[ $timeout -gt 0 ]]; do
        sleep 1
        ((timeout--))
      done
      # 如果进程仍未退出，则强制终止
      if [[ -e /proc/$pid ]]; then
        kill -9 "$pid"
        echo "moongate-server forcibly stopped after timeout"
      else
        echo "moongate-server stopped gracefully"
      fi
      # 清理 PID 文件
      rm -f /root/moongate-server.pid
    else
      echo "moongate-server is not running (invalid PID or process not found)"
      rm -f /root/moongate-server.pid
    fi
  else
    # 如果 PID 文件不存在，尝试通过进程名查找
    pid=$(ps aux | grep '/root/moongate-server' | grep -v 'grep' | awk '{print $2}')
    if [[ -n "$pid" ]]; then
      kill -TERM "$pid"
      echo "moongate-server stopping..."
      # 等待进程优雅退出，最多等待5秒
      timeout=5
      while [[ -e /proc/$pid ]] && [[ $timeout -gt 0 ]]; do
        sleep 1
        ((timeout--))
      done
      # 如果进程仍未退出，则强制终止
      if [[ -e /proc/$pid ]]; then
        kill -9 "$pid"
        echo "moongate-server forcibly stopped after timeout"
      else
        echo "moongate-server stopped gracefully"
      fi
    else
      echo "moongate-server is not running"
    fi
  fi
else
  echo "Do nothing"
fi
echo "-------mock docker end---------"