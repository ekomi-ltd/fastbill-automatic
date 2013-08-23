module Fastbill
  module Automatic
    module Services
      module Setpaid
        module ClassMethods

          def setpaid(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.setpaid", attributes)
            self.new(response["RESPONSE"])
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end