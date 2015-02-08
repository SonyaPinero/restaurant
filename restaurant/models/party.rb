class Party < ActiveRecord::Base 
	belongs_to :employee
	has_many :orders
	has_many :foods, through: :orders
end