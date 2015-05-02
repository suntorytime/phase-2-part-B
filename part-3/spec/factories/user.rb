FactoryGirl.define do
  factory(:user) do
    username { Faker::Internet::user_name }

    factory(:user_with_password) do
      password "password"
    end

    factory(:user_with_fake_password) do
      factory :bidder
      factory :lister

      after(:build) do |this_new_user|
        assumed_attributes = ["id", "username", "created_at", "updated_at"]
        password_attribute =  this_new_user.attributes.keys.find { |attr| attr =~ /password/ } || this_new_user.attributes.keys - assumed_attributes.first
        this_new_user.send(password_attribute + "=", "some hash")
      end
    end
  end
end
