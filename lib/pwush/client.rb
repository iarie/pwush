require 'http'

module Pwush
  class Client
    def initialize(options)
      @config = Config.new(options)
    end

    def create_message(*messages)
      post(:createMessage, notifications: messages)
    end
    alias push create_message

    def message_details(message)
      post(:getMessageDetails, message: message)
    end

    # enterprise api
    def message_stats(message)
      post(:getMsgStats, message: message)
    end

    # enterprise api
    def results(request_id)
      post(:getResults,  request_id: request_id)
    end

    # enterprise api
    def applications
      post(:getApplications)
    end

    # enterprise api
    def preset(preset_code)
      post(:getPreset, preset_code: preset_code)
    end

    def fail
      post(:someshit, shit: 'crap')
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
      Http.request(verb, url(action), json: build_request(payload).body)
    end

    def build_request(payload = nil)
      Request.new(auth: @config.auth, app: @config.app, payload: payload)
    end

    def url(action)
      [@config.url, action].join('/')
    end
  end
end
