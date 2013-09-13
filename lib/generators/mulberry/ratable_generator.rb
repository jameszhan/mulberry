require 'generators/mulberry/generator_base'

module Mulberry
  class RatableGenerator < GeneratorBase
    
    desc "Create taggable migrations"
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'db/migrate/create_rates.rb'
        sleep 1
        migration_template 'db/migrate/create_ratings.rb'
      end
    end
    
  end
end