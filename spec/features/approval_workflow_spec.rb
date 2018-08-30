require 'rails_helper'


describe "navigate" do
  before do 
    @admin_user = FactoryGirl.create(:admin_user)
    login_as(@admin_user, scope: :user)
  end

  describe "edit" do
    before do
      @post = FactoryGirl.create(:post)
    end

    it 'has a status that can be edited by an Admin' do
      visit edit_post_path(@post)
      choose('post_status_approved')
      click_on("Save")
      expect(@post.reload.status).to eq('approved') #NECESITAMOS USAR .reload para recargar la página.
    end

    it 'can not be edited by non-AdminUser' do
      logout(@admin_user)
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)
      visit edit_post_path(@post)
      expect(page).to_not have_content('post_status')
    end

  end
end
