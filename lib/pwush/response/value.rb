module Pwush
  module Response
    class Value < Dry::Struct::Value
      constructor_type :strict

      attribute :status_code, Types::Coercible::Int
      attribute :status_message, Types::Strict::String.optional
      attribute :body, (Types::Hash | Types::String).optional
    end
  end
end
