#!/bin/bash

set -o xtrace

git diff --name-status "$PR_BASE" "$PR_HEAD"

# Abort if anything but modified and added
abort=$(git diff --name-status "$PR_BASE" "$PR_HEAD" | cut -c1 | grep -E "C|D|R|T|U|X|B" )


if [[ ! -n $abort ]]; then

    echo "No unsupported changes detected. Starting deployment."
    
    export GALAXYDIR="$(pwd)"

    cd ..

    export BASEDIR="$(pwd)"

    git clone https://github.com/CloudVE/galaxy-k8s-dev-env
    git clone https://github.com/galaxyproject/galaxy-helm
    cd galaxy-helm/galaxy
    helm dep update
    cd ../..
    export CHARTDIR="$(pwd)/galaxy-helm"
    export HASHED_PR_NUM="$(sha1sum < <(printf '%s' \"galaxy-pr-${PR_NUM}\") | cut -f 1 -d ' ')"
    echo "Starting making symlinks"

    cd galaxy-k8s-dev-env

    bash symlink_branch.sh "pr-${PR_NUM}" "$GALAXYDIR" "$CHARTDIR"

    bash update_links.sh "pr-${PR_NUM}" "$DEVENV_DOMAIN" "/pr-${PR_NUM}-$HASHED_PR_NUM" "$PR_BASE"

    bash helm_update.sh "pr-${PR_NUM}" "pr-${PR_NUM}" $@ --set postgresql.deploy=false --wait > "$GALAXYDIR/gxyinstalloutput"

fi
