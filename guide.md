# 提交SwiftCapture到Homebrew Core指南

## 要求检查清单

### ✅ 已满足的要求：
- [x] 开源项目（MIT许可证）
- [x] 稳定的版本标签（v2.0.0）
- [x] 可构建的源代码
- [x] 适当的文档

### 🔄 需要完善的要求：

#### 1. 项目成熟度
- [ ] 至少30个GitHub stars
- [ ] 活跃的维护（定期提交）
- [ ] 用户反馈和issue处理

#### 2. 包质量
- [ ] 全面的测试覆盖
- [ ] CI/CD流水线
- [ ] 详细的文档

#### 3. Homebrew特定要求
- [ ] Formula必须构建成功
- [ ] 通过所有Homebrew测试
- [ ] 遵循Homebrew命名约定

## 提交步骤

### 当前推荐：创建自己的Tap

1. **创建GitHub仓库**：
   ```bash
   # 仓库名必须是: homebrew-<name>
   # 例如: homebrew-swiftcapture
   ```

2. **用户安装方式**：
   ```bash
   brew tap GlennWong/swiftcapture
   brew install swiftcapture
   ```

### 未来：提交到Homebrew Core

当项目更成熟时：

1. **Fork Homebrew Core**：
   ```bash
   git clone https://github.com/Homebrew/homebrew-core.git
   cd homebrew-core
   ```

2. **添加Formula**：
   ```bash
   cp path/to/swiftcapture.rb Formula/
   ```

3. **测试Formula**：
   ```bash
   brew install --build-from-source Formula/swiftcapture.rb
   brew test swiftcapture
   brew audit --strict swiftcapture
   ```

4. **提交PR**：
   - 创建分支
   - 提交Formula
   - 创建Pull Request到homebrew-core

## 当前行动计划

1. ✅ 完善项目文档
2. ✅ 添加更多测试
3. ✅ 设置GitHub Actions CI
4. 🔄 推广项目获得更多用户
5. 🔄 收集用户反馈
6. 🔄 当达到要求时提交到Homebrew Core

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
   brew untap GlennWong/swiftcapture
   brew tap GlennWong/swiftcapture
   brew install swiftcapture
   scap --version
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
