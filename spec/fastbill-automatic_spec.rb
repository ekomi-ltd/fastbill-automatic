require "spec_helper"

describe Fastbill::Automatic do
  describe ".request" do
    context "no api key and no email exists" do
      it "raises an authentication error" do
        expect { Fastbill::Automatic.request("Customer.get", {}) }.to raise_error(Fastbill::Automatic::AuthenticationError)
      end
    end
  end
end
