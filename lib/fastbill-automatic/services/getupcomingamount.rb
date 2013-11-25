module Fastbill
  module Automatic
    module Services
      module Getupcomingamount
        module ClassMethods

          def getupcomingamount(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.getupcomingamount", attributes)
            (response["RESPONSE"] && response["RESPONSE"]["TOTAL"]) ? response["RESPONSE"]["TOTAL"] : nil
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end