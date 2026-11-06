.PHONY: install lint syntax-check validate up provision verify destroy

PYTHON ?= $(shell command -v python3.14 || command -v python3.13 || command -v python3.12 || command -v python3.11 || command -v python3)
VENV := .venv
COLLECTIONS_PATH := .ansible/collections

install:
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/pip install -r requirements-dev.txt
	$(VENV)/bin/ansible-galaxy collection install -r requirements.yml -p $(COLLECTIONS_PATH)

lint:
	$(VENV)/bin/yamllint .
	ANSIBLE_COLLECTIONS_PATH=$(COLLECTIONS_PATH) $(VENV)/bin/ansible-lint playbooks/site.yml

syntax-check:
	ANSIBLE_COLLECTIONS_PATH=$(COLLECTIONS_PATH) $(VENV)/bin/ansible-playbook --syntax-check playbooks/site.yml

validate:
	vagrant validate

up:
	vagrant up

provision:
	vagrant provision

verify:
	vagrant ssh -c "sudo sshd -t"
	vagrant ssh -c "sudo ufw status verbose"
	vagrant ssh -c "sudo fail2ban-client status sshd"
	vagrant ssh -c "sudo auditctl -l"

destroy:
	vagrant destroy

