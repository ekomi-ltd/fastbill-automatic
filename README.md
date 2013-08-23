Fastbill Automatic
==================

This is a Ruby wrapper for FastBill's Automatic API based on API-Documentation v1.6 (21.08.2013)

Usage
======

First, you've to install the gem

    gem 'fastbill-automatic', git: 'git://github.com/reputami/fastbill-automatic.git', tag: 'v0.0.1'

and require it

    require "fastbill-automatic"

Then you have to set your Email Adress & API key:

    Fastbill::Automatic.api_key = "your-api-key"
    Fastbill::Automatic.email = "your-email-adress"

Article
-------

Find existing articles (see API limits):

    Fastbill::Automatic::Article.get()

    Due to the API implementation the result is an array.

Coupon
------

Find existing coupons (see API limits):

    Fastbill::Automatic::Coupon.get()

    Due to the API implementation the result is an array.

Customer
--------

Creating a new customer:

    Fastbill::Automatic::Customer.create(customer_type: 'business', organization: 'Company name', country_code: 'DE', payment_type: 1)

Find existing customers (see API limits):

    Fastbill::Automatic::Customer.get(customer_id: "123456") # With filters
    Fastbill::Automatic::Customer.get() # Without filters

    Due to the API implementation the result in both cases is an array.

Updating an existing customer only works on an instance:

    customer = Fastbill::Automatic::Customer.get(customer_id: "123456").first
    customer.update_attributes(first_name: 'Max', last_name: 'Mustermann')

Deleting a customer:

    Fastbill::Automatic::Customer.delete("123456")

Subscription
------------

Creating a new subscription:

    Fastbill::Automatic::Subscription.create(article_number: '123', customer_id: '123456')

Find existing subscriptions (see API limits):

    Fastbill::Automatic::Subscription.get(customer_id: '123456') # With filter
    Fastbill::Automatic::Subscription.get(subscription_id: '1234') # # With filter
    Fastbill::Automatic::Subscription.get() # Without filters

    Due to the API implementation the result in both cases is an array.

Updating an existing subscription only works on an instance:

    subscription = Fastbill::Automatic::Subscription.get(subscription_id: "123456").first
    subscription.update_attributes(next_event: '2013-07-10')

Changing an article for a given subscription:

    Fastbill::Automatic::Subscription.changearticle(subscription_id: '1234', article_number: '123')

Create new addon for a given subscription:

    Fastbill::Automatic::Subscription.setaddon(subscription_id: '1234', article_number: '123', quantity: '10')

    API Bug! => (Subscription Error: Missing / invalid field: ARTICLE_NUMBER)

Set usage data for given subscription:

    Fastbill::Automatic::Subscription.setusagedata(subscription_id: '1234', article_number: '123', quantity: '10')

Cancel a subscription:

    Fastbill::Subscription.cancel('1234')

Invoice
-------

Creating a new invoice:

    item = {description: 'Some info text', unit_price: '60.00', vat_percent: '19.00'}
    items = (Array.new << item)

    Fastbill::Automatic::Invoice.create(customer_id: '123456', items: items)

Find existing invoices (see API limits):

    Fastbill::Automatic::Invoive.get(invoice_id: '123456') # With filter
    Fastbill::Automatic::Invoive.get(customer_id: '123456') # # With filter
    Fastbill::Automatic::Invoive.get() # Without filters

    Due to the API implementation the result in both cases is an array.

Updating an existing invoice only works on an instance:

    invoice = Fastbill::Automatic::Invoice.get(invoice_id: '123456').first
    invoice.update_attributes(currency_code: 'USD', introtext: 'Some intro text')

Deleting an invoice (type needs to be 'draft'):

    Fastbill::Automatic::Invoice.delete('123456')

Complete an invoice (type needs to be 'draft'):

    Fastbill::Automatic::Invoice.complete('123456')

Cancel an invoice (type needs to be 'draft'):

    Fastbill::Automatic::Invoice.cancel('123456')

Sign and invoice:

    Fastbill::Automatic::Invoice.sign('123456')

Send invoice via email:

    Fastbill::Automatic::Invoice.sendbyemail(invoice_id: '123456', recipient: { to: 'info@example.com', cc: 'support@example.com' }, subject: 'Some subject text', message: 'Some message text')

Send invoice by post:

    Fastbill::Automatic::Invoice.sendbypost('123456')

Set invoice as paid:

    Fastbill::Automatic::Invoice.setpaid(invoice_id: '123456', paid_date: '2013-03-05')

Item
----

Find existing items (see API limits):

    Fastbill::Automatic::Item.get(invoice_id: '123456') # With filter
    Fastbill::Automatic::Item.get() # Without filters

    Due to the API implementation the result in both cases is an array.

Deleting an item:

    Fastbill::Automatic::Item.delete('123456')

Template
--------

Find existing templates (see API limits):

    Fastbill::Automatic::Template.get()

    Due to the API implementation the result is an array.
