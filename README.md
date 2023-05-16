# Automated Configuration for a Development Environment

This repository houses playbooks that handle setting up and installing software
and packages that I use in my development environment. The playbooks are specific
to my setup of a development environment, but could easily be used by another
with potentially minor changes.

## Usage

Execute the command against the `install-core.yml` playbook to perform a full configuration.

Run the following command within the root directory, providing the sudo password to allow
root access when running:

```shell
ansible-playbook install-core.yml --ask-become-pass
```
