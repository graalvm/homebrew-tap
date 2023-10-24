cask "graalvm-community-jdk21" do
  arch arm: "aarch64", intel: "x64"

  version "21.0.1"
  sha256 arm:   "50c42bc748e528a9702eaa66e894cf6d125a19b91f1df1c3a484bdcf02feff44",
         intel: "dafe240fb9e420cfef84ad8871b85cffc64988fd5520c4601e15b04687317a6a"

  installation_dir = "graalvm-community-openjdk-#{version}+12.1".freeze
  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/graalvm-community-openjdk-#{version.split(".").first}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-#{version}.0.0/graalvm-community-jdk-#{version}.0.0_macos-#{arch}_bin.tar.gz"
  name "GraalVM Community Edition for JDK 21"
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
    Installing GraalVM CE for JDK 21 in #{jvms_dir} requires root permission.
    You may be asked to enter your password to proceed.

    On macOS Catalina or later, you may get a warning when you use the GraalVM
    installation for the first time. This warning can be disabled by running the
    following command:
      xattr -r -d com.apple.quarantine "#{target_dir}"

    To use GraalVM, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
