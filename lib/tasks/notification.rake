namespace :notification do
  desc "Sends sms notification for employees asking them to log their overtime"
  task sms: :environment do
  	puts 'this is a rake task'
  end

end
