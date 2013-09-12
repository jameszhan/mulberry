module Mulberry
  class Tag < ::ActiveRecord::Base
    
    has_many :taggings, dependent: :destroy, class_name: 'Mulberry::Tagging'
  
    validates_presence_of :name
    validates_uniqueness_of :name, scope: :group
  
    def count
      taggings.count
    end
    
    def taggables
      taggings.map(&:taggable)
    end
  
  end
end
