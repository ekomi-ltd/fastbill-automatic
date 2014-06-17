module Fastbill
  module Automatic
    class Base
      include Fastbill::Automatic::Services::Get
      include Fastbill::Automatic::Services::Create

      attr_accessor :attributes

      @@request_infos = []

      def self.request_infos 
        @@request_infos
      end

      def self.request_infos=(info_array)
        @@request_infos = info_array
      end

      def self.clear_request_infos 
        @@request_infos = []
      end

      def initialize(attributes = {})
        self.attributes = attributes
        set_attributes(attributes)
      end

      def set_attributes(attributes)
        attributes.each_pair do |key, value|
          instance_variable_set("@#{key.downcase}", value)
        end
      end
    end
  end
end
