cask "graalvm-ce-java11" do
  arch = Hardware::CPU.intel? ? "amd64" : "aarch64"
  version "22.1.0"

  if Hardware::CPU.intel?
    sha256 "c4c9df94ca47b83b582758b87d39042732ba0193fc63f1ab93f6818005a1fe6b"
  else
    sha256 "06bc19a0b1e93aa3df5e15c08e97f8cef624cb6070eeae40a69a51ec7fd41152"
  end

  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/#{cask}-#{version}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-#{version}/#{cask}-darwin-#{arch}-#{version}.tar.gz"
  appcast "https://github.com/oracle/graal/releases.atom"
  name "GraalVM Community Edition (Java 11)"
  homepage "https://www.graalvm.org/"

  artifact "#{cask}-#{version}", target: target_dir

  postflight do
    # Ensure GraalVM JDK 11 is listed by `/usr/libexec/java_home -V`.
    macos_dir = "#{target_dir}/Contents/MacOS"
    libjli_filename = "libjli.dylib"
    libjli_path = "#{target_dir}/Contents/Home/lib/jli/#{libjli_filename}"
    libjli_symlink_path = "#{macos_dir}/#{libjli_filename}"
    next if File.exist?(libjli_symlink_path)

    system_command "/bin/mkdir", args: ["-p", macos_dir], sudo: true
    system_command "/bin/ln", args: ["-s", libjli_path, libjli_symlink_path], sudo: true
  end

  caveats <<~EOS
    Installing GraalVM CE (Java 11) in #{jvms_dir} requires root permissions.
    You may be asked to enter your password to proceed.

    On macOS Catalina, you may get a warning that "the developer cannot be
    verified". This check can be disabled in the "Security & Privacy"
    preferences pane or by running the following command:
      xattr -r -d com.apple.quarantine "#{target_dir}"

    To use GraalVM CE, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
