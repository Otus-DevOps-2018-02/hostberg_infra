require "spec_helper"

describe package("mongodb-org") do
  it { should be_installed }
end

describe service("mongod") do
  it { should be_enabled }
end

describe port(27017) do
  it { should be_listening.on("127.0.0.1").with("tcp") }
end
