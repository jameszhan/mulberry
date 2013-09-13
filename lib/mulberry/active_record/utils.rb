module Mulberry
  module Utils
    extend ::ActiveSupport::Concern
    
    module ClassMethods
      def class_of_active_record_descendant(clazz)
        ActiveRecord::Base.direct_descendants.each do|descendant|
          return descendant if clazz <= descendant
        end
      end 
      
      def user_class
        User
      end 
    end
  end
end
