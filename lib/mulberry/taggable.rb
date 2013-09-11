module Mulberry
  module Taggable
    extend ::ActiveSupport::Concern

    included do
      has_many :taggings, dependent: :destroy, as: :taggable, class_name: "Mulberry::Tagging"
      has_many :tags, source: :tag, through: :taggings, class_name: "Mulberry::Tag"
    end  
    
    ##
    # Example:
    #   @user.tagged_with("awesome", "cool")                     
    #   @user.tagged_with("awesome", "cool", :group => 'hello') 
    def tag_with!(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      tags = args.map do|tag_name|
        Tag.find_or_create_by!(name: tag_name, group: (options[:group] || :global))
      end
      self.tags |= tags      
    end

    module ClassMethods        
      ##
      # Example:
      #   User.tagged_with("awesome", "cool")                     # Users that are tagged with awesome and cool
      #   User.tagged_with("awesome", "cool", :exclude => true)   # Users that are not tagged with awesome or cool
      #   User.tagged_with("awesome", "cool", :any => true)       # Users that are tagged with awesome or cool
      #   User.tagged_with("awesome", "cool", :match_all => true) # Users that are tagged with just awesome and cool
      def tagged_with(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        taggable_class = class_of_active_record_descendant
        tag_ids = Tag.where(name: args)
        if tag_ids.first
          if options.delete(:any)
            joins(:taggings).where(taggings: {tag_id: tag_ids}).uniq
          elsif options.delete(:exclude)
            sql =<<-SQL
              NOT EXISTS(
                SELECT * FROM #{tagging_table_name} WHERE 
                  #{taggable_class.table_name}.id = #{tagging_table_name}.taggable_id
                  AND #{tagging_table_name}.taggable_type = '#{taggable_class}'
                  AND #{tagging_table_name}.tag_id IN (?)
              )              
            SQL
            where(sql, tag_ids)
          elsif options.delete(:match_all)
            # Not exists a tag given it not tagged AND Not exists a tag which not given it tagged 
            sql =<<-SQL
              NOT EXISTS (
                SELECT * FROM #{tag_table_name} WHERE #{tag_table_name}.id IN (?) 
                AND NOT EXISTS (
                  SELECT * FROM #{tagging_table_name} WHERE 
                    #{taggable_class.table_name}.id = #{tagging_table_name}.taggable_id
                    AND #{tagging_table_name}.taggable_type = '#{taggable_class}'
                    AND #{tag_table_name}.id = #{tagging_table_name}.tag_id ))
              AND NOT EXISTS(
                SELECT * FROM #{tag_table_name} WHERE #{tag_table_name}.id NOT IN (?)
                AND EXISTS (
                  SELECT * FROM #{tagging_table_name} WHERE 
                    #{taggable_class.table_name}.id = #{tagging_table_name}.taggable_id
                    AND #{tagging_table_name}.taggable_type = '#{taggable_class}'
                    AND #{tag_table_name}.id = #{tagging_table_name}.tag_id))
            SQL
            where(sql, tag_ids, tag_ids)            
          else
            joins("INNER JOIN #{tagging_table_name} ON #{taggable_class.table_name}.id = #{tagging_table_name}.taggable_id AND #{tagging_table_name}.taggable_type = '#{taggable_class}'")                                                                        
              .where(taggings: {tag_id: tag_ids})
              .group("#{taggable_class.table_name}.id")
              .having("COUNT(DISTINCT #{tagging_table_name}.tag_id) = ?", tag_ids.count)
          end
        else
          taggable_class.none
        end
      end   
      
      private
         def class_of_active_record_descendant
           ActiveRecord::Base.direct_descendants.each do|clazz|
             return clazz if clazz <= self
           end
         end
         
         def tagging_table_name
           Mulberry::Tagging.table_name
         end
         
         def tag_table_name
           Mulberry::Tag.table_name
         end
    end
  end
end
