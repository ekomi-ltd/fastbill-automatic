module Fastbill
  module Automatic
    module Services
      module Setusagedata
        module ClassMethods

          def setusagedata(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.setusagedata", attributes)
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