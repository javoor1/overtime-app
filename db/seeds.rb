@user = User.create(email: "test@test.com", password: "123123", password_confirmation: "123123", first_name: "John", last_name: "Snow")
puts "1 User created"

100.times do |post|
	Post.create(date: Date.today, rationale: " #{post} content", user_id: @user.id)
end

puts "100 posts have been created"