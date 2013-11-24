module Fastbill
  module Automatic
    module Services
      module Getupcomingamount
        module ClassMethods

          def getupcomingamount(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.getupcomingamount", attributes)
            (response["RESPONSE"] && response["RESPONSE"]["UNIT_PRICE"]) ? response["RESPONSE"]["UNIT_PRICE"] : nil
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end