cask 'graalvm-ce' do
  version '19.2.1'
  sha256 '988b943bf956f88079123c2d6225d188050c1f34b3ff47449be7c7ed241dc00f'

  JVMS_DIR = '/Library/Java/JavaVirtualMachines'.freeze
  TARGET_DIR = "#{JVMS_DIR}/graalvm-ce-#{version}".freeze

  # github.com/oracle/graal was verified as official when first introduced to the cask
  url "https://github.com/oracle/graal/releases/download/vm-#{version}/graalvm-ce-darwin-amd64-#{version}.tar.gz"
  appcast 'https://github.com/oracle/graal/releases.atom'
  name 'GraalVM Community Edition'
  homepage 'https://www.graalvm.org/'

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
