# ansible-engine-container

A small container from which to run Ansible.

The environment contains ansible, molecule, git, and other supporting tools.

## Usage

```
docker run -it --rm -v $(pwd):/work ansible-engine-container
```

If you want to use the Docker driver for molecule, then you need acces to the
host's Docker daemon from inside the ansible container. Include these volume
mappings as part of your `docker run ...`:

```
-v /usr/local/bin/docker:/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock
```

This should work in Docker Desktop for Windows and Docker Desktop for Mac.


## Background

This is an attempt to improve the accessibility of Ansible for non-sysadmin-type users,
especially those who may have a non-Unix-like desktop environment.
