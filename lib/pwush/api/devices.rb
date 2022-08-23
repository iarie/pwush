# frozen_string_literal: true

module Pwush
  module Api
    module Devices
      def register_device(params)
        post(:registerDevice, params)
      end

      def unregister_device(hwid)
        post(:unregisterDevice, hwid: hwid)
      end

      def create_test_device(params)
        post(:createTestDevice, params)
      end

      def list_test_devices
        post(:listTestDevices)
      end

      def set_badge(hwid, badge)
        post(:setBadge, hwid: hwid, badge: badge)
      end

      def application_open(hwid)
        post(:applicationOpen, hwid: hwid)
      end

      def push_stat(hwid, hash_tag = nil)
        post(:pushStat, hwid: hwid, hash: hash_tag)
      end

      def message_delivery_event(hwid, hash_tag = nil)
        post(:messageDeliveryEvent, hwid: hwid, hash: hash_tag)
      end

      def set_purchase(hwid, params = {})
        post(:setPurchase, params.merge(hwid: hwid))
      end
    end
  end
end
