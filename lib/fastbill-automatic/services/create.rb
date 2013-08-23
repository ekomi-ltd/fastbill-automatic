module Fastbill
  module Automatic
    module Services
      module Create
        module ClassMethods

          def create(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.create", attributes)
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
