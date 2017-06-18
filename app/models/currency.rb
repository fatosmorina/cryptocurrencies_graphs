class Currency < ApplicationRecord
	validates :date, presence: true
	validates :value, presence: true
	validates :type, presence: true

	enum type: [:bitcoin, :ethereum, :nasdaq]

end
