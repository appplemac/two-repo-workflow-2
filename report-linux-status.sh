#!/bin/bash
# relies on $LINUX_REPO and $LINUX_SHA1 being set

TEST_FAILURE_FILE="$LINUX_REPO/test-failure.txt"
GITHUB_STATUS_URL="https://api.github.com/repos/appplemac/two-repo-workflow-linux/statuses/$LINUX_SHA1"

TEST_STATUS="success"
TEST_DESCRIPTION="OS X tests succeeded"

if [[ -f $TEST_FAILURE_FILE ]]
  then
    TEST_STATUS="failure"
    TEST_DESCRIPTION="OS X tests failed"
fi

curl
  --header "Content-Type: application/json"
  --data "{ 'state': '$TEST_STATUS', \
           'target_url': '$CIRCLE_BUILD_URL', \
           'description': '$TEST_DESCRIPTION', \
           'context': 'circleci/os-x' }"
  --request POST "$GITHUB_STATUS_URL"
