class CreateAdmins < ActiveRecord::Migration[5.2]
  def up 
    create_table :admins do |t|
      t.string :email 
      t.string :password_digest
    end 
  end

  def down
    drop_table :admins
  end 
  
end