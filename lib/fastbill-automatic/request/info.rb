module Fastbill
  module Automatic
    module Request
      class Info
        attr_accessor :service, :data

        def ==(other)
          @service == other.service && @data == other.data
        end

        def initialize(service, data)
          @service = service
          @data    = data
        end

        def url
          url = "/api/#{API_VERSION}/api.php"
          url
        end

        def path_with_params(path, params)
          unless params.empty?
            encoded_params = URI.encode_www_form(params)
            [path, encoded_params].join("?")
          else
            path
          end
        end
      end
    end
  end
end
