module Pwush
  module Api
    module Messages
      def create_message(*messages)
        post(:createMessage, notifications: messages.flatten)
      end
      alias push create_message

      def delete_message(message_code)
        post(:deleteMessage, message: message_code)
      end

      def message_details(message)
        post(:getMessageDetails, message: message)
      end

      def message_stats(message)
        post(:getMsgStats, message: message)
      end

      def results(request_id)
        post(:getResults,  request_id: request_id)
      end

      def preset(preset_code)
        post(:getPreset, preset_code: preset_code)
      end
    end
  end
end
