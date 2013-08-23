module Fastbill
  module Automatic
    class Base
      include Fastbill::Automatic::Services::Get
      include Fastbill::Automatic::Services::Create

      def initialize(attributes = {})
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