class CreateMusicians < ActiveRecord::Migration[5.2]
  def up
    create_table :musicians do |t|
      t.string :name
      t.integer :section_id
    end
  end

  def down 
    drop_table :musicians
  end
  
end
