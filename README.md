# datadog-signing-keys

This repository contains sources for the `datadog-signing-keys` DEB package.

The `datadog-signing-keys` package carries currently active public signing
keys that Datadog uses to sign APT repository metadata and DEB packages.
Having this package installed makes all the included keys trusted by APT
and allows for checking package-level signatures by `debsig-verify`.

Updating this package regularly will ensure presence of new keys prior
to key rotations performed by Datadog, eliminating the need to add new
keys manually.
