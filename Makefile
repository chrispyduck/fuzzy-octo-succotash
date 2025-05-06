WORKDIR := $(shell pwd)
export DEPOT_PROJECT := 4q51k81pcg
export DOCKER_HOST := unix:///Users/chris/.colima/default/docker.sock
export DOCKER_HOME = ${WORKDIR}/.docker
export DOCKER_CONFIG = ${WORKDIR}/.docker
export DOCKER_BUILDKIT := 1
export PULUMI_HOME := ${WORKDIR}/.pulumi
export PULUMI_CONFIG_PASSPHRASE := test

.PHONY: venv deps lock-deps setup clear-locks run-standalone run-depot clean

clean:
	@echo "Cleaning up..."
	@killall pulumi-resource-docker-build || true
	rm -vrf "${DOCKER_HOME}" "${PULUMI_HOME}/.pulumi/locks/organization/test/test"/*

distclean:
	@echo "Cleaning up..."
	@rm -vrf "${DOCKER_HOME}" "${PULUMI_HOME}" "${WORKDIR}/.venv"

.venv:
	@echo "Creating virtual environment..."
	uv python install 3.11
	uv venv

venv: .venv

deps:
	@echo "Installing dependencies..."
	@uv pip install -r requirements.txt
	
requirements.txt:
	uv pip freeze > requirements.txt

lock-deps: requirements.txt

${DOCKER_HOME}:
	@mkdir -p ${DOCKER_HOME}

setup: clean venv deps ${DOCKER_HOME}
	@mkdir -p ${PULUMI_HOME}

clear-locks:
	@rm ${PULUMI_HOME}/.pulumi/locks/organization/test/test/* || true

run-standalone: setup
	source .venv/bin/activate && python ./main.py

run-depot: setup
	source .venv/bin/activate && depot configure-docker --project ${DEPOT_PROJECT} && python ./main.py