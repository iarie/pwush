module Pwush
  module Response
    class Deffered
      include Dry::Monads::Result::Mixin

      def initialize(raw_result)
        @_raw_result = raw_result
      end

      def resolve
        return http_request_failure if raw_result.status != 200
        return api_request_failure if value_from_api.status_code != 200
        api_request_succesful
      end

      private

      def http_request_failure
        Failure.new(value_from_http)
      end

      def api_request_failure
        Failure.new(value_from_api)
      end

      def api_request_succesful
        Success.new(value_from_api)
      end

      def raw_result
        @_raw_result
      end

      def parsed_result
        @_parsed_result ||= raw_result.parse
      end

      def value_from_http
        @_value_from_http ||= Value.new(
          status_code: raw_result.status,
          status_message: raw_result.reason,
          body: nil
        )
      end

      def value_from_api
        @_value_from_api ||= Value.new(
          status_code:    parsed_result['status_code'],
          status_message: parsed_result['status_message'],
          body:           parsed_result['response']
        )
      end
    end
  end
end
