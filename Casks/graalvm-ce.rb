cask 'graalvm-ce' do
  version '19.3.0'
  sha256 '5a7eaead66971e25bef2c21d94d0760b54bda13761908545be8c0323df17da4a'
  
  JVMS_DIR = '/Library/Java/JavaVirtualMachines'.freeze
  TARGET_DIR = "#{JVMS_DIR}/graalvm-ce-#{version}".freeze
  PATCH_DIR = "#{TARGET_DIR}/Contents/MacOS".freeze

  # github.com/oracle/graal was verified as official when first introduced to the cask
  # Starting with 19.3.0 precompiled builds are now at https://github.com/graalvm/graalvm-ce-builds
  url "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-#{version}/graalvm-ce-java11-darwin-amd64-#{version}.tar.gz"
  appcast 'https://github.com/oracle/graal/releases.atom'
  name 'GraalVM Community Edition'
  homepage 'https://www.graalvm.org/'

  artifact "graalvm-ce-java11-#{version}", target: TARGET_DIR

  postflight do
    system_command '/usr/bin/sh',
                   args: ['-c',"mkdir #{PATCH_DIR} && cd #{PATCH_DIR} && ln -s ../Home/lib/jli/libjli.dylib"],
                   sudo: true
  end

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
