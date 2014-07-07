module Fastbill
  module Automatic
    class Subscription < Base
      include Fastbill::Automatic::Services::Update
      include Fastbill::Automatic::Services::Changearticle
      include Fastbill::Automatic::Services::Setaddon
      include Fastbill::Automatic::Services::Setusagedata
      include Fastbill::Automatic::Services::Cancel

      attr_accessor :subscription_id, :customer_id, :subscription_ext_uid, :article_number, :customer_id,
                    :coupon, :title, :unit_price, :currency_code, :next_event, :quantity, :description,
                    :usage_date, :article_code, :start_date, :last_event, :cancellation_date, :status,
                    :expiration_date, :created, :addons
    end
  end
end
