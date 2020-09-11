class Musician < ActiveRecord::Base
    has_many :musician_programs
    has_many :programs, through: :musician_programs
    belongs_to :section

    def services
        services = 0
        self.programs.each do |program|
            services = services + program.services
        end 
        services
    end 

    def last_name
        array = self.name.split(" ")
        array.last
    end 

    def self.all_sorted_by_last
        self.all.sort_by{|w| w.last_name}
    end
end 
