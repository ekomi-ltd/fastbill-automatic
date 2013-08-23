module Fastbill
  module Automatic
    class Template < Base
      
      attr_reader :template_id, :template_name

      def self.create(attributes)
        raise FastbillError.new('Create method not implemented.')
      end
    end
  end
end