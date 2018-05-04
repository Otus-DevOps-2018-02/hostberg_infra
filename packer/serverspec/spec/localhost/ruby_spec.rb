require "spec_helper"

describe package("ruby-full") do
  it { should be_installed }
end

describe package("ruby-bundler") do
  it { should be_installed }
end

describe package("build-essential") do
  it { should be_installed }
end
