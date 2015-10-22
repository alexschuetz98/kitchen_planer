class User < ActiveRecord::Base
	validates :lastname, :email, presence: true
	authenticates_with_sorcery!
end