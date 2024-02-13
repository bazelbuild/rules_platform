# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
platform_data_test is an analysistest rule that takes a target_under_test (e.g platform_data target) and a value for expected_platform. The test rule implementation make asserts against the transitive target platforms to make sure that --platform is set properly by the transition. 
"""

load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")

TransitivePlatformInfo = provider(
    "Contains information about transitive target platform info",
    fields = ["platforms"],
)

TestPlatformInfo = provider(
    "Contains information about target platform",
    fields = ["platforms"],
)

def _transitive_aspect_impl(target, aspect_ctx):
    transitive_target_platforms = []
    for dep in getattr(aspect_ctx.rule.attr, "target", []):
        if TestPlatformInfo in dep:
            transitive_target_platforms.append(dep[TestPlatformInfo].platforms)

    return [TransitivePlatformInfo(platforms = transitive_target_platforms)]

_transitive_aspect = aspect(
    attr_aspects = ["target"],
    implementation = _transitive_aspect_impl,
)

def _platform_data_test_impl(ctx):
    env = analysistest.begin(ctx)
    target_under_test = analysistest.target_under_test(env)
    transitive_target_platforms = target_under_test[TransitivePlatformInfo]

    asserts.equals(
        env,
        ctx.attr.expected_platform,
        str(transitive_target_platforms.platforms[0]),
        "Target platform does not match the expected value",
    )
    return analysistest.end(env)

platform_data_test = analysistest.make(
    _platform_data_test_impl,
    attrs = {
        "expected_platform": attr.string(),
    },
    extra_target_under_test_aspects = [_transitive_aspect],
)

def print_target_platform(target_platform):
    return """
    echo Target platform for target under test is {target_platform}
    """

def _write_target_platform_impl(ctx):
    script = print_target_platform(str(ctx.fragments.platform.platform))
    executable = ctx.actions.declare_file(ctx.label.name)

    ctx.actions.write(
        output = executable,
        content = script,
        is_executable = True,
    )
    return [
        DefaultInfo(executable = executable),
        TestPlatformInfo(platforms = ctx.fragments.platform.platform),
    ]

write_target_platform_rule_test = rule(
    implementation = _write_target_platform_impl,
    test = True,
)
