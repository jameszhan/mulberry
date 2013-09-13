module Mulberry
  class Rating < ActiveRecord::Base
    
    belongs_to :rate
    belongs_to :rater, polymorphic: true #IP or Registred User
    belongs_to :ratable, polymorphic: true
    
    validates_presence_of :rate_id
    validates_presence_of :ratable_id
        
  end
end