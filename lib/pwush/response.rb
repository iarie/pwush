require 'dry-monads'

require 'pwush/response/deffered'
require 'pwush/response/value'

module Pwush
  module Response
    def self.wrap
      Deffered.new(yield).resolve
    rescue Http::TimeoutError => e
      Failure.new(e)
    end

    class Success < Dry::Monads::Success; end
    class Failure < Dry::Monads::Failure; end
  end
end
