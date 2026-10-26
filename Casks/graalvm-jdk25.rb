cask "graalvm-jdk25" do
  arch arm: "aarch64"

  version "25.0.5.0.3"
  sha256 arm: "ec4faf8fcfc45b7b7bbdc7b72a0df338424951389f149f0f2c281fde8d47c08d"

  installation_dir = "graalvm-jdk-#{version}+1.1".freeze
  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/graalvm-jdk-#{version.split(".").first}".freeze

  # download.oracle.com was verified as official when first introduced to the cask
  url "https://gds.oracle.com/download/graal/25/archive/graalvm-jdk-#{version}_macos-#{arch}_bin.tar.gz"
  name "Oracle GraalVM 25"
  homepage "https://www.graalvm.org/"

  artifact installation_dir, target: target_dir

  caveats <<~EOS
    Installing Oracle GraalVM 25 in #{jvms_dir} requires root permission.
    You may be asked to enter your password to proceed.

    To use GraalVM, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    Oracle GraalVM is licensed under the GraalVM Free Terms and Conditions:
      https://www.oracle.com/downloads/licenses/graal-free-license.html

  EOS
end
