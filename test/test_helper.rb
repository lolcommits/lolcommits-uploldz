# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# lolcommits gem
require 'lolcommits'

# lolcommit test helpers
require 'lolcommits/test_helpers/git_repo'
require 'lolcommits/test_helpers/fake_io'

if ENV['COVERAGE']
  require 'simplecov'
end

# plugin gem test libs
require 'lolcommits/uploldz'
require 'minitest/autorun'

# swallow all debug output during test runs
def debug(msg); end
