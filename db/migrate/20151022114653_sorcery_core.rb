class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.string :firstname
      t.string :lastname
      t.boolean :employee

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end