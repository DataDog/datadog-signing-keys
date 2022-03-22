#!/bin/bash -ex
# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2021-present Datadog, Inc.

apt_trusted_keyring="/etc/apt/trusted.gpg.d/datadog-archive-keyring.gpg"
usr_share_keyring="/usr/share/keyrings/datadog-archive-keyring.gpg"
sources_list_file="/etc/apt/sources.list.d/datadog.list"

for i in $(ls -d test/repos/*); do
    repo_path=$(pwd)/${i}
    if [ "${USE_SIGNED_BY}" = "true" ]; then
        echo "deb [signed-by=${usr_share_keyring}] file://${repo_path} ./" > ${sources_list_file}
    else
        echo "deb file://${repo_path} ./" > ${sources_list_file}
    fi

    # if apt update passes, we correctly recognized repodata signature
    apt-get update

    # verify package-level signature
    debsig-verify ${repo_path}/datadog-signing-keys*.deb
done

if { [ "${ENSURE_TRUSTED_GPG_D_KEYRING}" = "true" ] || [ -z "${USE_SIGNED_BY}" ]; } && [ ! -f ${apt_trusted_keyring} ]; then
    echo "${apt_trusted_keyring} doesn't exist when it should"
    exit 1
fi

if { [ "${ENSURE_TRUSTED_GPG_D_KEYRING}" != "true" ] && [ -n "${USE_SIGNED_BY}" ] } && [ -f ${apt_trusted_keyring} ]; then
    echo "${apt_trusted_keyring} exists when it shouldn't"
    exit 1
fi
