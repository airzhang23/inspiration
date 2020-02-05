---
layout: post
title: Ansible Essentials Workshop Learning
img: ansible1.jpg
---

### Ansible Essentials

**[Resources]:**

- [Slide Decks](https://network-automation.github.io/linklight/decks/ansible-essentials.html#/)

- [Agenda & Exercise](http://ansible-workshop.redhatgov.io/standard/workshop/index.html)
- [Ansible Modules](https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html)
- [NetApp Ansible Modules](https://docs.ansible.com/ansible/latest/modules/list_of_storage_modules.html#netapp)

Ansible is:  "Running the playbook to automate the management of resources via UI or RESTful API"

- *Simple*: Get productive quickly
- *Powerful*: Orchestrate the app lifecycle
- *Agentless*: OpenSSH & WinRM

```
What is Ansible?

It's a simple automation language that can perfectly describe an IT application infrastructure in Ansible Playbooks.

It's an automation engine that runs Ansible Playbooks.

Ansible Tower is an enterprise framework for controlling, securing and managing your Ansible automation with a UI and RESTful API.
```

**Ansible Automation Engine:**

- Inventory
- API
- Modules
- Plugins

Modules: 针对不同的设备，应用，有不同的module。

Inventory: 设置主机，组，等等。也就是playbook针对的操作对象。`/etc/ansible/hosts`来定义。

```yaml
[ansible@leiz1 playbooks]$ cat /etc/ansible/hosts
[local]
localhost

[centos]
leiz2.mylabserver.com

[ubuntu]
leiz3.mylabserver.com
```

