class User < ActiveRecord::Base
	validates :lastname, :email, presence: true
end