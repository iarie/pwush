require 'http'

require 'pwush/api/messages'
require 'pwush/api/devices'
require 'pwush/api/applications'

module Pwush
  class Client
    include Api::Messages
    include Api::Devices
    include Api::Applications

    def initialize(options)
      @config = Config.new(options)
    end

    private

    def get(action, payload = nil)
      perform_request(:get, action, payload)
    end

    def post(action, payload = nil)
      perform_request(:post, action, payload)
    end

    def perform_request(verb, action, payload)
      Response.wrap { raw_request(verb, action, payload) }
    end

    def raw_request(verb, action, payload)
      request = build_request(payload)
      url     = url(action)

      @config.logger.info(
        "Pushwoosh #{verb.upcase} #{url} BODY #{request.body.to_json}"
      )

      HTTP.timeout(@config.timeout).request(verb, url, json: request.body)
    end

    def build_request(payload = nil)
      Request.new(auth: @config.auth, app: @config.app, payload: payload)
    end

    def url(action)
      [@config.url, action].join('/')
    end
  end
end
