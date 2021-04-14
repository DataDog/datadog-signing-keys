To add a new repo, you can manually trigger the `generate_testing_repo`
Gitlab task. You'll need to override `DEB_GPG_KEY_ID` and `DEB_GPG_KEY_NAME`
with values that represent the key you want to use to sign the repodata
as well as the package in the repository.
