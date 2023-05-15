cask "graalvm-ce-lts-java8" do
  version "20.3.1"
  sha256 "160c357cd412197a4671363bce1d8925afd42a05d8a66bd167dca69afa090bb5"

  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/#{cask}-#{version}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-#{version}/graalvm-ce-java8-darwin-amd64-#{version}.tar.gz"
  appcast "https://github.com/oracle/graal/releases.atom"
  name "GraalVM Community Edition, LTS (Java 8)"
  homepage "https://www.graalvm.org/"

  artifact "graalvm-ce-java8-#{version}", target: target_dir

  caveats <<~EOS
    Installing GraalVM CE LTS (Java 8) in #{jvms_dir} requires root permissions.
    You may be asked to enter your password to proceed.

    On macOS Catalina or later, you may get a warning when you open the GraalVM
    installation for the first time. This warning can be disabled by running the
    following command:
      xattr -r -d com.apple.quarantine "#{target_dir}"

    To use GraalVM CE LTS, you may want to change your $JAVA_HOME:
      export JAVA_HOME="#{target_dir}/Contents/Home"

    or you may want to add its `bin` directory to your $PATH:
      export PATH="#{target_dir}/Contents/Home/bin:$PATH"

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
