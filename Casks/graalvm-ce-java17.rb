cask "graalvm-ce-java17" do
  if Hardware::CPU.intel?
    version "22.0.0.2"
    sha256 "d54af9d1f4d0d351827395a714ed84d2489b023b74a9c13a431cc9d31d1e8f9a"
    arch = "amd64"
  else
    version "22.1.0-dev"
    sha256 "de5f98ddf59f2d7f6a8f32fc51eefdeea3ef75d449d9de522ea629cbc5c55acd"
    arch = "aarch64"
  end

  jvms_dir = "/Library/Java/JavaVirtualMachines".freeze
  target_dir = "#{jvms_dir}/#{cask}-#{version}".freeze

  # github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  if Hardware::CPU.intel?
    url "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-#{version}/#{cask}-darwin-#{arch}-#{version}.tar.gz"
  else # The following branch can be folded as soon there is a GraalVM release with M1 support
    url "https://github.com/graalvm/graalvm-ce-dev-builds/releases/download/22.1.0-dev-20220321_2332/#{cask}-darwin-#{arch}-dev.tar.gz"
  end
  appcast "https://github.com/oracle/graal/releases.atom"
  name "GraalVM Community Edition (Java 17)"
  homepage "https://www.graalvm.org/"

  artifact "#{cask}-#{version}", target: target_dir

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
    !! GraalVM distributions based on OpenJDK 17 are considered experimental#{" "}
    with several known limitations. Please see
      https://www.graalvm.org/release-notes/known-issues/

    Installing GraalVM CE (Java 17) in #{jvms_dir} requires root permissions.
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
