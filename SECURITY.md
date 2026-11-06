# Security policy

## Educational scope

This repository is a defensive learning lab. It contains generic configuration and
must not contain real credentials, private keys, access tokens, production inventory,
personal usernames, or private infrastructure addresses.

## Supplying environment-specific values

- Pass an SSH public key with `--extra-vars` or an ignored local variables file.
- Store secrets in a secret manager or Ansible Vault outside the repository.
- Never commit a vault password, decrypted vault file, `.env` file, or production
  inventory.
- Review staged changes before every commit.

Example using an environment variable without saving the value in Git:

```bash
ansible-playbook playbooks/site.yml \
  --extra-vars "homelab_admin_public_key=${LAB_PUBLIC_KEY}"
```

Only use a public key in `LAB_PUBLIC_KEY`. Private keys must never be passed as an
Ansible variable.

## Reporting a problem

Do not open a public issue containing sensitive information. Remove the data from the
working tree, rotate or revoke the exposed credential, and clean the Git history before
publishing the repository.

