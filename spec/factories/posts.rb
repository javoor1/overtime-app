FactoryGirl.define do
  
  factory :post do
    date Date.today
    rationale "First Post"
    user
  end

  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Second Post"
    user
  end

  factory :post_from_non_authorized_user, class: "Post" do
    date Date.yesterday
    rationale "Third Post"
    non_authorized_user
  end
end
