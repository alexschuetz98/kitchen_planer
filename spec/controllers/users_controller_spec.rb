require "rails_helper"

RSpec.describe UsersController, type: :controller do
	let(:user) { FactoryGirl.create (:user) }

	before do
		login_user(user)
	end

	describe "#index" do 
		before { get :index }

		it "is successful" do
			expect(response).to have_http_status :success
		end

		it "renders index" do
			expect(response).to render_template :index
		end
	end

	describe "#new" do
		before { get :new}

		it "renders new" do
			expect(response).to have_http_status :success	
		end

		it "is successful" do
			expect(response).to be_success
		end

		it "loads a new user" do
			expect(assigns(:user)).to be_kind_of User
			expect(assigns(:user)).to_not be_persisted
		end
	end

	describe "#create" do
		context 'valid' do
			it "redirects to edit" do
				post :create, user: FactoryGirl.attributes_for(:user) 
				expect(response).to redirect_to edit_user_path(assigns(:user))
			end

			it "creates a new user" do
				expect{
					post :create, user: FactoryGirl.attributes_for(:user) 
				}.to change(User, :count).by(1)
			end
		end

		context 'invalid' do
			it "renders new" do
				post :create, user: FactoryGirl.attributes_for(:user, email: nil)
				expect(response).to render_template :new
			end

			it "does not create new user" do 
				expect{
					post :create, user: FactoryGirl.attributes_for(:user, email: nil)
				}.to_not change(User, :count)
			end
		end
	end

	describe "#edit" do
		before { get :edit, id: user }

		it "is successful" do
			expect(response).to have_http_status :success
		end

		it "renders edit" do
			expect(response).to render_template :edit
		end
	end

	describe "#update" do
		let!(:update_user) { FactoryGirl.create(:user) }

		context"valid" do
			it "updates a user" do
				old_name = update_user.firstname
				expect{
					patch :update, id: update_user, user: { firstname: 'asdfghj' }
					update_user.reload
				}.to change(update_user, :firstname).from(old_name).to('asdfghj')
			end

			it "redirects to index" do
				patch :update, id: update_user, user: { firstname: 'asdfghj' } 
				expect(response).to redirect_to users_path
			end
		end
		
		context "invalid" do
			it "does not update a user"do
				expect{
					patch :update, id: update_user, user: { lastname: nil  }
					update_user.reload
				}.to_not change(update_user, :lastname)
			end

			it "renders edit" do
				patch :update, id: update_user, user: { lastname: nil  }
				expect(response).to render_template :edit
			end
		end
	end

	describe "#destroy" do
		context "valid" do
			it "deletes a user"
			it "shows positive a message"
			it "redirects to index"
		end
		context "invalid" do
			it "does not delete the user"
			it "shows a negative message "
			it "redirects to index"
		end
	end

	describe 'users' do
		it 'loads all the users \o/' do
			expect(subject.send(:users)).to match_array([user])
		end
	end
end
