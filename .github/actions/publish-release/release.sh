#!/usr/bin/env bash
source ./.build-scripts/sources/github-actions.sh

set -x

tag_base="ghcr.io/uwit-iam/${LIBRARY_IMAGE}"
version=$(date '+%Y.%-m.%-d.%-H.%-M')
version_tag="${tag_base}:${version}"
latest_tag=${tag_base}:latest
release_qualifier=

if [[ "${dry_run}" != 'false' ]]
then
  release_qualifier='[DRY RUN]'
fi

docker build \
  -f images/${LIBRARY_IMAGE}.dockerfile \
  -t ${version_tag} \
  ./images/${LIBRARY_IMAGE}
docker version_tag ${version_tag} ${latest_tag}

if [[ "${dry_run}" == 'false' ]]
then
  docker push ${version_tag}
  docker push ${latest_tag}
else
  echo "Not pushing images; dry-run mode."
fi

set_ci_output version ${version}
set_ci_output tag ${version_tag}
set_ci_output release-qualifier "$release_qualifier"
