class StorageAlert < ActiveRecord::Base
    
    acts_as :alert # inheritance with gem 'active_record-acts_as'

    validates       :threshold, presence: true, numericality: true
    validates       :path, presence: true

    private

    def compare
        
    end
end
