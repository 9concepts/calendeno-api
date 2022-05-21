FactoryBot.define do
  factory :user do
    email { "user@calendeno.com" }
    name { "JaneDoe" }
    iss { "https://accounts.google.com" }
    image { "https://lh3.googleusercontent.com/a/AATXAJyIDHuWikzJ_TVkMA4diPjThKsvZwPmtrYrDIgC=s96-c" }
    sub { SecureRandom.uuid }
  end
end
