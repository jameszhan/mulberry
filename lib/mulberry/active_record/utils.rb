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
        User.base_class
      end
      
      def user_class_name
        user_class.name
      end
    end
  end
end
