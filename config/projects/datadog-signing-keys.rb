# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https://www.datadoghq.com/).
# Copyright 2021-present Datadog, Inc.

# Modify this when adding/removing keys; also modify postinst script to add
# the new key to the APT keyring (I didn't find a reasonable way to make
# postinst script an omnibus template to render these in).
keys = ['33EE313BAD9589B7', '4B4593018387EEAF']

name 'datadog-signing-keys'
maintainer 'Datadog Packages <package@datadoghq.com>'
homepage 'https://www.datadoghq.com'
license 'Apache-2.0'
license_file 'LICENSE'

install_dir "/opt/#{name}"

build_version ENV['PACKAGE_VERSION']
build_iteration 1

description 'Datadog Signing Keys
 The datadog-signing-keys package carries currently active public signing
 keys that Datadog uses to sign APT repository metadata and DEB packages.
 Having this package installed makes all the included keys trusted by APT
 and allows for checking package-level signatures by debsig-verify.
 .
 Updating this package regularly will ensure presence of new keys prior
 to key rotations performed by Datadog, eliminating the need to add new
 keys manually.
'

dependency 'datadog-signing-keys'

runtime_dependency 'gnupg'

exclude '**/.git'
exclude '**/bundler/git'

package :deb do
  vendor 'Datadog <package@datadoghq.com>'
  epoch 1
  license 'Apache License Version 2.0'
  section 'utils'
  priority 'extra'
  safe_architecture 'all'
  if ENV.has_key?('DEB_SIGNING_PASSPHRASE') and not ENV['DEB_SIGNING_PASSPHRASE'].empty?
    signing_passphrase "#{ENV['DEB_SIGNING_PASSPHRASE']}"
    if ENV.has_key?('DEB_GPG_KEY_NAME') and not ENV['DEB_GPG_KEY_NAME'].empty?
      gpg_key_name "#{ENV['DEB_GPG_KEY_NAME']}"
    end
  end
end

keys.each do |key|
  extra_package_file "/etc/debsig/policies/#{key}"
  extra_package_file "/usr/share/debsig/keyrings/#{key}"
end
