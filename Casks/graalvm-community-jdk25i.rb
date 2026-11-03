cask "graalvm-community-jdk25i" do
  arch arm: "aarch64"

  version "25.5.5.0.3"
  sha256 arm: "54369d4a5931a5a2101c7c52444a4e7e6647a3a4e041335053cda6fd22295e0c"

  installation_dir = "graalvm-community-#{version}+1.1".freeze
  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/graalvm-community-openjdk-#{version.split(".").first}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/graal-#{version}/graalvm-community-jdk-25i5-25.0.5.0.3_macos-#{arch}_bin.tar.gz"
  name "GraalVM Community Edition 25i"
  homepage "https://www.graalvm.org/"

  artifact installation_dir, target: target_dir

  caveats <<~EOS
    Installing GraalVM CE 25i in #{jvms_dir} requires root permission.
    You may be asked to enter your password to proceed.

    To use GraalVM, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
