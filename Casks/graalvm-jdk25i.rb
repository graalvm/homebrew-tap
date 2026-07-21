cask "graalvm-jdk25i1" do
  arch arm: "aarch64"

  version "25.1.3"
  sha256 arm: "3b694d60985503bf561cd2444fb1a9b697b08fb700d0bb27d12c49adc5d914bb"

  installation_dir = "graalvm-#{version}+9.1".freeze
  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/graalvm-jdk-#{version.split(".").first}".freeze

  # download.oracle.com was verified as official when first introduced to the cask
  url "https://download.oracle.com/graalvm/25i1/archive/graalvm-jdk-25i1-25.0.3_macos-#{arch}_bin.tar.gz"
  name "Oracle GraalVM 25i"
  homepage "https://www.graalvm.org/"

  artifact installation_dir, target: target_dir

  postflight do
    # Correct symlink
    macos_dir = "#{target_dir}/Contents/MacOS"
    libjli_filename = "libjli.dylib"
    libjli_path = "#{target_dir}/Contents/Home/lib/#{libjli_filename}"
    libjli_symlink_path = "#{macos_dir}/#{libjli_filename}"
    system_command "/bin/mkdir", args: ["-p", macos_dir], sudo: true
    system_command "/bin/ln", args: ["-s", "-f", libjli_path, libjli_symlink_path], sudo: true
  end

  caveats <<~EOS
    Installing Oracle GraalVM 25i1 in #{jvms_dir} requires root permission.
    You may be asked to enter your password to proceed.

    To use GraalVM, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    Oracle GraalVM is licensed under the GraalVM Free Terms and Conditions:
      https://www.oracle.com/downloads/licenses/graal-free-license.html

  EOS
end