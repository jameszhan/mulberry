require 'generators/mulberry/generator_base'

module Mulberry
  class TaggableGenerator < GeneratorBase
    
    desc "Create taggable migrations"
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'db/migrate/create_tags.rb'
        sleep 1
        migration_template 'db/migrate/create_taggings.rb'
      end
    end
    
  end
end