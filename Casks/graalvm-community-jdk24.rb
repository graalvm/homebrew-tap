cask "graalvm-community-jdk24" do
  arch arm: "aarch64", intel: "x64"

  version "24.0.1"
  sha256 arm:   "0e18661fb350d76c7d4905484b72b90ecda38a0910b3a9a2856573086678cead",
         intel: "452615d870ac9a6bf0fac09ff859d6c1a78e14d6f2a1937d610e7c6e470359e2"

  installation_dir = "graalvm-community-openjdk-#{version}+9.1".freeze
  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/graalvm-community-openjdk-#{version.split(".").first}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-#{version}/graalvm-community-jdk-#{version}_macos-#{arch}_bin.tar.gz"
  name "GraalVM Community Edition for JDK 24"
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
    Installing GraalVM CE for JDK 24 in #{jvms_dir} requires root permission.
    You may be asked to enter your password to proceed.

    To use GraalVM, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
