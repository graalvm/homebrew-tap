cask "graalvm-jdk21" do
  arch arm: "aarch64", intel: "x64"

  version "21.0.1"
  sha256 arm:   "4b5ddffad649b3e64853ba230b6e8f7acd65322bb8f11852e0521ab1bb4d8b03",
         intel: "0647d57ec98d7aa19d2801b3ec58697d7eb44a408df511bd49d39f0150a08f87"

  installation_dir = "graalvm-jdk-#{version}+12.1".freeze
  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/#{installation_dir}".freeze

  # download.oracle.com was verified as official when first introduced to the cask
  url "https://download.oracle.com/graalvm/21/archive/graalvm-jdk-#{version}_macos-#{arch}_bin.tar.gz"
  name "Oracle GraalVM for JDK 21"
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
    Installing Oracle GraalVM for JDK 21 in #{jvms_dir} requires root permission.
    You may be asked to enter your password to proceed.

    On macOS Catalina or later, you may get a warning when you use the GraalVM
    installation for the first time. This warning can be disabled by running the
    following command:
      xattr -r -d com.apple.quarantine "#{target_dir}"

    To use GraalVM, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    Oracle GraalVM is licensed under the GraalVM Free Terms and Conditions:
      https://www.oracle.com/downloads/licenses/graal-free-license.html

  EOS
end
