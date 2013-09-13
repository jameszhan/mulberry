require 'generators/mulberry/generator_base'

module Mulberry
  class FollowableGenerator < GeneratorBase
    
    desc "Create followable migrations"
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'db/migrate/create_followable.rb'
      end
    end
    
  end
end