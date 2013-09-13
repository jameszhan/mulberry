require 'generators/mulberry/generator_base'

module Mulberry
  class VotableGenerator < GeneratorBase
    
    desc "Create likable migrations"
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'db/migrate/create_votes.rb'
      end
    end
    
  end
end