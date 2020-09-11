class Section < ActiveRecord::Base
    has_many :musicians

    def musicians_sorted
        self.musicians.sort_by{|w| w.last_name}
    end
end 