#!/bin/bash
# validate_dict.sh - Rime 词库质量自动化校验脚本

echo "--- Rime 词库质量校验 ---"
error_found=0

# 1. 校验元数据一致性
echo "[1] 校验元数据 name 与文件名..."
for f in *.dict.yaml; do
  [ "$f" == "luna_pinyin.extended.dict.yaml" ] && continue
  base=$(basename "$f" .dict.yaml)
  name=$(grep "^name:" "$f" | head -n 1 | awk '{print $2}' | tr -d '"' | tr -d "'")
  if [ "$base" != "$name" ]; then
    echo "  [!] 错误: 文件 $f 内部 name 为 '$name'，应为 '$base'"
    error_found=1
  fi
done

# 2. 校验 import_tables 引用完整性
echo "[2] 校验主词库引用完整性..."
if [ -f "luna_pinyin.extended.dict.yaml" ]; then
  imports=$(sed -n '/import_tables:/,/^.../p' luna_pinyin.extended.dict.yaml | grep "^  - " | awk '{print $2}')
  for imp in $imports; do
    if [ ! -f "$imp.dict.yaml" ]; then
      echo "  [!] 错误: 主词库引用了不存在的文件: $imp.dict.yaml"
      error_found=1
    fi
  done
fi

if [ $error_found -eq 0 ]; then
  echo "  [OK] 词库元数据与引用关系校验通过。"
else
  echo "  [FAIL] 请根据提示修复错误后再发布。"
  exit 1
fi
