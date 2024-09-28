# frozen_string_literal: true

require "test_helper"
require 'webmock/minitest'

describe Lolcommits::Plugin::Uploldz do
  include Lolcommits::TestHelpers::GitRepo
  include Lolcommits::TestHelpers::FakeIO

  def valid_enabled_config
    {
      enabled: true,
      endpoint: "https://uploldz.com/uplol",
      optional_http_auth_username: 'joe',
      optional_http_auth_password: '1234'
    }
  end

  describe "initalizing" do
    it "assigns runner and all plugin options" do
      _(plugin.runner).wont_be_nil
      _(plugin.options).must_equal [
        :enabled,
        :endpoint,
        :optional_key,
        :optional_http_auth_username,
        :optional_http_auth_password
      ]
    end
  end

  describe "#enabled?" do
    it "is false by default" do
      _(plugin.enabled?).must_equal false
    end

    it "is true when configured" do
      plugin.configuration = valid_enabled_config
      _(plugin.enabled?).must_equal true
    end
  end

  describe "run_capture_ready" do
    before { commit_repo_with_message("first commit!") }
    after { teardown_repo }

    it "syncs lolcommits" do
      captured_img_path = File.expand_path("./test/images/lolcommit.jpg")

      in_repo do
        plugin.configuration = valid_enabled_config
        plugin.runner.lolcommit_path = captured_img_path

        stub_request(:post, "https://uploldz.com/uplol").to_return(status: 200)

        plugin.run_capture_ready

        assert_requested :post, "https://uploldz.com/uplol", times: 1,
          headers: {'Content-Type' => /multipart\/form-data/ } do |req|
          _(req.body).must_match(/Content-Disposition: form-data;.+name="file"; filename="lolcommit.jpg"/)
          _(req.body).must_match 'name="repo"'
          _(req.body).must_match 'name="author_name"'
          _(req.body).must_match 'name="author_email"'
          _(req.body).must_match 'name="sha"'
          _(req.body).must_match 'name="key"'
          _(req.body).must_match "plugin-test-repo"
          _(req.body).must_match "first commit!"
        end
      end
    end
  end

  describe "configuration" do
    it "allows plugin options to be configured" do
      # enabled, endpoint, key, user, password
      inputs = %w(
        true
        https://my-server.com/uplol
        key-123
        joe
        1337pass
      )
      configured_plugin_options = {}

      fake_io_capture(inputs: inputs) do
        configured_plugin_options = plugin.configure_options!
      end

      _(configured_plugin_options).must_equal({
        enabled: true,
        endpoint: "https://my-server.com/uplol",
        optional_key: "key-123",
        optional_http_auth_username: "joe",
        optional_http_auth_password: "1337pass"
      })
    end

    describe "#valid_configuration?" do
      it "returns false for an invalid configuration" do
        plugin.configuration = { endpoint: "gibberish" }
        _(plugin.valid_configuration?).must_equal false
      end

      it "returns true with a valid configuration" do
        plugin.configuration = valid_enabled_config
        _(plugin.valid_configuration?).must_equal true
      end
    end
  end

  private
    def plugin
      @plugin ||= Lolcommits::Plugin::Uploldz.new(
        runner: Lolcommits::Runner.new
      )
    end
end
