class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :email
    	t.string :firstname
    	t.string :lastname
    	t.boolean :employee
    end
  end
end
