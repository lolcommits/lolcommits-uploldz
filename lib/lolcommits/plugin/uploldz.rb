require 'rest_client'
require 'base64'
require 'lolcommits/plugin/base'

module Lolcommits
  module Plugin
    class Uploldz < Base

      attr_accessor :endpoint

      ##
      # Initialize plugin with runner, config and set all configurable options.
      #
      def initialize(runner: nil, config: nil)
        super
        options.concat(plugin_options)
      end

      ##
      # Returns position(s) of when this plugin should run during the capture
      # process. Uploading happens when a new capture is ready.
      #
      # @return [Array] the position(s) (:capture_ready)
      #
      def self.runner_order
        [:capture_ready]
      end

      ##
      # Returns true/false indicating if the plugin has been correctly
      # configured. The `endpoint` option must be set with a URL beginning with
      # http(s)://
      #
      # @return [Boolean] true/false indicating if plugin is correctly
      # configured
      #
      def valid_configuration?
        !!(configuration[:endpoint] =~ /^http(s)?:\/\//)
      end

      ##
      # Post-capture hook, runs after lolcommits captures a snapshot. Uploads
      # the lolcommit image to the remote server with an optional Authorization
      # header and the following request params.
      #
      # `file`    - captured lolcommit image file
      # `message` - the commit message
      # `repo`    - repository name e.g. mroth/lolcommits
      # `sha`     - commit SHA
      # `key`     - key (string) from plugin configuration (optional)
      # `author_name` - the commit author name
      # `author_email` - the commit author email address
      #
      # @return [RestClient::Response] response object from POST request
      # @return [Nil] if any error occurs
      #
      def run_capture_ready
        debug "Posting capture to #{configuration[:endpoint]}"
        RestClient.post(
          configuration[:endpoint],
          {
            file: File.new(runner.main_image),
            message: runner.message,
            repo: runner.vcs_info.repo,
            author_name: runner.vcs_info.author_name,
            author_email: runner.vcs_info.author_email,
            sha: runner.sha,
            key: configuration[:optional_key]
          },
          Authorization: authorization_header
        )
      rescue => e
        log_error(e, "ERROR: RestClient POST FAILED #{e.class} - #{e.message}")
      end


      private

      ##
      # Returns all configuration options available for this plugin.
      #
      # @return [Array] the option names
      #
      def plugin_options
        [
          :endpoint,
          :optional_key,
          :optional_http_auth_username,
          :optional_http_auth_password
        ]
      end

      ##
      # Builds an HTTP basic auth header from plugin options. If both the
      # username and password options are empty nil is returned.
      #
      # @return [String] the HTTP basic auth header string (Base64 encoded u:p)
      # @return [Nil] if no username or password option set
      #
      def authorization_header
        user     = configuration[:optional_http_auth_username]
        password = configuration[:optional_http_auth_password]
        return unless user || password

        'Basic ' + Base64.encode64("#{user}:#{password}").chomp
      end
    end
  end
end
