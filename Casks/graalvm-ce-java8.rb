cask "graalvm-ce-java8" do
  version "21.0.0.2"
  sha256 "25a653a44b3ad63479d7ae35d921c8d39282ff1849243f1afc0ffddd443e9079"

  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/#{cask}-#{version}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-#{version}/#{cask}-darwin-amd64-#{version}.tar.gz"
  appcast "https://github.com/oracle/graal/releases.atom"
  name "GraalVM Community Edition (Java 8)"
  homepage "https://www.graalvm.org/"

  artifact "#{cask}-#{version}", target: target_dir

  caveats <<~EOS
    !! GraalVM Community Edition releases for MacOS based on JDK 8 are#{" "}
    no longer being built.

    Installing GraalVM CE (Java 8) in #{jvms_dir} requires root permissions.
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
