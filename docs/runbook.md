# Operations runbook

## Start the disposable lab

```bash
make install
make up
make verify
```

## Reapply configuration

```bash
make provision
```

Ansible tasks should be idempotent. A second provisioning run should report no
unexpected changes.

## Check services

```bash
vagrant ssh -c "systemctl status ssh --no-pager"
vagrant ssh -c "sudo ufw status verbose"
vagrant ssh -c "sudo fail2ban-client status sshd"
vagrant ssh -c "sudo auditctl -l"
```

## SSH configuration failure

The SSH handler validates the complete configuration with `sshd -t` before restarting
the service. If validation fails, inspect the managed fragment from the Vagrant console:

```bash
vagrant ssh
sudo sshd -t
sudo sed -n '1,200p' /etc/ssh/sshd_config.d/99-homelab-hardening.conf
```

## Firewall recovery

Use the Vagrant console rather than opening additional network access:

```bash
vagrant ssh
sudo ufw status numbered
sudo ufw disable
```

Fix the Ansible variables and provision again. Do not make the emergency change a
permanent manual workaround.

## Destroy the lab

```bash
make destroy
```

The VM is disposable. Destroying it is the expected cleanup procedure.

