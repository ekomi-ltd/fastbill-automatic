module Fastbill
  module Automatic
    module Services
      module Changearticle
        module ClassMethods

          def changearticle(attributes)
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.changearticle", attributes)
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