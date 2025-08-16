# Homebrew Tap for SwiftCapture

This is the official Homebrew tap for SwiftCapture, a professional screen recording tool for macOS.

## Installation

```bash
# Add the tap
brew tap GlennWong/swiftcapture

# Install SwiftCapture
brew install swiftcapture
```

## Alternative Installation

```bash
# Install directly from this tap
brew install GlennWong/swiftcapture
```

## Usage

After installation, you can use SwiftCapture from anywhere:

```bash
# Show help
scap --help

# Quick 10-second recording
scap

# Record for 30 seconds with microphone
scap --duration 30000 --enable-microphone

# List available screens
scap --screen-list

# List running applications
scap --app-list
```

## System Requirements

- macOS 12.3 or later (required for ScreenCaptureKit)
- Screen Recording permission in System Preferences
- Microphone permission (optional, for audio recording)

## Permissions Setup

SwiftCapture requires Screen Recording permission to function:

1. Open **System Preferences** > **Security & Privacy** > **Privacy**
2. Select **Screen Recording** from the left sidebar
3. Click the lock icon and enter your password
4. Add your terminal application (Terminal, iTerm2, etc.)
5. Enable the checkbox next to your terminal
6. Restart your terminal application

## Support

- [GitHub Repository](https://github.com/GlennWong/SwiftCapture)
- [Issues](https://github.com/GlennWong/SwiftCapture/issues)
- [Documentation](https://github.com/GlennWong/SwiftCapture#readme)

## Release Process (For Maintainers)

### 标准发布流程

1. **更新主项目版本号**

   ```bash
   # 在主项目中更新以下文件的版本号：
   # - release-config.json
   # - Sources/SwiftCapture/CLI/SwiftCaptureCommand.swift
   # - scripts/build-release.sh
   ```

2. **构建并测试**

   ```bash
   swift build --disable-sandbox -c release
   ./.build/release/SwiftCapture --version  # 验证版本号
   ```

3. **提交并创建标签**

   ```bash
   git add .
   git commit -m "Bump version to vX.X.X"
   git push origin main
   git tag vX.X.X
   git push origin vX.X.X
   ```

4. **获取新版本的 SHA256**

   ```bash
   # 等待 GitHub 处理新标签后
   curl -sL https://github.com/GlennWong/SwiftCapture/archive/vX.X.X.tar.gz | shasum -a 256
   ```

5. **更新 Homebrew Formula**

   ```bash
   # 在 homebrew-tap 仓库中更新 Formula/swiftcapture.rb：
   # - url: 更新到新版本的 tar.gz 链接
   # - sha256: 更新为步骤4获取的哈希值
   ```

6. **提交并推送 Formula 更新**

   ```bash
   cd homebrew-tap
   git add Formula/swiftcapture.rb
   git commit -m "Release vX.X.X: Update formula"
   git push origin main
   ```

7. **测试安装**
   ```bash
   # 清除缓存并测试安装
   brew untap GlennWong/swiftcapture
   brew cleanup --prune=all
   brew tap GlennWong/swiftcapture
   brew install swiftcapture
   scap --version  # 验证版本
   ```

### 快速发布脚本

可以使用项目中的 `scripts/release.sh` 脚本自动化大部分流程：

```bash
./scripts/release.sh v2.1.1
```

### 使用 brew bump-formula-pr (推荐)

对于更快的发布，可以使用 Homebrew 的官方工具：

```bash
# 在 homebrew-tap 目录中
brew bump-formula-pr --url=https://github.com/GlennWong/SwiftCapture/archive/vX.X.X.tar.gz swiftcapture
```

### 仓库结构说明

- **主项目仓库**: `GlennWong/SwiftCapture` - 包含源代码
- **Homebrew Tap 仓库**: `GlennWong/homebrew-swiftcapture` - 包含 Formula

按照 Homebrew 最佳实践，tap 应该是独立的仓库，不应该作为子目录放在主项目中。

## 要求检查清单

### ✅ 已满足的要求：

- [x] 开源项目（MIT 许可证）
- [x] 稳定的版本标签（v2.0.0）
- [x] 可构建的源代码
- [x] 适当的文档

### 🔄 需要完善的要求：

#### 1. 项目成熟度

- [ ] 至少 30 个 GitHub stars
- [ ] 活跃的维护（定期提交）
- [ ] 用户反馈和 issue 处理

#### 2. 包质量

- [ ] 全面的测试覆盖
- [ ] CI/CD 流水线
- [ ] 详细的文档

#### 3. Homebrew 特定要求

- [ ] Formula 必须构建成功
- [ ] 通过所有 Homebrew 测试
- [ ] 遵循 Homebrew 命名约定

## 提交步骤

### 当前推荐：创建自己的 Tap

1. **创建 GitHub 仓库**：

   ```bash
   # 仓库名必须是: homebrew-<name>
   # 例如: homebrew-swiftcapture
   ```

2. **用户安装方式**：
   ```bash
   brew tap GlennWong/swiftcapture
   brew install swiftcapture
   ```

### 未来：提交到 Homebrew Core

当项目更成熟时：

1. **Fork Homebrew Core**：

   ```bash
   git clone https://github.com/Homebrew/homebrew-core.git
   cd homebrew-core
   ```

2. **添加 Formula**：

   ```bash
   cp path/to/swiftcapture.rb Formula/
   ```

3. **测试 Formula**：

   ```bash
   brew install --build-from-source Formula/swiftcapture.rb
   brew test swiftcapture
   brew audit --strict swiftcapture
   ```

4. **提交 PR**：
   - 创建分支
   - 提交 Formula
   - 创建 Pull Request 到 homebrew-core

## 当前行动计划

1. ✅ 完善项目文档
2. ✅ 添加更多测试
3. ✅ 设置 GitHub Actions CI
4. 🔄 推广项目获得更多用户
5. 🔄 收集用户反馈
6. 🔄 当达到要求时提交到 Homebrew Core

## License

MIT License - see the main repository for details.
