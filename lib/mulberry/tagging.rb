module Mulberry
  class Tagging < ::ActiveRecord::Base

    belongs_to :tag
    belongs_to :taggable, polymorphic: true

    validates_presence_of :tag_id
    validates_presence_of :taggable_id
  end  
end

