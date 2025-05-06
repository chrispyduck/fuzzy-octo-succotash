import os

import pulumi

from stack import program

work_dir = os.path.join(os.getcwd(), ".pulumi")
os.makedirs(work_dir, exist_ok=True)
os.environ["PULUMI_HOME"] = work_dir  # directs the CLI to store state locally
os.environ["PULUMI_CONFIG_PASSPHRASE"] = "test"

stack = pulumi.automation.create_stack(
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

stack.up(
    on_output=print,
    log_flow=True,
    log_to_std_err=True,
)
