require "spec_helper"

describe Fastbill::Automatic::Subscription do

  let(:valid_attributes) do
    {
     subscription_id: 285664,
     subscription_ext_uid: "",
     hash: "178cdae035d59c637318bf808e78bad3",
     article_code: "1004",
     quantity: "1",
     start_date: "2014-06-16 16:07:57",
     last_event: "2014-06-16 16:07:58",
     next_event: "2014-06-17 16:07:58",
     cancellation_date: "0000-00-00 00:00:00",
     status: "trial",
     expiration_date: "2014-06-17 16:07:58",
     addons: [{article_code: "2101", quantity: "1"}, {article_code: "2001", quantity: "1"}],
     created: "2014-06-16 16:07:59"
    }

  end

  let (:subscription) do
    Fastbill::Automatic::Subscription.new(valid_attributes)
  end

  describe "#initialize" do

    it "initializes all attributes correctly" do
      subscription.subscription_id.should eql(285664)
      subscription.subscription_ext_uid.should eql("")
      subscription.article_code.should eql("1004")
      subscription.quantity.should eql("1")
      subscription.start_date.should eql("2014-06-16 16:07:57")
      subscription.last_event.should eql("2014-06-16 16:07:58")
      subscription.next_event.should eql("2014-06-17 16:07:58")
      subscription.cancellation_date.should eql("0000-00-00 00:00:00")
      subscription.status.should eql("trial")
      subscription.expiration_date.should eql("2014-06-17 16:07:58")
      subscription.created.should eql("2014-06-16 16:07:59")
      subscription.addons.should eql [{article_code: "2101", quantity: "1"}, {article_code: "2001", quantity: "1"}] 
    end

    it 'should not overwrite the hash method' do
      subscription.hash.class.should eql Fixnum
    end

  end

  describe ".attributes" do
    it "makes all attributes accessible by hash" do
      subscription.attributes.should eql(valid_attributes)
      subscription.attributes[:hash].should eql("178cdae035d59c637318bf808e78bad3")
    end
  end

end



