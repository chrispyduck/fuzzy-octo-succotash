import pulumi_docker_build as docker


def program():
    docker.Image(
        "test",
        dockerfile=docker.DockerfileArgs(
            inline="""FROM scratch
ADD README.md /""",
        ),
        tags=["test"],
        push=False,
    )
