module Fastbill
  module Automatic
    class Subscription < Base
      include Fastbill::Automatic::Services::Update
      include Fastbill::Automatic::Services::Changearticle
      include Fastbill::Automatic::Services::Setaddon
      include Fastbill::Automatic::Services::Setusagedata
      include Fastbill::Automatic::Services::Cancel
      include Fastbill::Automatic::Services::Getupcomingamount

      attr_accessor :subscription_id, :customer_id, :subscription_ext_uid, :article_number, :customer_id,
                    :coupon, :title, :unit_price, :currency_code, :next_event, :quantity, :description,
                    :usage_date
    end
  end
end