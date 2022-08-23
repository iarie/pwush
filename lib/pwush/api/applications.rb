# frozen_string_literal: true

module Pwush
  module Api
    module Applications
      def applications
        post(:getApplications)
      end
    end
  end
end
