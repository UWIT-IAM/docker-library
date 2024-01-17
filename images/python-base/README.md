This creates "base Python" images which have installed

- A specific python release (e.g., 3.10)
- Poetry

This can be built from the root of the project with

> `docker build -f images/python-base/Dockerfile -t 3.10-first images/python-base/ --build-arg PYTHON_VERSION=3.10`
