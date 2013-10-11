module Fastbill
  module Automatic
    class Customer < Base
      include Fastbill::Automatic::Services::Update
      include Fastbill::Automatic::Services::Delete

      attr_accessor :customer_number, :country_code, :city, :term, :comment, :changedata_url, :paymill_token,
                    :customer_ext_uid, :customer_type, :organization, :position, :salutation, :first_name, :last_name,
                    :address, :address_2, :zipcode, :phone, :phone_2, :fax, :mobile, :email, :account_receivable, :currency_code,
                    :vat_id, :days_for_payment, :payment_type, :show_payment_notice, :bank_name, :bank_code, :bank_account_number,
                    :bank_account_owner, :newsletter_optin, :language_code

      attr_reader   :customer_id, :dashboard_url, :changedata_url, :status
    end
  end
end
