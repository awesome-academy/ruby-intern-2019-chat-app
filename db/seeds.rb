User.create!(name: "Thái Thị Tiến",
             username: "thaitien",
             email: "thaithitien1997@gmail.com",
             password: "12345678",
             gender: 2,
             avatar: "avatar_default.png",
             birthday: "25/06/1997",
             password_confirmation: "12345678")
User.create!(name: "Nguyen Ba Hung",
             username: "bahung",
             email: "hungpronguyen256@gmail.com",
             password: "12345678",
             gender: 1,
             avatar: "avatar_default.png",
             birthday: "25/06/1997",
             password_confirmation: "12345678",
             admin: true)
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               username: "bahung-#{n}",
               email: email,
               password: password,
               gender: 1,
               avatar: "avatar_default.png",
               birthday: "25/06/1997",
               password_confirmation: password)
end

Contact.create user_id_1: 2, user_id_2: 1, status: 2
Contact.create user_id_1: 3, user_id_2: 1, status: 2
Contact.create user_id_1: 4, user_id_2: 1, status: 2

Contact.create user_id_1: 2, user_id_2: 3, status: 2
Contact.create user_id_1: 2, user_id_2: 4, status: 2

Contact.create user_id_1: 3, user_id_2: 2, status: 2
Contact.create user_id_1: 4, user_id_2: 2, status: 2

r = Room.create owner_id: 1, kind: 0, name: "Nguyen Quynh"
c = r.user_rooms.build user_id: 2, admin: false
c.save

r = Room.create owner_id: 1, kind: 0, name: "Nguyen Hang"
c = r.user_rooms.build user_id: 3, admin: false
c.save

r = Room.create owner_id: 1, kind: 0, name: "Dao Cong Chinh"
c = r.user_rooms.build user_id: 4, admin: false
c.save

r = Room.create owner_id: 2, kind: 0, name: "Liem Thanh Khiet"
c= r.user_rooms.build user_id: 3, admin: false
c.save

r = Room.create owner_id: 2, kind: 0, name: "Nguyen Ngoc Ngan"
c = r.user_rooms.build user_id: 4, admin: false
c.save

