#!/bin/bash
readonly GALAXY_YML='galaxy.yml'
readonly UPSTREAM_NS='middleware_automation'
readonly DOWNSTREAM_NS='redhat'

cd workdir
echo -n "Change collection namespace from ${UPSTREAM_NS} to ${DOWNSTREAM_NS}..."
sed -i "${GALAXY_YML}" \
    -e "s/\(^namespace: \)${UPSTREAM_NS}/\1${DOWNSTREAM_NS}/"
echo 'Done.'

if [ -n "${VERSION}" ]; then
  echo -n "Bump version to ${VERSION}..."
  sed -i "${GALAXY_YML}" \
      -e "s/^\(version: \).*$/\1\"${VERSION}\"/"
  echo 'Done.'
fi

git diff --no-color .
ansible-galaxy collection build .
