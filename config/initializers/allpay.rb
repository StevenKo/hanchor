ActiveMerchant::Billing::Integrations::Allpay.setup do |allpay|
  require "active_merchant/billing/integrations/action_view_helper"
  ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)
  if Rails.env.development?
    # default setting for stage test
    allpay.merchant_id = '2000132'
    allpay.hash_key    = '5294y06JbISpM5x9'
    allpay.hash_iv     = 'v77hoKGq4kWxNNIS'
  else
    # change to yours
    allpay.merchant_id = ENV['ALLPAY_ID']
    allpay.hash_key    = ENV['ALLPAY_HASH_KEY']
    allpay.hash_iv     = ENV['ALLPAY_HASH_IV']
  end
end