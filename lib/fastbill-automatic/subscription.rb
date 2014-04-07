module Fastbill
  module Automatic
    class Subscription < Base
      include Fastbill::Automatic::Services::Update
      include Fastbill::Automatic::Services::Changearticle
      include Fastbill::Automatic::Services::Setaddon
      include Fastbill::Automatic::Services::Setusagedata
      include Fastbill::Automatic::Services::Cancel

      attr_accessor :subscription_id, :customer_id, :start, :next_event, :cancellation_date, :status,
                    :hash, :x_attributes, :article_number, :subscription_ext_uid, :invoice_title, :last_event,
                    :addons, :expiration_date
    end
  end
end