require "spec_helper"

describe Fastbill::Automatic::UsageData do

  let(:valid_attributes) do
    {
      subscription_id: "294282",
      customer_id: "672782",
      article_number: "2458",
      unit_price: '6.0000',
      description: "Standardtermin",
      currency_code: "EUR",
      status: "open",
      usage_date: "2014-06-26 14:46:19",
      created: "2014-06-26 14:46:19",
      quantity: "1"
    }
  end

  let (:usage_data) do
    Fastbill::Automatic::UsageData.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      usage_data.customer_id.should eql('672782')
      usage_data.subscription_id.should eql('294282')
      usage_data.article_number.should eql('2458')
      usage_data.unit_price.should eql(6.0)
      usage_data.description.should eql('Standardtermin')
      usage_data.currency_code.should eql('EUR')
      usage_data.status.should eql('open')
      usage_data.usage_date.should eql(Time.local(2014,06,26,14,46,19))
      usage_data.created.should eql(Time.local(2014,6,26,14,46,19))
      usage_data.quantity.should eql(1)
    end

    it "takes care of wrongly set array on currency_code" do
      usage_data = Fastbill::Automatic::UsageData.new(:currency_code => [])
      usage_data.currency_code.should eql('')
    end

  end

  describe '#create' do

    let(:success_response) do
      {"RESPONSE" => { "STATUS" => "success"}}
    end

    let(:get_usage_params) do
      {subscription_id: '294282', start: "2014-06-26 14:46:19", end: "2014-06-26 14:46:19"}
    end

    let (:get_response) do
      {
        "RESPONSE" => { 
          "ITEMS"=>[
            {"USAGEDATA_ID"=>"345278",
             "CUSTOMER_ID"=>"285664",
             "SUBSCRIPTION_ID"=>"294282",
             "ARTICLE_NUMBER"=>"2458",
             "UNIT_PRICE"=>"6.0000",
             "DESCRIPTION"=>"Standardtermin",
             "CURRENCY_CODE"=>[],
             "STATUS"=>"open",
             "USAGE_DATE"=>"2014-06-26 14:46:19",
             "CREATED"=>"2014-06-26 15:04:36",
             "QUANTITY"=>"1"}
          ]
        }
      }
    end

    before do
      Fastbill::Automatic.should_receive(:request).with("subscription.setusagedata", valid_attributes)
      Fastbill::Automatic.should_receive(:request).with("subscription.getusagedata", get_usage_params).
        and_return(get_response)
    end

    it 'should create and then get the usagedata_id' do
      usage_data.create
      usage_data.usagedata_id.should eql('345278')
    end

  end

  describe '#where' do

    let (:empty_response) do
      {
        "RESPONSE" => {  "ITEMS"=>[] }
      }
    end

    let (:two_items_response) do
      {
        "RESPONSE" => { 
          "ITEMS"=>[
            {"USAGEDATA_ID"=>"345278",
             "CUSTOMER_ID"=>"672782",
             "SUBSCRIPTION_ID"=>"294282",
             "ARTICLE_NUMBER"=>"2458",
             "UNIT_PRICE"=>"6.0000",
             "DESCRIPTION"=>"Standardtermin",
             "CURRENCY_CODE"=>"EUR",
             "STATUS"=>"open",
             "USAGE_DATE"=>"2014-06-26 14:46:19",
             "CREATED" => "2014-06-26 14:46:19",
             "QUANTITY"=>"1"},
             {"USAGEDATA_ID"=>"345279",
              "CUSTOMER_ID"=>"672782",
              "SUBSCRIPTION_ID"=>"294282",
              "ARTICLE_NUMBER"=>"2458",
              "UNIT_PRICE"=>"15.0000",
              "DESCRIPTION"=>"Premiumtermin",
              "CURRENCY_CODE"=>"EUR",
              "STATUS"=>"open",
              "USAGE_DATE"=>"2014-06-26 14:48:19",
              "CREATED" => "2014-06-26 14:48:21",
              "QUANTITY"=>"1"}
          ]
        }
      }
    end

    let (:expected_items) do
      two_items_response["RESPONSE"]["ITEMS"].map do |item_attributes|
        init_hash = Hash[*item_attributes.map{|k,v| [k.downcase.to_sym, v]}.flatten]
        Fastbill::Automatic::UsageData.new(init_hash)
      end
    end

    context 'no usage data' do

      before do
        Fastbill::Automatic.should_receive(:request).with("subscription.getusagedata", {
          subscription_id: '294282'}).and_return(empty_response)
      end

      it 'returns an empty array' do
        Fastbill::Automatic::UsageData.where(:subscription_id => '294282').should eq []
      end

    end

    context 'usage data' do

      before do
        Fastbill::Automatic.should_receive(:request).with("subscription.getusagedata", {
          subscription_id: '294282'}).and_return(two_items_response)
      end

      it 'returns an empty array' do
        Fastbill::Automatic::UsageData.where(:subscription_id => '294282').should eq(expected_items)
      end

    end


  end

  describe '#find_by_usage_date' do

    let(:existing_usagedata) do
      valid_attributes.merge(:usagedata_id => "345278") 
    end


    def default_response_hash(currency_code = "EUR")
      {
        "RESPONSE" => { 
          "ITEMS"=>[
            {"USAGEDATA_ID"=>"345278",
             "CUSTOMER_ID"=>"672782",
             "SUBSCRIPTION_ID"=>"294282",
             "ARTICLE_NUMBER"=>"2458",
             "UNIT_PRICE"=>"6.0000",
             "DESCRIPTION"=>"Standardtermin",
             "CURRENCY_CODE"=>currency_code,
             "STATUS"=>"open",
             "USAGE_DATE"=>"2014-06-26 14:46:19",
             "CREATED" => "2014-06-26 14:46:19",
             "QUANTITY"=>"1"}
          ]
        }
      }
    end

    let (:unsuccessful_response) do
      {
        "RESPONSE" => { "ITEMS"=>[] }
      }
    end

    let (:successful_response) { default_response_hash }
    let (:successful_response_without_currency) { default_response_hash([]) }


    context 'no currency code in reponse' do

      it 'doesnt fail with array value instead of currency code' do

        Fastbill::Automatic.should_receive(:request).with("subscription.getusagedata", {
          subscription_id: '294282',
          start:"2014-06-26 14:46:19",
          end: "2014-06-26 14:46:19" }).and_return(successful_response_without_currency)

        existing_item = Fastbill::Automatic::UsageData.new(existing_usagedata)
        usage_item = Fastbill::Automatic::UsageData.find_by_usage_date(existing_usagedata[:subscription_id], Time.local(2014,6,26,14,46,19))
        usage_item.currency_code.should eql('')
      end

    end

    context 'there exists a booking at that date' do

      before do
        Fastbill::Automatic.should_receive(:request).with("subscription.getusagedata", {
          subscription_id: '294282',
          start:"2014-06-26 14:46:19",
          end: "2014-06-26 14:46:19" }).and_return(successful_response)
      end

      it 'finds the corresponding usage booking by date' do
        existing_item = Fastbill::Automatic::UsageData.new(existing_usagedata)
        usage_item = Fastbill::Automatic::UsageData.find_by_usage_date(existing_usagedata[:subscription_id], Time.local(2014,6,26,14,46,19))
        usage_item.should eq Fastbill::Automatic::UsageData.new(existing_usagedata)
      end
    end

    context 'there does not exists a booking at that date' do

      before do
        Fastbill::Automatic.should_receive(:request).with("subscription.getusagedata", {
          subscription_id: 'invalid_subscription_id',
          start:"2014-06-26 14:46:20",
          end: "2014-06-26 14:46:20" }).and_return(unsuccessful_response)
      end

      it 'should return nil'  do
        usage_item = Fastbill::Automatic::UsageData.find_by_usage_date(
          'invalid_subscription_id', Time.local(2014,6,26,14,46,20))
        expect(usage_item).to be_nil
      end
    end

  end

  describe '#update_attributes' do

    let (:existing_usage_item) do
      Fastbill::Automatic::UsageData.new(valid_attributes.merge(usagedata_id: "345278"))
    end

    let (:delete_params) do
      { usagedata_id: '345278' }
    end

    let(:update_params) do
      valid_attributes.merge( {
        article_number: "2459",
        unit_price: '26',
        description: "Premiumtermin"
      })
    end

    let(:get_params) do
      {subscription_id: '294282', start: "2014-06-26 14:46:19", end: "2014-06-26 14:46:19"}
    end

    let(:success_response) do
      {"RESPONSE" => { "STATUS" => "success"}}
    end

    let (:get_response) do
      {
        "RESPONSE" => {
          "ITEMS"=>[
            {"USAGEDATA_ID"=>"345279",
             "CUSTOMER_ID"=>"672782",
             "SUBSCRIPTION_ID"=>"294282",
             "ARTICLE_NUMBER"=>"2459",
             "UNIT_PRICE"=>"26.0000",
             "DESCRIPTION"=>"Premiumtermin",
             "CURRENCY_CODE"=>"EUR",
             "STATUS"=>"open",
             "USAGE_DATE"=>"2014-06-26 14:46:19",
             "CREATED" => "2014-06-26 14:56:19",
             "QUANTITY"=>"1"}
          ]
        }
      }
    end

    before do
      Fastbill::Automatic.should_receive(:request).with("subscription.deleteusagedata", delete_params).
        and_return(success_response)
      Fastbill::Automatic.should_receive(:request).with("subscription.setusagedata", update_params).
        and_return(success_response)
      Fastbill::Automatic.should_receive(:request).with("subscription.getusagedata", get_params).
        and_return(get_response)
    end

    it 'allows updating attributes in a familiar manner' do
      existing_usage_item.update_attributes(unit_price: 26, article_number: '2459', description: 'Premiumtermin')
      existing_usage_item.unit_price.should eq(26)
      existing_usage_item.article_number.should eql('2459')
      existing_usage_item.description.should eql('Premiumtermin')
      existing_usage_item.usagedata_id.should eql('345279')
    end

  end

  describe '#delete' do

    let (:usage_data_from_fastbill) do
      Fastbill::Automatic::UsageData.new(valid_attributes.merge(usagedata_id: '123456'))
    end

    let (:delete_params) do
      { usagedata_id: '123456' }
    end

    let(:success_response) do
      {"RESPONSE" => { "STATUS" => "success"}}
    end

    before do
      Fastbill::Automatic.should_receive(:request).with("subscription.deleteusagedata", delete_params).
        and_return(success_response)
    end

    it 'should delete usage data by id' do
      usage_data_from_fastbill.delete
    end

  end

end
