module Fastbill
  module Automatic
    module Services
      module Setaddon
        module ClassMethods

          def setaddon(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.setaddon", attributes)
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