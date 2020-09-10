class Program < ActiveRecord::Base
    has_many :musician_programs
    has_many :musicians, through: :musician_programs

end 