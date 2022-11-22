#!/bin/bash -ex
# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2021-present Datadog, Inc.

apt_trusted_keyring="/etc/apt/trusted.gpg.d/datadog-archive-keyring.gpg"

for i in $(ls -d test/repos/*); do
    repo_path=$(pwd)/${i}
    echo "deb [signed-by=${USR_SHARE_KEYRING}] file://${repo_path} ./" > ${DD_LIST_FILE}

    # if apt update passes, we correctly recognized repodata signature
    apt-get update

    # verify package-level signature
    debsig-verify ${repo_path}/datadog-signing-keys*.deb
done

if [ "${ENSURE_TRUSTED_GPG_D_KEYRING}" = "true" ] && [ ! -f ${apt_trusted_keyring} ]; then
    echo "${apt_trusted_keyring} doesn't exist when it should"
    exit 1
fi

if [ "${ENSURE_TRUSTED_GPG_D_KEYRING}" != "true" ] && [ -f ${apt_trusted_keyring} ]; then
    echo "${apt_trusted_keyring} exists when it shouldn't"
    exit 1
fi
