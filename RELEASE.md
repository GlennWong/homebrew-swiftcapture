# 自动化发布设置指南

## 🚀 一键发布流程

现在你只需要在 GitHub 上创建一个 Release，剩下的全部自动完成！

### 设置步骤

1. **创建 Personal Access Token**

   - 访问 GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)
   - 点击 "Generate new token (classic)"
   - 选择 scopes: `repo` (完整仓库访问权限)
   - 复制生成的 token

2. **在主项目中添加 Secret**
   - 访问 https://github.com/GlennWong/SwiftCapture/settings/secrets/actions
   - 点击 "New repository secret"
   - Name: `HOMEBREW_TAP_TOKEN`
   - Value: 粘贴上面创建的 token
   - 点击 "Add secret"

### 发布流程

1. **创建 Release**

   - 访问 https://github.com/GlennWong/SwiftCapture/releases/new
   - Tag version: `v2.1.2` (或任何新版本)
   - Release title: `SwiftCapture v2.1.2`
   - Release notes: 描述更新内容
   - 点击 "Publish release"

2. **自动化完成**

   - ✅ 自动更新源代码版本号
   - ✅ 自动计算 SHA256 哈希
   - ✅ 自动更新 Homebrew Formula
   - ✅ 自动推送到 homebrew-swiftcapture 仓库

3. **验证安装**
   ```bash
   gh release create v2.2.5 --title "v2.2.5" --notes "fix warnings and remove the displayID from output"
   brew uninstall swiftcapture
   brew untap GlennWong/swiftcapture
   brew tap GlennWong/swiftcapture
   brew install swiftcapture
   scap --version
   scap
   ```

### GitHub Actions 工作流

已创建 `.github/workflows/release.yml` 文件，当你发布 Release 时会自动触发。

### 仓库结构

- **主项目**: `GlennWong/SwiftCapture` - 包含源代码和 GitHub Actions
- **Homebrew Tap**: `GlennWong/homebrew-swiftcapture` - 独立仓库，包含 Formula

### 需要在 homebrew-swiftcapture 仓库中修改

在 `homebrew-swiftcapture` 仓库的 README.md 中：

1. **全局替换** `homebrew-tap` 为 `homebrew-swiftcapture`
2. **删除复杂的手动流程**，只保留自动化发布说明：

````markdown
## Release Process (For Maintainers)

### 🚀 自动化发布流程

只需要在 GitHub 上创建一个 Release，剩下的全部自动完成！

1. **在 GitHub 上创建 Release**

   - 访问 https://github.com/GlennWong/SwiftCapture/releases/new
   - 填写 Tag version (例如: `v2.1.2`)
   - 填写 Release title 和 Release notes
   - 点击 "Publish release"

2. **自动化流程会完成以下操作**

   - ✅ 自动更新源代码中的版本号
   - ✅ 自动计算新版本的 SHA256 哈希
   - ✅ 自动更新 Homebrew Formula
   - ✅ 自动提交并推送到 homebrew-swiftcapture 仓库

3. **验证发布**
   ```bash
   brew untap GlennWong/swiftcapture
   brew tap GlennWong/swiftcapture
   brew install swiftcapture
   scap --version  # 应该显示新版本
   ```
````

**就这么简单！** 🎉

```

## 优势

- ✅ **免费**: 使用 GitHub Actions，完全免费
- ✅ **简单**: 只需创建 GitHub Release
- ✅ **最佳实践**: 遵循 GitHub 和 Homebrew 标准
- ✅ **自动化**: 无需手动操作任何步骤
- ✅ **可靠**: 自动处理版本号和哈希计算

现在你只需要：
1. 设置 `HOMEBREW_TAP_TOKEN` secret
2. 创建 GitHub Release
3. 等待自动化完成！
```

## 问题说明

之前遇到的版本不匹配问题是因为：

1. 在 GitHub 创建 Release 时，tag 指向的代码中版本号还是旧的
2. GitHub Actions 在 Release 发布后才更新版本号，但 tag 已经创建

## 解决方案

现在提供两种发布方式：

### 方式一：自动化预发布（推荐）

使用 GitHub Actions 的 `prepare-release.yml` 工作流程：

1. 在 GitHub 仓库页面，点击 "Actions" 标签
2. 选择 "Prepare Release" 工作流程
3. 点击 "Run workflow"
4. 输入新版本号（如 `2.1.6`）
5. 点击 "Run workflow" 按钮

这个工作流程会：

- 自动更新所有源文件中的版本号
- 创建正确的 git tag
- 自动创建 GitHub Release
- 确保 tag 指向包含正确版本号的代码

### 方式二：手动创建 Release（已修复）

如果你仍然想手动创建 Release：

1. 现有的 `release.yml` 工作流程已经修复
2. 它会检测版本不匹配并自动修复
3. 会重新创建正确的 tag

## 验证步骤

发布后验证版本是否正确：

```bash
# 检查 tag 指向的版本号
git show v2.1.6:Sources/SwiftCapture/CLI/SwiftCaptureCommand.swift | grep "version:"

# 应该显示：
# version: "2.1.6",
```

## Homebrew 更新

两种方式都会自动：

1. 计算新的 SHA256
2. 更新 Homebrew formula
3. 推送到 homebrew-swiftcapture 仓库

## 建议

- **推荐使用方式一**：更可靠，避免时序问题
- 方式二作为备用方案，已经加入了自动修复机制
- 每次发布后都要验证版本号是否正确
