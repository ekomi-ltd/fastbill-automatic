require "spec_helper"

describe Fastbill::Automatic::Customer do
  
  let(:valid_attributes) do
    { customer_number: "5", customer_ext_uid: "", days_for_payment: "14", payment_type: "1", show_payment_notice: "1",
      customer_type: "consumer", organization: "Server Hosting GmbH", salutation: "mr", first_name: "Klaus",
      last_name: "Testkunde", address: "Test Strasse 41", zipcode: "26123", city: "Oldenburg", phone: "049 123 456 789",
      fax: "049 123 456 987", email: "support@fastbill.com", paymill_token: "", comment: ""
    }
  end

  let (:customer) do
    Fastbill::Automatic::Customer.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      customer.customer_number.should eql("5")
      customer.customer_ext_uid.should eql("")
      customer.days_for_payment.should eql("14")
      customer.payment_type.should eql("1")
      customer.show_payment_notice.should eql("1")
      customer.customer_type.should eql("consumer")
      customer.organization.should eql("Server Hosting GmbH")
      customer.salutation.should eql("mr")
      customer.first_name.should eql("Klaus")
      customer.last_name.should eql("Testkunde")
      customer.address.should eql("Test Strasse 41")
      customer.zipcode.should eql("26123")
      customer.city.should eql("Oldenburg")
      customer.phone.should eql("049 123 456 789")
      customer.fax.should eql("049 123 456 987")
      customer.email.should eql("support@fastbill.com")
      customer.paymill_token.should eql("")
      customer.comment.should eql("")
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