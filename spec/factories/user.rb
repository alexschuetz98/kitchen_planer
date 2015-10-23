FactoryGirl.define do
	salt = '123456789'
	factory :user do
		email { Faker::Internet.email }
		firstname { Faker::Name.first_name }
		lastname { Faker::Name.last_name }
		password 'secret'
		password_confirmation 'secret'
		salt salt
		crypted_password Sorcery::CryptoProviders::BCrypt.encrypt('secret', salt)
	end
end