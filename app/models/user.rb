class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :products_sell, class_name: 'Product', foreign_key: :user_id
  has_many :products_buy, class_name: 'Product', foreign_key: :buyer_id
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
