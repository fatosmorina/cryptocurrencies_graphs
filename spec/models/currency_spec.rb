require 'rails_helper'

RSpec.describe Currency, type: :model do
	it { should validate_presence_of(:date) }
	it { should validate_presence_of(:value) }
	it { should validate_presence_of(:type) }

	it 'should throw error for invalid value of type' do
		expect { build(:currency, type: "invalid") }.to raise_error(ArgumentError).with_message(/is not a valid type/)
	end
end

