cask "graalvm-ce" do
  version "19.1.1"
  sha256 "85711322866ddacda88d3a592c76520188b3d7c40b6c39cd9943856e72eb6c72"

  JVMS_DIR = "/Library/Java/JavaVirtualMachines"
  TARGET_DIR = "#{JVMS_DIR}/graalvm-ce-#{version}"

  name "GraalVM Community Edition"
  url "https://github.com/oracle/graal/releases/download/vm-#{version}/graalvm-ce-darwin-amd64-#{version}.tar.gz"
  homepage 'https://www.graalvm.org'
  appcast 'https://github.com/oracle/graal/releases.atom'

  artifact "graalvm-ce-#{version}", target: TARGET_DIR

  caveats <<~EOS
    Installing GraalVM CE in #{JVMS_DIR} requires root permissions.
    You may be asked to enter your password to proceed.

    To use GraalVM CE, you may want to change your `JAVA_HOME`:
      export JAVA_HOME=#{TARGET_DIR}/Contents/Home

    or you may want to add its `bin` directory to your `PATH`:
      export PATH=#{TARGET_DIR}/Contents/Home/bin:"$PATH"

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
