FactoryBot.define do
  factory :user do
    email {"hungpronguyen256@gmail.com"}
    name {"Nguyen Ba Hung"}
    username {"nguyenhung"}
    avatar {"avatar_default.png"}
    admin {"true"}
    password {"12345678"}
    password_confirmation {"12345678"}
    birthday {"25/06/1997"}
    status {1}
  end
end
