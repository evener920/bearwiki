#!/bin/bash

# 清空并写入首页
echo "* [首页](/)" > _sidebar.md

# 遍历根目录下所有 md 文件
for file in *.md; do
  # 跳过 README.md
  if [[ "$file" == "README.md" ]]; then
    continue
  fi

  # 读取第一行作为标题
  title=$(head -n 1 "$file" | sed 's/^# //')

  # 如果标题为空，用文件名
  if [[ -z "$title" ]]; then
    title="${file%.md}"
  fi

  echo "* [$title]($file)" >> _sidebar.md
done
