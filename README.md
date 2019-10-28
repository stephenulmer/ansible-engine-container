# ansible-engine-container

A small container from which to run Ansible.

## Usage

```
docker run -it --rm -v $(pwd):/work ansible-engine-container
```

The environment contains ansible, molecule, git, and other supporting tools.

## Background

This is an attempt to improve the accessibility of Ansible for non-sysadmin-type users,
especially those who may have a non-Unix-like desktop environment.
