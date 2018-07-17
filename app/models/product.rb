class Product < ApplicationRecord
	belongs_to :user
	belongs_to :buyer, class_name: 'User', optional: true

	validate :check_buyer


	def check_buyer
		errors.add(:user, " can't buy own product") if user_id == buyer_id
	end
end
