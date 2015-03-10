module Fastbill
  module Automatic
    class Coupon < Base

      attr_reader :code, :title, :discount, :discount_period, :assigned_articles

      def self.create(attributes)
        raise FastbillError.new('Create method not implemented.')
      end

      def usages
        @usages.to_i
      end

      def usages_max
        @usages_max.to_i
      end

      def discount_amount
        @discount_amount.to_f
      end

      def valid_from
        Date.new *@valid_from.split("-").map(&:to_i)
      end

      def valid_to
        Date.new *@valid_to.split("-").map(&:to_i)
      end
    end
  end
end
