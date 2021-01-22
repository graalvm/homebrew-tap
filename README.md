# Homebrew Tap for GraalVM

Run one of the following commands to install GraalVM Community Edition with [Homebrew]:

```bash
brew install --cask graalvm/tap/graalvm-ce-java8
brew install --cask graalvm/tap/graalvm-ce-lts-java8

brew install --cask graalvm/tap/graalvm-ce-java11
brew install --cask graalvm/tap/graalvm-ce-lts-java11
```

Once installed, these casks can be upgraded (if an update is available) with the following commands:

```bash
brew upgrade --cask graalvm/tap/graalvm-ce-java8
brew upgrade --cask graalvm/tap/graalvm-ce-lts-java8

brew upgrade --cask graalvm/tap/graalvm-ce-java11
brew upgrade --cask graalvm/tap/graalvm-ce-lts-java11
```

## How to Use

To use GraalVM CE, you may want to change your `JAVA_HOME`: 

 `export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-javaV-XX.Y.Z/Contents/Home`

or you may want to add its `bin` directory to your `PATH`:

  `export PATH=/Library/Java/JavaVirtualMachines/graalvm-ce-javaV-XX.Y.Z/Contents/Home/bin:"$PATH"`


## macOS Catalina Specifics

On macOS Catalina, you may get a warning that "the developer cannot be
verified". This is due to GraalVM not being signed and notarized yet.
The check, however, can be disabled in the "Security & Privacy"
preferences pane or by running the following command:

 `xattr -r -d com.apple.quarantine /Library/Java/JavaVirtualMachines/graalvm-ce-javaV-XX.Y.Z`
 

[Homebrew]: https://brew.sh/
