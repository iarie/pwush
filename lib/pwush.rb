# frozen_string_literal: true

require 'pwush/config'

require 'pwush/types'
require 'pwush/message'

require 'pwush/response'
require 'pwush/request'

require 'pwush/client'

module Pwush
  def self.new(options)
    Client.new(options)
  end
end
