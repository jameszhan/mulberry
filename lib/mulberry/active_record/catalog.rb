module Mulberry
  class Catalog < ActiveRecord::Base
    has_many :children, class_name: "Mulberry::Catalog", foreign_key: :parent_id
    belongs_to :parent, class_name: "Mulberry::Catalog", foreign_key: :parent_id
    
    validates_presence_of :name
    validates_uniqueness_of :name
    
    belongs_to :catalogable, polymorphic: true
  end
end