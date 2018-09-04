FactoryGirl.define do
  
  factory :post do
    date Date.today
    rationale "First Post"
    overtime_request 3.5
    user
  end

  factory :second_post, class: "Post" do
    date Date.yesterday
    rationale "Second Post"
    overtime_request 0.5
    user
  end

  factory :post_from_non_authorized_user, class: "Post" do
    date Date.yesterday
    rationale "Third Post"
    overtime_request 0.5
    non_authorized_user
  end
end
