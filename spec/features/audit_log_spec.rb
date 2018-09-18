require 'rails_helper'

describe 'AuditLog Feauture' do
	
	describe 'index' do 
		before do
			@admin_user = FactoryGirl.create(:admin_user)
			@non_admin_user = FactoryGirl.create(:user)
      login_as(@admin_user, :scope => :user)
			FactoryGirl.create(:audit_log)
		end	
		it 'can be reached successfully' do
			visit audit_logs_path
	    expect(page.status_code).to eq(200)
	  end

	  it 'renders audit log content' do 
	  	visit audit_logs_path
	  	expect(page).to have_content(/JON/)
	  end

	  it 'can not be accesed by non admin' do 
	  	logout(@admin_user)
	  	login_as(@non_admin_user, scope: :user)
	  	visit audit_logs_path
			expect(current_path).to eq(root_path)
	  end
	end
end
