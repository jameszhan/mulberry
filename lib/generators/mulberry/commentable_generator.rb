require 'generators/mulberry/generator_base'

module Mulberry  
  class CommentableGenerator < GeneratorBase
    desc "Create commentable migrations"
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'db/migrate/create_comments.rb'
      end
    end
  end  
end