VENV_DIR = env
PIP = $(VENV_DIR)/bin/pip

## Install virtual environment
venv:
ifeq ($(wildcard $(VENV_DIR)/*),)
	@echo "Did not find $(VENV_DIR), creating..."
	mkdir -p $(VENV_DIR)
	python3.8 -m venv $(VENV_DIR)
endif

# install requirements for local dev
requirements: venv
	$(PIP) install -r requirements.txt

# helpers for notebooks export
ipynb-to-py:
	$(VENV_DIR)/bin/jupytext --to py:percent notebooks/*.ipynb

py-to-ipynb:
	$(VENV_DIR)/bin/jupytext --to notebook notebooks/*.py

ipynb-to-html:
	$(VENV_DIR)/bin/jupyter nbconvert --output-dir='./html' --to html notebooks/*.ipynb

from-py: py-to-ipynb ipynb-to-html

# main target for notebooks export - creates .py and .html file from the notebook
from-ipynb: ipynb-to-py ipynb-to-html
