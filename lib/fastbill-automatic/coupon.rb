module Fastbill
  module Automatic
    class Coupon < Base

      attr_reader :code, :title, :discount, :discount_period, :valid_from, :valid_to, :assigned_articles

      def self.create(attributes)
        raise FastbillError.new('Create method not implemented.')
      end
    end
  end
end