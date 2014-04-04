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

      attr_accessor :invoice_id, :type, :customer_id, :customer_number, :customer_costcenter_id,
                    :organization, :salutation, :first_name, :last_name, :address, :address_2,
                    :zipcode, :city, :comment, :payment_type, :days_for_payment, :bank_name, 
                    :bank_account_number, :bank_code, :bank_account_owner, :bank_iban, :bank_bic,
                    :affiliate, :country_code, :vat_id, :currency_code, :template_id, :subscription_id,
                    :subscription_invoice_counter, :invoice_number, :invoice_title, :introtext, :paid_date,
                    :is_canceled, :invoice_date, :due_date, :delivery_date, :cash_discount_percent, :cash_discount_days,
                    :sub_total, :vat_total, :vat_items, :items, :total, :payment_info, :document_url, :paypal_url

      attr_reader   :remaining_credits
    end
  end
end