# Rime 增强词库集合 (Extended Dictionary)

这是一个高度优化的 Rime (中州韵) 输入法扩展词库集合，包含约 180 万条精品词条，采用平铺结构，方便用户直接集成。

## 本仓库特点
- **平铺结构**：所有 `.dict.yaml` 文件均在根目录下，完美支持 Rime 的 `import_tables` 机制，无需手动移动子目录。
- **模块化管理**：通过 `luna_pinyin.extended.dict.yaml` 统一导入，您可以根据需要自由修改该文件中的 `import_tables` 列表来加载或禁用分类词库。
- **全局去重**：已完成全局跨文件去重，消除了 60 万冗余数据，显著提升 Rime 部署速度并减少内存占用。
- **极简标音**：符合 Rime 官方规范，移除纯汉字词条的冗余拼音，充分利用 Rime 自身的“自动拼词”引擎。
- **标准化元数据**：修复了所有子词库内部的 `name:` 标签，消除了常见的配置识别冲突。

## 核心文件
- `luna_pinyin.extended.dict.yaml`：词库主入口，引用了本仓库所有的子词库。
- `luna_pinyin.custom.yaml`：配置补丁示例。
- `validate_dict.sh`：词库质量自动化校验工具。

## 安装与使用

### 1. 复制词库
将根目录下所有的 `.dict.yaml` 文件复制到 Rime 的**用户文件夹**（User Data）中。
> 如果您不想安装所有词库，可以只复制您需要的子词库，并同步修改 `luna_pinyin.extended.dict.yaml` 中的引用列表。

### 2. 启用扩展词库
将 `luna_pinyin.custom.yaml` 复制到用户文件夹，或者根据该文件的内容，将以下补丁合并到您原有的补丁文件中：

```yaml
patch:
  # 将默认词库替换为本项目的主入口词库
  "translator/dictionary": luna_pinyin.extended
```

### 3. 重新部署
在 Rime 菜单中选择“**重新部署**” (Deploy)。

## 开发者维护
- **校验词库**：运行 `./validate_dict.sh` 以确保引用关系和元数据正确。
- **参考文档**：
  - [Rime 定製指南](https://github.com/rime/home/wiki/CustomizationGuide)
  - [Rime With Schemata](https://github.com/rime/home/wiki/RimeWithSchemata)
