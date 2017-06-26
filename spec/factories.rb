FactoryGirl.define do
  factory :currency do
    currency_type Currency.currency_types.values.sample
    value 1.5
    date "2017-06-18"
  end
end
