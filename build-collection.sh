#!/bin/bash
readonly GALAXY_YML='galaxy.yml'
readonly UPSTREAM_NS='middleware_automation'
readonly DOWNSTREAM_NS='redhat'

pwd
ls .

sed -i "${GALAXY_YML}" \
    -e "s/\(^namespace: \)${UPSTREAM_NS}/\1${DOWNSTREAM_NS}/"
if [ -n "${RELEASE_VERSION}" ]; then
  sed -i "${GALAXY_YML}" \
      -e "s/^\(version: \).*$/\1\"${RELEASE_VERSION}\"/"
fi
git diff .
ansible-galaxy collection build .
