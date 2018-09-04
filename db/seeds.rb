@user = User.create(email: "test@test.com", password: "123123", password_confirmation: "123123", first_name: "John", last_name: "Snow")
puts "1 User created"

AdminUser.create(email: "admin@admin.com", password: "123123", password_confirmation: "123123", first_name: "admin", last_name: "admin")
puts "1 AdminUser created"

100.times do |post|
	Post.create(date: Date.today, rationale: " #{post} content", user_id: @user.id, overtime_request: 2.5)
end

puts "100 posts have been created"