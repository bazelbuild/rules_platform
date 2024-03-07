# Releasing rules_platform

1. Update version in distro/BUILD.bazel,
2. Build the release running `bazel build //distro:rules_platform-{version}`
3. Prepare release notes running `bazel build //distro:relnotes`
4. Create a new release on GitHub
5. Copy/paste the produced `relnotes.txt` into the notes. Adjust as needed.
6. Upload the produced tar.gz file as an artifact.
