class User < ActiveRecord::Base
	authenticates_with_sorcery!
	validates :password, length: { minimum: 3 }, if: :password_changed?
  	validates_confirmation_of :password
  	validates :password_confirmation, presence: true, if: :password_changed?
  	validates :password, presence: true, if: :password_changed?
  	validates :email, uniqueness: true
	validates :lastname, :email, presence: true


	def password_changed?
		new_record? || password.present?
	end
end