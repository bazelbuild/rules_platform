load("//platform_data:defs.bzl", "platform_data")
load(":analysis_tests.bzl", "platform_data_test", "write_target_platform_rule_test")

platform_data_test(
    name = "platform_data_test",
    expected_platform = "//third_party/bazel_platforms/experimental/platform_data/test:test_platform",
    target_under_test = ":foo_embedded",
)

write_target_platform_rule_test(
    name = "foo",
)

platform_data(
    name = "foo_embedded",
    testonly = True,
    platform = ":test_platform",
    target = ":foo",
)

platform(
    name = "test_platform",
    constraint_values = [
    ],
)
