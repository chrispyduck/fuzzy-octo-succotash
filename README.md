# Deployment Bug Reproduction

There exists a bug in the depot CLI, the pulumi-docker-build Pulumi plugin, or both, which causes container builds to hang indefinitely.

This repo demonstrates normal behavior (via `make run-standalone`) and the buggy behavior (via `make run-depot`).

## Requirements

* Modern version of `uv` with `uv python` subcommand
* Make
* Depot CLI installed
* [Colima daemon](https://github.com/abiosoft/colima) (or change `DOCKER_HOST` in `Makefile`)

## Reproduction

First, build a docker image without using depot via `make run-standalone`. This should work.

Next, try building with depot via `make run-depot`. This hangs after the depot build finishes. The build appears to have been successful when viewed from depot.dev, but `pulumi-resource-docker-build` seems to hang.

This was made with depot version 2.85.2 (2025-04-25).

