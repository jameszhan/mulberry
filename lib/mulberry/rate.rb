module Mulberry
  class Rate < ActiveRecord::Base
    
    has_many :ratings,  :dependent => :destroy, :class_name => 'Mulberry::Rating'
    
  end
end
