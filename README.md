# rules_platform
This repository contains all platforms-related rules or transitions that rules author/Bazel users could use. The README should be kept updated as new rules/transition get added to the repo.

For questions or concern, please email bazel-discuss@googlegroups.com.

# Motivation
Many rule authors and users want to create targets that can easily change the target platform: 
rule authors may want to add convenient rule attributes for this, whereas users frequently need to bundle together executables for multiple platforms in a single high-level artifact.
This repo houses new rules/transition which rules authors and Bazel users can import and use. Because these are Starlark implementations, with no Bazel changes, rules authos can feel free to extend or ignore these as needed.

# Rules
## Use case: Depend on a target built for a different platform
The `platform_data` rule can be used to change the target platform of a target, and then depend on that elsewhere in the build tree.
```
cc_binary(name = "foo")

platform_data(
    name = "foo_embedded",
    target = ":foo",
    platform = "//my/new:platform",
)

py_binary(
    name = "flasher",
    srcs = ...,
    data = [
        ":foo_embedded",
    ],
)
```
Regardless of what platform the top-level `:flasher` binary is built for, the `:foo_embedded` target will be built for `//my/new:platform`.

