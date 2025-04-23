# UW-IT IAM Docker Library

This repository contains the dockerfiles of some shared images that are available 
on [ghcr.io] for anyone to consume.

Github will run scheduled actions to rebuild these images and keep them up to date. 
These scheduled builds are always tagged with their build as a pseudo-semver as:
  `YYYY.M.D.h.m`, where:
  
  - YYYY: Year (always 4 digits)
  - M: Month of year (non 0-padded)
  - D: Day of month (non 0-padded)
  - h: Hour of build (non 0-padded)
  - m: Minute of build (non 0-padded)


If you are a dependent of one of these images, and 
an update breaks you, you can simply tag the last known good build instead of 
`latest` while you resolve the issue. 

Subsequent builds of dependent images will incorporate these changes. It may be a 
good idea to set up your own scheduled actions to keep stagnant dependents up to date.


## Index of Images
⚠️ The following images have been removed and are no longer maintained:
- poetry
- uw-saml-poetry

These images were unused and no longer pulled by active projects (including identity.uw).
They’ve been replaced by a more flexible, matrix-based build process that uses
python:<version>-slim as the base image and installs Poetry via pipx, following
current best practices. If you need a Python + Poetry image, use that approach instead.

# Contributing

Contributions to our ecosystem are welcome! If you would like to add images here to 
be reused, feel free. Some things to keep in mind:

- The images should not require any special credentials to pull; public means public.
  **Do not build any secret values into the images!**


[ghcr.io]: https://github.com/orgs/UWIT-IAM/packages
[uw-saml-python]: https://github.com/uwit-iam/uw-saml-python
