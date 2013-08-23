module Fastbill
  module Automatic
    module Services
      module Complete
        module ClassMethods

          def complete(id)
            id_attribute = "#{self.name.split("::").last.downcase}_id".to_sym
            attributes = {}
            attributes[id_attribute] = id
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.complete", attributes)
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
