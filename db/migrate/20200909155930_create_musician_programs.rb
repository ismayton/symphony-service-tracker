class CreateMusicianPrograms < ActiveRecord::Migration[5.2]
  def up 
    create_table :musician_programs do |t|
      t.integer :musician_id 
      t.integer :program_id
    end 
  end

  def down
    drop_table :musician_programs 
  end 
  
end
