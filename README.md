# Homebrew Tap for GraalVM

Run one of the following commands to install GraalVM Community Edition with [Homebrew]:

```bash
brew cask install graalvm/tap/graalvm-ce-java8

brew cask install graalvm/tap/graalvm-ce-java11
```

Once installed, these casks can be upgraded (if an update is available) with the following commands:

```bash
brew cask upgrade graalvm/tap/graalvm-ce-java8

brew cask upgrade graalvm/tap/graalvm-ce-java11
```

On macOS Catalina, you may get a warning that "the developer cannot be
verified". This check can be disabled in the "Security & Privacy"
preferences pane or by running the following command:

 ` xattr -r -d com.apple.quarantine /Library/Java/JavaVirtualMachines/graalvm-ce-java8-20.0.0 `

To use GraalVM CE, you may want to change your `JAVA_HOME`: 

`export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java8-20.0.0/Contents/Home`

or you may want to add its `bin` directory to your `PATH`:

  `export PATH=/Library/Java/JavaVirtualMachines/graalvm-ce-java8-20.0.0/Contents/Home/bin:"$PATH"`

[Homebrew]: https://brew.sh/
