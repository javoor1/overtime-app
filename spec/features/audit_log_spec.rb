require 'rails_helper'

describe 'AuditLog Feauture' do
	
	describe 'index' do 
		before do
			FactoryGirl.create(:audit_log)
			admin_user = FactoryGirl.create(:admin_user)
      login_as(admin_user, :scope => :user)
		end	
		it 'can be reached successfully' do
			visit audit_logs_path
	    expect(page.status_code).to eq(200)
	  end

	  it 'renders audit log content' do 
	  	visit audit_logs_path
	  	# byebug
	  	expect(page).to have_content(/JON/)
	  end
	end
end



