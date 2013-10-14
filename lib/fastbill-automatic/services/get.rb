module Fastbill
  module Automatic
    module Services
      module Get
        module ClassMethods
          attr_reader :response
          
          def get(options = {})
            response = Fastbill::Automatic.request("#{self.name.split("::").last.downcase}.get", options)
            results_from(response)
          end

          private
          def results_from(response)
            results = []
            response["RESPONSE"]["#{self.name.split("::").last.upcase}S"].each do |obj|
              results << self.new(obj)
            end
            results
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end