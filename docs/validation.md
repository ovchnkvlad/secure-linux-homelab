# Validation evidence

Validated locally on 2026-11-07 with an ARM64 Ubuntu 24.04 Vagrant guest.

## Static checks

| Check | Result |
| --- | --- |
| `yamllint .` | Passed |
| `ansible-lint playbooks/site.yml` | Passed with the production profile |
| `ansible-playbook --syntax-check playbooks/site.yml` | Passed |
| `vagrant validate` | Passed |

## Provisioning

The first successful provisioning run completed all enabled roles:

```text
ok=24 changed=11 unreachable=0 failed=0 skipped=2
```

The immediate second run demonstrated idempotency:

```text
ok=20 changed=0 unreachable=0 failed=0 skipped=2
```

## Runtime controls

- `sshd -t` accepted the complete SSH configuration.
- UFW reported `deny (incoming)` and `allow (outgoing)` defaults.
- Only the configured SSH port was allowed inbound.
- The Fail2ban `sshd` jail was active and reading the systemd journal.
- auditd loaded watch rules for identity, privilege, SSH, and authentication files.

No public server, cloud credential, password, personal username, or private SSH key was
used during validation.
