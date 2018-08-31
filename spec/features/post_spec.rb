require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    
  end

  describe 'index' do
    before do
      @post = FactoryGirl.create(:post)
      @second_post = FactoryGirl.create(:second_post)
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      expect(page).to have_content(/Rationale|content/)
    end

    it 'only post creator can see the post' do
      post1 = Post.create(date: Date.today, rationale: "asdf", user_id: @user.id)
      post2 = Post.create(date: Date.today, rationale: "asdf", user_id: @user.id)
      other_user = User.create(first_name: 'Non', last_name: 'Authorized', email: "nonauth@example.com", password: "asdfasdf", password_confirmation: "asdfasdf")
      post_from_other_user = Post.create(date: Date.today, rationale: "This post shouldn't be seen", user_id: other_user.id)
      visit posts_path
      expect(page).to_not have_content(/This post shouldn't be seen/)
    end
  end

  describe 'new' do
    it 'has a link from he homepage to create post' do
      visit root_path
      click_link "new_post_from_nav"
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      click_on "Save"
      expect(page).to have_content("Some rationale")
    end

    it 'will have a user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"
      click_on "Save"
      expect(User.last.posts.last.rationale).to eq("User Association")
    end   
  end

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post) #este post está creando con el user definido en factories, o sea un regular user.
      # puts "@post_id = #{@post.id}"
      @admin_user = FactoryGirl.create(:admin_user)
      @post.update(user_id: @admin_user.id)
      # puts "@admin_user = #{@admin_user.id}"
      login_as(@admin_user, scope: :user)
    end
      
    it 'edit link from post index page' do 
      visit posts_path
      click_link "edit_#{@post.id}"
      expect(page.status_code).to eq(200)
    end 

    it 'can be edited' do
      visit edit_post_path(@post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited content"
      click_on "Save"
      expect(page).to have_content("Edited content")
    end

    # it 'can not be edited by a non-authorized user' do
    #   logout(@admin_user)
    #   non_authorized_user = FactoryGirl.create(:non_authorized_user)
    #   puts "non_authorized_user_id = #{non_authorized_user.id}"
    #   puts "@post.user_id #{@post.user_id}"
    #   login_as(non_authorized_user, scope: :user)
    #   visit posts_path
    #   click_link "edit_#{@post.id}"
    #   # expect(page.reload).to_not have_content("not allowed to edit?")
    # end

  end 

  describe 'delete' do
    before do
      @admin_user = FactoryGirl.create(:admin_user)
      login_as(@admin_user, scope: :user)
      @post = FactoryGirl.create(:post)
      @post.update(user_id: @user.id)
      visit posts_path
    end

    xit 'can be deleted from index page' do
      click_link("delete_post_#{@post.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end
end


















