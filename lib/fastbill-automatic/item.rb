module Fastbill
  module Automatic
    class Item < Base
      include Fastbill::Automatic::Services::DeleteItem

      attr_accessor :invoice_id, :invoice_item_id, :article_number, :description,
                    :quantity, :unit_price, :vat_percent, :sort_order
    end
  end
end