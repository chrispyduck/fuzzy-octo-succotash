import os

import pulumi

from stack import program

stack = pulumi.automation.create_or_select_stack(
    stack_name="organization/test/test",
    project_name="test",
    program=program,
    opts=pulumi.automation.LocalWorkspaceOptions(
        project_settings=pulumi.automation.ProjectSettings(
            name="test",
            runtime="python",
            backend=pulumi.automation.ProjectBackend(f"file://{os.getcwd()}/.pulumi"),
        ),
        secrets_provider="passphrase",
    ),
)

# succeeds
stack.up(
    on_output=print,
    log_flow=True,
    log_to_std_err=True,
)

# fails
stack.up(
    on_output=print,
    log_flow=True,
    log_to_std_err=True,
)
