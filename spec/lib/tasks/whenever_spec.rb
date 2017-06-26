require 'rails_helper'
require 'whenever'

describe 'task' do
  	it 'makes sure `runner` statements exist' do
		whenever = Whenever::JobList.new(file: Rails.root.join("config", "schedule.rb").to_s)
   		 expect(whenever).to schedule_rake("currency:seed")
      .every(:day)
      .at("1am")
  end
end

