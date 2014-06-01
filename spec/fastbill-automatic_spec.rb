require "spec_helper"

describe Fastbill::Automatic do
  describe ".request" do
    context "no api key and no email exists" do
      it "raises an authentication error" do
        expect { Fastbill::Automatic.request("Customer.get", {}) }.to raise_error(Fastbill::Automatic::AuthenticationError)
      end
    end
  end

  describe ".request_method" do

    before do
      Fastbill::Automatic.request_method = :https
    end
    after do
      Fastbill::Automatic.request_method = :https
    end

    context "supported request methods" do
      it "is set to HTTPS by default" do
        Fastbill::Automatic.request_method.should equal(:https)
      end
      it "can be set to :test" do
        Fastbill::Automatic.request_method = :test
        Fastbill::Automatic.request_method.should equal(:test)
      end
    end
    context "non supported request method" do
      it "raises an non supported error" do
        expect { Fastbill::Automatic.request_method = :test123 }.to raise_error(Fastbill::Automatic::NonSupportedRequestMethod)
      end
    end
  end

end
