module Fastbill
  module Automatic
    module Services
      module DeleteItem
        module ClassMethods

          def delete(id)
            attributes = {}
            attributes[:invoice_item_id] = id
            response = Fastbill::Automatic.request("item.delete", attributes)
            true
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end