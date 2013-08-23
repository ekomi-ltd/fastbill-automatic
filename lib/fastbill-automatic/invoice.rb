module Fastbill
  module Automatic
    class Invoice < Base
      include Fastbill::Automatic::Services::Update
      include Fastbill::Automatic::Services::Delete
      include Fastbill::Automatic::Services::Complete
      include Fastbill::Automatic::Services::Cancel
      include Fastbill::Automatic::Services::Sign
      include Fastbill::Automatic::Services::Sendbyemail
      include Fastbill::Automatic::Services::Sendbypost
      include Fastbill::Automatic::Services::Setpaid

      attr_accessor :invoice_id, :invoice_number, :customer_id, :month, :year, :state,
                    :type, :customer_costcenter_id, :currency_code, :template_id, :introtext,
                    :invoice_date, :delivery_date, :cash_discount_percent, :cash_discount_days,
                    :eu_delivery, :items, :delete_exiting_items, :recipient, :subject, :message,
                    :receipt_confirmation, :paid_date

      attr_reader   :remaining_credits
    end
  end
end