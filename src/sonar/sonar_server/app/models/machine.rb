class Machine < ActiveRecord::Base
    validates_presence_of :url
    validates_uniqueness_of :url
    has_many :metrics
end
