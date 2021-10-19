cask 'graalvm-ce-java17' do
  version '21.3.0'
  sha256 '60236506920cc84a07ea7602f4514d05da2c07c7176e0634652f8a9c5ad677aa'

  JVMS_DIR = '/Library/Java/JavaVirtualMachines'.freeze
  TARGET_DIR = "#{JVMS_DIR}/#{cask}-#{version}".freeze

# github.com/graalvm/graalvm-ce-builds was verified as official when first introduced to the cask
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-#{version}/#{cask}-darwin-amd64-#{version}.tar.gz"
  appcast 'https://github.com/oracle/graal/releases.atom'
  name 'GraalVM Community Edition (Java 17)'
  homepage 'https://www.graalvm.org/'

  artifact "#{cask}-#{version}", target: TARGET_DIR

  postflight do
    # Correct symlink 
    macos_dir = "#{TARGET_DIR}/Contents/MacOS"
    libjli_filename = 'libjli.dylib'
    libjli_path = "#{TARGET_DIR}/Contents/Home/lib/#{libjli_filename}"
    libjli_symlink_path = "#{macos_dir}/#{libjli_filename}"
    system_command '/bin/mkdir', args: ['-p', macos_dir], sudo: true
    system_command '/bin/ln', args: ['-s', '-f', libjli_path, libjli_symlink_path], sudo: true
  end

  caveats <<~EOS
    !! GraalVM distributions based on OpenJDK 17 are considered experimental 
    with several known limitations. Please see
      https://www.graalvm.org/release-notes/known-issues/

    Installing GraalVM CE (Java 17) in #{JVMS_DIR} requires root permissions.
    You may be asked to enter your password to proceed.

    On macOS Catalina, you may get a warning that "the developer cannot be
    verified". This check can be disabled in the "Security & Privacy"
    preferences pane or by running the following command:
      xattr -r -d com.apple.quarantine #{TARGET_DIR}

    To use GraalVM CE, you may want to change your `JAVA_HOME`:
      export JAVA_HOME=#{TARGET_DIR}/Contents/Home

    or you may want to add its `bin` directory to your `PATH`:
      export PATH=#{TARGET_DIR}/Contents/Home/bin:"$PATH"

    GraalVM CE is licensed under the GPL 2 with Classpath exception:
      https://github.com/oracle/graal/blob/master/LICENSE

  EOS
end
