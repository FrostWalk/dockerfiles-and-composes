#!/bin/bash

set -eux

: $GITHUB_ORG
: $RUNNER_MANAGER_TOKEN
: $RUNNER_NAME

# fetch a short-lived runner registration token for the org
reg_token=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $RUNNER_MANAGER_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/${GITHUB_ORG}/actions/runners/registration-token | jq -r .token)

/bin/bash config.sh --unattended --url https://github.com/${GITHUB_ORG} --name ${RUNNER_NAME} --work _work --token ${reg_token} --labels latex,x64,linux

remove () {
  local rem_token=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $RUNNER_MANAGER_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/${GITHUB_ORG}/actions/runners/remove-token | jq -r .token)

  ./config.sh remove --token $rem_token
}

trap remove EXIT

./bin/runsvc.sh
