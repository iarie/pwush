# frozen_string_literal: true

require 'logger'

module Pwush
  MissingAuthToken = Class.new(StandardError)
  MissingAppToken = Class.new(StandardError)

  class Config
    URL = 'https://cp.pushwoosh.com/json/1.3'

    def initialize(options = {})
      @url     = options[:url]     || URL
      @auth    = options[:auth]    || auth_missing
      @app     = options[:app]     || app_missing
      @timeout = options[:timeout] || { write: 2, connect: 5, read: 10 }
      @logger  = options[:logger]  || Logger.new($stdout)
    end

    attr_accessor :auth, :url, :app, :timeout, :logger

    private

    def auth_missing
      raise(MissingAuthToken, 'please provide :auth argument')
    end

    def app_missing
      raise(MissingAppToken, 'please provide :app argument')
    end
  end
end
