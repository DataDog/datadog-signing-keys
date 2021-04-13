#!/bin/bash -ex

for i in $(ls -d test/repos/*); do
    repo_path=$(pwd)/${i}
    echo "deb file://${repo_path} ./" > /etc/apt/sources.list.d/datadog.list

    # if apt update passes, we correctly recognized repodata signature
    apt update

    # verify package-level signature
    debsig-verify ${repo_path}/datadog-signing-keys*.deb
done
