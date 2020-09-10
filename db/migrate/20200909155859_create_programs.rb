class CreatePrograms < ActiveRecord::Migration[5.2]
  def up 
    create_table :programs do |t|
      t.string :name 
      t.integer :services
      t.string :dates
    end
  end

  def down 
    drop_table :programs 
  end 
  
end
