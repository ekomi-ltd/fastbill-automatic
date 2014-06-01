require "spec_helper"

include Fastbill::Automatic

describe Fastbill::Automatic do


  context "delivery method is :test" do

    before do
      Fastbill::Automatic.request_method = :test
    end

    after do 
      Fastbill::Automatic.request_method = :https
    end

    it "must not perform the actual request" do
      Request::Base.any_instance.should_not_receive(:perform) do
        Fastbill::Automatic.request('subscription.usage', {})
      end
    end

    it "must store the request" do
        Fastbill::Automatic.request('service.request', {number: 'one'})
        Fastbill::Automatic.request('service.request', {number: 'two'})
        Fastbill::Automatic::Base.request_infos.should eq [
        Request::Info.new('service.request', number: 'one'),
        Request::Info.new('service.request', number: 'two')
      ]
    end
    
  end

end
