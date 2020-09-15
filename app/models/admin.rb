class Admin < ActiveRecord::Base
    has_secure_password

    def self.admin_password
        "admin"
    end 
    
end 