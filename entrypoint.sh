#!/bin/bash
set -e

if [ -e "isInstalled" ]; then

  if [ -n "$RUN_DOCKER_DAEMON" ]; then
    service docker start
  fi

  bash ./run.sh
else
  if [ $# -eq 2 ]; then
    repo_url="$1"
    agent_token="$2"
  else
    if [ $# -ne 0 ]; then
      echo "Invalid arguments number: The arguments should be given (Repo_url, Agent_token)"
      exit 1
    fi
    repo_url="$REPO_URL"
    agent_token="$AGENT_TOKEN"

    if [ -z "$repo_url" ]; then
      echo "Invalid argument: REPO_URL env variable is not available value"
      exit 1
    fi

    if [ -z "$agent_token" ]; then
      echo "Invalid argument: AGENT_TOKEN env variable is not available value"
      exit 1
    fi
  fi

  if [ -n "$RUN_DOCKER_DAEMON" ]; then
    service docker start
  fi

  bash ./config.sh --url "$repo_url" --token "$agent_token"
  touch isInstalled
  bash ./run.sh
fi


