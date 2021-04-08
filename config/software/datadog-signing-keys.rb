# Unless explicitly stated otherwise all files in this repository are licensed
# under the Apache License Version 2.0.
# This product includes software developed at Datadog (https:#www.datadoghq.com/).
# Copyright 2016-present Datadog, Inc.

require 'pathname'

name 'datadog-signing-keys'

license "Apache-2.0"
license_file "LICENSE"
skip_transitive_dependency_licensing true

source path: "."

build do
  apt_trust_dir = '/etc/apt/trusted.gpg.d/'
  policies_dir = '/etc/debsig/policies/'
  keyrings_dir = '/usr/share/debsig/keyrings/'
  mkdir apt_trust_dir
  mkdir policies_dir
  mkdir keyrings_dir

  copy "files/keyrings/*", keyrings_dir
  copy "files/policies/*", policies_dir
  Dir.entries("#{Omnibus::Config.project_root}/files/keyrings/").each do |key|
    unless key.start_with? "."
      copy "files/keyrings/#{key}/debsig.gpg", "#{apt_trust_dir}/datadog-#{key}.gpg"
    end
  end
end
