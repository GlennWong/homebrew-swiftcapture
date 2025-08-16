class Swiftcapture < Formula
  desc "Professional screen recording tool for macOS with comprehensive CLI interface"
  homepage "https://github.com/GlennWong/SwiftCapture"
  url "https://github.com/GlennWong/SwiftCapture/releases/download/v2.1.14/scap-v2.1.14-macos.tar.gz"
  sha256 "7d268737bbd829861a742511aee82ab5348eabefcd0b802cac110add95710481"
  license "MIT"
  version "2.1.14"

  # System requirements
  depends_on :macos => :monterey # macOS 12.3+
  depends_on arch: [:arm64, :x86_64]

  def install
    # Install the binary
    bin.install "scap"
    
    # Install documentation if present
    if File.exist?("README.txt")
      doc.install "README.txt"
    end
  end

  def caveats
    <<~EOS
      SwiftCapture requires Screen Recording permission to function properly.
      
      To grant permission:
      1. Open System Preferences > Security & Privacy > Privacy
      2. Select 'Screen Recording' from the left sidebar  
      3. Click the lock to make changes (enter your password)
      4. Add your terminal application (Terminal.app, iTerm2, etc.)
      5. Enable the checkbox for your terminal
      6. Restart your terminal application
      
      For microphone recording, also grant Microphone permission in the same way.
      
      Usage examples:
        scap --help                    # Show help
        scap --screen-list            # List available screens
        scap --duration 5000          # Record for 5 seconds
        scap --output recording.mov   # Specify output file
    EOS
  end

  test do
    # Test that the binary exists and is executable
    assert_predicate bin/"scap", :exist?
    assert_predicate bin/"scap", :executable?
    
    # Test version command
    system bin/"scap", "--version"
    
    # Test help command  
    system bin/"scap", "--help"
    
    # Test screen list (may fail without permissions, but shouldn't crash)
    system bin/"scap", "--screen-list" rescue nil
    
    # Test app list
    system bin/"scap", "--app-list" rescue nil
    
    # Test preset list
    system bin/"scap", "--list-presets"
  end
end
