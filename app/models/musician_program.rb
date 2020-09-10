class MusicianProgram < ActiveRecord::Base
    belongs_to :musician
    belongs_to :program

end 