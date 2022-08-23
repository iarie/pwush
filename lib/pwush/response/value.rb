module Pwush
  module Response
    class Value < Dry::Struct
      attribute :status_code, Types::Coercible::Integer
      attribute? :status_message, Types::Strict::String
      attribute? :body, (Types::Hash | Types::String).optional
    end
  end
end
