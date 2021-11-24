#!/bin/bash
readonly GALAXY_YML='galaxy.yml'
readonly UPSTREAM_NS='middleware_automation'
readonly DOWNSTREAM_NS='redhat'

cd workdir
echo "RELEASE_VERSION: ${RELEASE_VERSION}"
echo -n "Change collection namespace from ${UPSTREAM_NS} to ${DOWNSTREAM_NS}..."
sed -i "${GALAXY_YML}" \
    -e "s/\(^namespace: \)${UPSTREAM_NS}/\1${DOWNSTREAM_NS}/"
echo 'Done.'

if [ -n "${RELEASE_VERSION}" ]; then
  echo -n "Bump version to ${RELEASE_VERSION}..."
  sed -i "${GALAXY_YML}" \
      -e "s/^\(version: \).*$/\1\"${RELEASE_VERSION}\"/"
  echo 'Done.'
fi

git diff --no-color .
ansible-galaxy collection build .
