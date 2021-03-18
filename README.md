# UW-IT IAM Public Docker Library

This repository contains the dockerfiles of some shared images that are available 
publicly from the [uwitiam dockerhub repository]. 

Github will run scheduled actions to rebuild these images and keep them up to date. 
These scheduled builds are always tagged with their build as a pseudo-semver as:
  YYYY.JJJ.HH.MM
format, as well as with `latest`. If you are a dependent of one of these images, and 
an update breaks you, you can simply tag the last known good build instead of 
`latest` while you resolve the issue. Additionally, these images will be tagged 
with an MD5 hash of the dockerfile itself, so that you can distinguish between the 
build strategy and the build artifact.

Subsequent builds of dependent images will incorporate these changes. It may be a 
good idea to set up your own scheduled actions to keep stagnant dependents up to date.

Although we currently use dockerhub, we will be migrating to [gcr.io].
This should not affect you.


## Index of Images

- [poetry](images/poetry.dockerfile) 
  - [View on dockerhub](https://hub.docker.com/repository/docker/uwitiam/poetry)
  - *Description*: A python3.8 image that has poetry installed, allowing you to simply 
    add your project files into the docker image, and use poetry to install and 
    build your package inside the container.
- [uw-saml-poetry](images/uw-saml-poetry.dockerfile)
  - [View on dockerhub](https://hub.docker.com/repository/docker/uwitiam/uw-saml-poetry)
  - Installs [uw-saml-python] and its dependencies, which is a heavy lift on its own.
    This descends from uwitiam/poetry above. 
   

# Contributing

Contributions to our ecosystem are welcome! If you would like to add images here to 
be reused, feel free. Some things to keep in mind:

- The images should not require any special credentials or permissions
- The images should not have any internal restrictions on who _should_ be using it; 
  these will be available publicly.
  

  

## Before you push . . .

If you are adding a new image, it needs to be seeded into our dockerhub org first.
That requires sooper secret credentials that only 
[@tomthorogood](https://github.com/tomthorogood) has access to. (See above note, re: 
[gcr.io].)

Therefore, you need to create a pull request; its checks will fail, and that's ok. 
Tom can review and seed the image for you from your PR branch, which will then update 
normally thereafter. 

[uwitiam dockerhub repository]: https://hub.docker.com/orgs/uwitiam/repositories 
[uw-saml-python]: https://github.com/uwit-iam/uw-saml-python
[gcr.io]: https://gcr.io
