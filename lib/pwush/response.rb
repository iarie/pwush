require 'dry/monads/result'

require 'pwush/response/deffered'
require 'pwush/response/value'

module Pwush
  module Response
    include Dry::Monads::Result::Mixin

    def self.wrap
      Deffered.new(yield).resolve
    rescue HTTP::TimeoutError => e
      Failure.new(e)
    end
  end
end
