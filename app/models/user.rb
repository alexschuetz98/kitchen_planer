class User < ActiveRecord::Base

	validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  	validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  	validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }
  	validates :email, uniqueness: true
	validates :lastname, :email, presence: true
	authenticates_with_sorcery!
end