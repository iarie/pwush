module Pwush
  class Request
    attr_reader :body

    def initialize(auth:, app:, payload: nil)
      @auth    = auth
      @app     = app
      @payload = payload || {}
      @body    = build_body(@payload)
    end

    def to_json
      Oj.dump(body)
    end

    private

    def build_body(payload)
      { request: payload.merge(auth: @auth, application: @app) }
    end
  end
end
