.PHONY: venv deps lock-deps setup run

.venv:
	uv python install 3.11
	uv venv

venv: .venv
	@echo "Virtual environment created. Activate it with 'source .venv/bin/activate'."

deps:
	@echo "Installing dependencies..."
	@uv pip install -r requirements.txt

	
requirements.txt:
	uv pip freeze > requirements.txt

lock-deps: requirements.txt

setup: venv deps
	@mkdir -p .pulumi

run: setup
	python ./main.py