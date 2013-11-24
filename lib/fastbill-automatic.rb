require "net/http"
require "net/https"
require "json"
require "fastbill-automatic/version"

module Fastbill
  module Automatic
    API_BASE    = "automatic.fastbill.com"
    API_VERSION = "1.0"
    ROOT_PATH   = File.dirname(__FILE__)

    @@api_key = nil
    @@email = nil

    autoload :Base,         "fastbill-automatic/base"
    autoload :Customer,     "fastbill-automatic/customer"
    autoload :Invoice,      "fastbill-automatic/invoice"
    autoload :Item,         "fastbill-automatic/item"
    autoload :Subscription, "fastbill-automatic/subscription"
    autoload :Template,     "fastbill-automatic/template"
    autoload :Article,      "fastbill-automatic/article"
    autoload :Coupon,       "fastbill-automatic/coupon"

    module Services
      autoload :Get,           "fastbill-automatic/services/get"
      autoload :Create,        "fastbill-automatic/services/create"
      autoload :Update,        "fastbill-automatic/services/update"
      autoload :Delete,        "fastbill-automatic/services/delete"
      autoload :DeleteItem,    "fastbill-automatic/services/delete_item"
      autoload :Cancel,        "fastbill-automatic/services/cancel"
      autoload :Changearticle, "fastbill-automatic/services/changearticle"
      autoload :Complete,      "fastbill-automatic/services/complete"
      autoload :Sign,          "fastbill-automatic/services/sign"
      autoload :Sendbyemail,   "fastbill-automatic/services/sendbyemail"
      autoload :Sendbypost,    "fastbill-automatic/services/sendbypost"
      autoload :Setaddon,      "fastbill-automatic/services/setaddon"
      autoload :Setpaid,       "fastbill-automatic/services/setpaid"
      autoload :Setusagedata,  "fastbill-automatic/services/setusagedata"
      autoload :Getupcomingamount,  "fastbill-automatic/services/getupcomingamount"
    end

    module Request
      autoload :Base,       "fastbill-automatic/request/base"
      autoload :Connection, "fastbill-automatic/request/connection"
      autoload :Info,       "fastbill-automatic/request/info"
      autoload :Validator,  "fastbill-automatic/request/validator"
    end

    class FastbillError < StandardError; end
    class AuthenticationError < FastbillError; end
    class APIError < FastbillError; end

    def self.api_key
      @@api_key
    end

    def self.api_key=(api_key)
      @@api_key = api_key
    end

    def self.email
      @@email
    end

    def self.email=(email)
      @@email = email
    end

    def self.request(service, data)
      info = Request::Info.new(service, data)
      Request::Base.new(info).perform
    end
  end
end
