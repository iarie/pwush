module Pwush
  MissingAuthToken = Class.new(StandardError)
  MissingAppToken = Class.new(StandardError)

  class Config
    URL = 'https://cp.pushwoosh.com/json/1.3'.freeze

    def initialize(options = {})
      @url  = options[:url]  || URL
      @auth = options[:auth] || auth_missing
      @app  = options[:app]  || app_missing
    end

    attr_accessor :auth, :url, :app

    private

    def auth_missing
      raise(MissingAuthToken, 'please provide :auth argument')
    end

    def app_missing
      raise(MissingAppToken, 'please provide :app argument')
    end
  end
end
