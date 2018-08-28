require 'rails_helper'


describe "Admin Dashboard nav" do

	it 'can be reached' do
		visit admin_root_path
		expect(page.status_code).to eq(200)
	end

	it 'does not allow users not signed in' do
		visit admin_root_path
		expect(current_path).to eq(new_user_session_path)
	end

	it 'cannot be reached by non admin users' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit admin_root_path
    expect(current_path).to eq(root_path)
  end

  it 'can be reached by admin users' do
    admin_user = FactoryGirl.create(:admin_user) #aquí admin_user es el tipo de user que definimos en factories.
    login_as(admin_user, :scope => :user)
    visit admin_root_path
    expect(current_path).to eq(admin_root_path)
  end

end


