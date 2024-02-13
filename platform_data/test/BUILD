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

load("//platform_data:defs.bzl", "platform_data")
load(":analysis_tests.bzl", "platform_data_test", "write_target_platform_rule_test")

platform_data_test(
    name = "platform_data_test",
    expected_platform = "@@//platform_data/test:test_platform",
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
