module Fastbill
  module Automatic
    class UsageData < Base

      ATTRIBUTES = [
        :subscription_id,
        :customer_id,
        :article_number,
        :unit_price,
        :description,
        :currency_code,
        :status,
        :usage_date,
        :created,
        :quantity,
        :usagedata_id
      ]

      attr_accessor *ATTRIBUTES

      def attributes
        Hash[*ATTRIBUTES.map{|a| [a, instance_variable_get("@#{a}")]}.flatten]
      end

      def unit_price
        @unit_price.to_f
      end

      def usage_date
        Time.parse(@usage_date)
      end

      def created
        Time.parse(@created)
      end

      def quantity
        @quantity.to_i
      end

      def currency_code
        if @currency_code.is_a?(Array) 
          @currency_code.join('')
        else
          @currency_code.to_s
        end
      end

      def create
        save
        self
      end

      def delete
        UsageData.deleteusagedata(delete_params)
      end

      def update_attributes(attributes)
        initialize(UsageData.prepare_attributes(attributes.merge(attributes)))
        save
        self
      end

      def save
        UsageData.deleteusagedata(delete_params) if persisted?
        UsageData.setusagedata(set_params)

        if remote_attributes = UsageData.get_remote_attributes(get_params)
          initialize(remote_attributes)
          true
        else
          false
        end

      end

      def self.get_remote_attributes(get_params)
        response = UsageData.getusagedata(get_params)
        item_attributes = response['RESPONSE']['ITEMS'].last
        item_attributes
      end


      def self.find_by_usage_date(subscription_id, time)
        time = time.strftime("%Y-%m-%d %H:%M:%S")
        result = getusagedata(subscription_id: subscription_id, start: time, end: time)

        result_items = result['RESPONSE']['ITEMS']  
        last_item_attributes = result_items ? result_items.last : nil

        if last_item_attributes

          if last_item_attributes['CURRENCY_CODE'] == []
            last_item_attributes['CURRENCY_CODE'] = ''
          end

          init_attributes =  Hash[*last_item_attributes.map{|k,v| [k.downcase.to_sym, v]}.flatten]

          self.new(init_attributes)
        end

      end

      def ==(other)
        other.attributes == self.attributes
      end

      private

      def persisted?
        if usagedata_id
          true
        else
          false
        end
      end

      def set_params
        all_attributes = attributes
        all_attributes.delete(:usagedata_id)
        all_attributes
      end

      def get_params
        {
          subscription_id: self.subscription_id,
          start: @usage_date,
          end: @usage_date
        }
      end

      def delete_params
        {
          usagedata_id: @usagedata_id
        }
      end

      class << self

        def prepare_attributes(attributes)
          Hash[*attributes.map{|k,v| [k.downcase.to_sym, v.to_s]}.flatten]
        end

        def setusagedata(set_params)
          response = Fastbill::Automatic.request("subscription.setusagedata", set_params)
        end

        def getusagedata(get_params)
          response = Fastbill::Automatic.request("subscription.getusagedata", get_params)
        end

        def deleteusagedata(delete_params)
          response = Fastbill::Automatic.request("subscription.deleteusagedata", delete_params)
        end

        def where(get_params)
          response = UsageData.getusagedata(get_params)
          result = []
          items = response['RESPONSE']['ITEMS']||[]
          items.each do|item|
            result << UsageData.new(prepare_attributes(item))
          end
          result
        end

      end

    end
  end
end
