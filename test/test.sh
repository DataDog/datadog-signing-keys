#!/bin/bash -ex

keyring="/usr/share/keyrings/datadog-archive-keyring.gpg"

for i in $(ls -d test/repos/*); do
    repo_path=$(pwd)/${i}
    echo "deb [signed-by=${keyring}] file://${repo_path} ./" > /etc/apt/sources.list.d/datadog.list

    # if apt update passes, we correctly recognized repodata signature
    apt-get update

    # verify package-level signature
    debsig-verify ${repo_path}/datadog-signing-keys*.deb
done

if [ "${ENSURE_TRUSTED_GPG_D_KEYRING}" = "true" ] && [ ! -f ${keyring} ]; then
    echo "${keyring} doesn't exist when it should"
fi

if [ "${ENSURE_TRUSTED_GPG_D_KEYRING}" != "true" ] && [ -f ${keyring} ]; then
    echo "${keyring} exists when it shouldn't"
fi
