require "spec_helper"

describe Fastbill::Automatic::Customer do

  let(:valid_attributes) do
    { customer_number: "5", country_code: "de", customer_ext_uid: "123456", days_for_payment: "14", payment_type: "1", show_payment_notice: "1",
      customer_type: "consumer", organization: "Server Hosting GmbH", salutation: "mr", first_name: "Klaus", account_receivable: "123456",
      last_name: "Testname", address: "Test Street 12", address_2: "Test Street 12", zipcode: "26123", city: "Oldenburg", phone: "049 123 456 789",
      phone_2: "049 123 456 789", fax: "049 123 456 987", mobile: "049 123 456 987", email: "support@fastbill.com", paymill_token: "123456", comment: "some comment",
      newsletter_optin: "1", language_code: "de", changedata_url: "https://automatic.fastbill.com/accountdata/123456/123456", currency_code: "EUR", vat_id: "123456",
      position: "test position", bank_name: "Test name", bank_code: "123456", bank_account_number: "123456", bank_account_owner: "Some Name",
      dashboard_url: "https://automatic.fastbill.com/dashboard/123456/123456", hash: "fcbab5d76170d15e86f97f644385d5e3" 
    }
  end

  let (:customer) do
    Fastbill::Automatic::Customer.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      customer.customer_number.should eql("5")
      customer.customer_ext_uid.should eql("123456")
      customer.days_for_payment.should eql("14")
      customer.payment_type.should eql("1")
      customer.show_payment_notice.should eql("1")
      customer.customer_type.should eql("consumer")
      customer.organization.should eql("Server Hosting GmbH")
      customer.salutation.should eql("mr")
      customer.first_name.should eql("Klaus")
      customer.last_name.should eql("Testname")
      customer.address.should eql("Test Street 12")
      customer.address_2.should eql("Test Street 12")
      customer.zipcode.should eql("26123")
      customer.city.should eql("Oldenburg")
      customer.phone.should eql("049 123 456 789")
      customer.phone_2.should eql("049 123 456 789")
      customer.fax.should eql("049 123 456 987")
      customer.mobile.should eql("049 123 456 987")
      customer.email.should eql("support@fastbill.com")
      customer.paymill_token.should eql("123456")
      customer.comment.should eql("some comment")
      customer.newsletter_optin.should eql("1")
      customer.language_code.should eql("de")
      customer.country_code.should eql("de")
      customer.changedata_url.should eql("https://automatic.fastbill.com/accountdata/123456/123456")
      customer.dashboard_url.should eql("https://automatic.fastbill.com/dashboard/123456/123456")
      customer.position.should eql("test position")
      customer.account_receivable.should eql("123456")
      customer.vat_id.should eql("123456")
      customer.currency_code.should eql("EUR")
      customer.bank_name.should eql("Test name")
      customer.bank_code.should eql("123456")
      customer.bank_account_number.should eql("123456")
      customer.bank_account_owner.should eql("Some Name")
    end

    it 'should not overwrite the hash method' do
      customer.hash.class.should eql Fixnum
    end

  end

  describe ".attributes" do
    it "makes all attributes accessible by hash" do
      customer.attributes.should eql(valid_attributes)
      customer.attributes[:hash].should eql("fcbab5d76170d15e86f97f644385d5e3")
    end
  end

  describe ".get" do
    it "gets a specific customer" do
      Fastbill::Automatic.should_receive(:request).with("customer.get", {customer_id: "123456"}).and_return("RESPONSE" => { "CUSTOMERS" => {}})
      Fastbill::Automatic::Customer.get(customer_id: "123456")
    end
  end

  describe ".delete" do
    it "deletes a customer" do
      Fastbill::Automatic.should_receive(:request).with("customer.delete", {customer_id: "123456"}).and_return("RESPONSE" => { "STATUS" => "success"})
      Fastbill::Automatic::Customer.delete("123456")
    end
  end

  describe ".create" do
    it "creates a customer" do
      Fastbill::Automatic.should_receive(:request).with("customer.create", valid_attributes).and_return("RESPONSE" => { "STATUS" => "success", "CUSTOMER_ID" => "123456"})
      Fastbill::Automatic::Customer.create(valid_attributes)
    end
  end

  describe "#update_attributes" do
    it "update customer" do
      tmp_customer = Fastbill::Automatic::Customer.new(customer_id: "123456")
      Fastbill::Automatic.should_receive(:request).with("customer.update", {:email => "some_name@exmaple.com", customer_id: "123456"}).and_return("RESPONSE" => { "STATUS" => "success"})
      
      tmp_customer.update_attributes({:email => "some_name@exmaple.com"})
    end
  end
end
