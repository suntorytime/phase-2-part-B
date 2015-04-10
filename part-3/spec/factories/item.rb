FactoryGirl.define do
  factory(:item) do
    title { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    condition "good"
  end
end
