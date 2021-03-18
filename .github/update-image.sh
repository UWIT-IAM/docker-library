#!/usr/bin/env bash

set -e  # Exit on any error
BUILD_OPTIONS=
EDGE_TAG=${EDGE_TAG:-'latest'}
GCR_PROJECT=${GCR_PROJECT:-uwit-mci-iam}
GCR_HOST=${GCR_HOST:-gcr.io}

while (( $# ))
do
  case $1 in
    --dockerfile|-d)  # Required if not of the pattern "images/{REPO_NAME}.dockerfile"
      shift
      DOCKERFILE=$1
      ;;
    --version|-v)  # Required here or a an env variable; this will be the image tag
      shift
      VERSION=$1
      ;;
    # Required either here or as an environment variable; just the repo name,
    # not including host, project, or tags.
    --repo|-r)
      shift
      REPO=$1
      ;;
    --no-pull) # Skip pulling the image; good for bootstrapping.
      NO_PULL=1
      ;;
    --gcr-key-file|-key)
      shift
      GOOGLE_APPLICATION_CREDENTIALS=$1
      ;;
    --target|-t)  # Optional; provide a target inside a dockerfile
      shift
      BUILD_OPTIONS="${BUILD_OPTIONS} --target $1"
      BUILD_TARGET=$1
      ;;
    --pre-release|-pre)  # Push a release without tagging as 'latest'
      NO_EDGE=1
      ;;
    --qualifier|-q)  # Optional; for scoped modifications of a build (e.g., 'slim')
      shift
      QUALIFIER=$1
      VERSION="${VERSION}-${QUALIFIER}"
      EDGE_TAG="${EDGE_TAG}-${QUALIFIER}"
      ;;
    --debug)  # Print all commands with variable substitution
      set -x
      ;;
    --dry-run|-z)
      DRY_RUN=1
      ;;
  esac
  shift
done

REQUIRED_ARGS=( 'REPO' 'DOCKERFILE' 'VERSION' )

if [[ -z "${DOCKERFILE}" ]]
then
  DOCKERFILE=images/${REPO}.dockerfile
fi

if [[ ! -f "${DOCKERFILE}" ]]
then
  echo "Dockerfile ${DOCKERFILE} does not exist!"
  exit 1
fi

for ARG in ${REQUIRED_ARGS[@]}
do
  if [[ -z "${!ARG}" ]]
  then
    FAIL=1
    echo "Required argument $ARG not set!"
  fi
done
test -n "${FAIL}" && exit $FAIL

function push-image() {
  IMAGE=$1
  if [[ -n "${DRY_RUN}" && "${DRY_RUN}" != "0" ]]
  then
    echo "[DRY RUN] Not pushing $IMAGE"
  else
    docker push $IMAGE
  fi
}


CANONICAL_IMAGE=${GCR_HOST}/${GCR_PROJECT}/${REPO}:${VERSION}
EDGE_IMAGE=${GCR_HOST}/${GCR_PROJECT}/${REPO}:${EDGE_TAG}

if [[ -z ${NO_PULL} ]]
then
  echo "Pulling ${EDGE_IMAGE}"
  docker pull ${EDGE_IMAGE}
else
  echo "Skipping edge pull for ${CANONICAL_IMAGE} build"
fi

docker build -f ${DOCKERFILE} ${BUILD_OPTIONS} -t ${CANONICAL_IMAGE} .
push-image ${CANONICAL_IMAGE}

if [[ -z "${NO_EDGE}" ]]
then
  docker tag ${CANONICAL_IMAGE} ${EDGE_IMAGE}
  push-image ${EDGE_IMAGE}
else
  echo "Not tagging an edge release, since --pre-release is specified"
fi
