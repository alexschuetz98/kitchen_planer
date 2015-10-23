require 'rails_helper'

RSpec.describe User, type: :model do 
	it { is_expected.to validate_presence_of :lastname }
	it { is_expected.to validate_presence_of :email }
	it { is_expected.to validate_uniqueness_of :email }
	it { is_expected.to validate_presence_of :password }
	it { is_expected.to validate_presence_of :password_confirmation }

	describe 'Existing User' do
		context 'password did not change' do
			subject { FactoryGirl.create(:user) }

			it 'does not need a password and password_confirmation' do
				expect(subject).to_not validate_presence_of :password
				expect(subject).to_not validate_presence_of :password_confirmation
			end
		end

		context 'password changed' do
			subject { FactoryGirl.create(:user) }

			it 'updates password when password_confirmation and password set' do
				expect{
					subject.update(password: 'test', password_confirmation: 'test')
					subject.reload
				}.to change(subject, :crypted_password)
			end

			it 'does not update the user when password is empty' do
				expect{
					subject.update(password: '', password_confirmation: 'test')
					subject.reload
				}.to_not change(subject, :crypted_password)
			end

			it 'does not update the user when password_confirmation is empty' do
				expect{
					subject.update(password: 'test')
					subject.reload
				}.to_not change(subject, :crypted_password)
			end

			it 'does not update the user when password and password_confirmation are not equal' do
				expect{
					subject.update(password: 'test', password_confirmation: 'teste_selber')
					subject.reload
				}.to_not change(subject, :crypted_password)
			end
		end
	end
end