module Pwush
  module Response
    class Value < Dry::Struct::Value
      attribute :status_code, Types::Coercible::Integer
      attribute :status_message, Types::Strict::String.meta(omittable: true)
      attribute :body, (Types::Hash | Types::String).meta(omittable: true)
    end
  end
end
