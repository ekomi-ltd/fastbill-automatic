module Fastbill
  module Automatic
    module Services
      module Sendbyemail
        module ClassMethods

          def sendbyemail(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.sendbyemail", attributes)
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