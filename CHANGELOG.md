# 1.2.0 / 2022-11-22

* Respect `/etc/apt/sources.list.d/datadog-observability-pipelines-worker.list`
  source list file when creating the keyring `/etc/apt/trusted.gpg.d`.

# 1.1.0 / 2022-03-22

* Always create `/etc/apt/trusted.gpg.d/datadog-archive-keyring.gpg`, unless
  `/etc/apt/sources.list.d/datadog.list` contains proper `signed-by` option.
  This ensures that `apt` knows signing keys even if `signed-by` is not used
  explicitly.

# 1.0.1 / 2021-07-26

* Ensure that created keyrings are world-readable.

# 1.0.0 / 2021-06-22

* First major release, there are no functionality changes from version 0.3.0.

# 0.3.0 / 2021-06-15

* Add dependency on `gnupg`.

# 0.2.0 / 2021-05-10

* Initial release.
