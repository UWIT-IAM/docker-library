# UW-IT IAM Public Docker Library

This repository contains the dockerfiles of some shared images that are available 
on [gcr.io] for the UW-IT IAM team.

Github will run scheduled actions to rebuild these images and keep them up to date. 
These scheduled builds are always tagged with their build as a pseudo-semver as:
  `YYYY.JJJ.HH.MM`, where:
  
  - YYYY: Year
  - JJJ: Day of year (non 0-padded)
  - HH: Hour of build (non 0-padded)
  - MM: Minute of build (non 0-padded)


If you are a dependent of one of these images, and 
an update breaks you, you can simply tag the last known good build instead of 
`latest` while you resolve the issue. 

Subsequent builds of dependent images will incorporate these changes. It may be a 
good idea to set up your own scheduled actions to keep stagnant dependents up to date.


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

[uw-saml-python]: https://github.com/uwit-iam/uw-saml-python
[gcr.io]: https://gcr.io
