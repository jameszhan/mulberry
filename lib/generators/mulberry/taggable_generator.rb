require 'rails/generators'
require 'rails/generators/migration'

module Mulberry
  class TaggableGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    
    desc "Generates migration for Tag and Tagging models"
    source_root File.expand_path('../templates', __FILE__)  
    
    def create_migration_file
      if self.class.orm_has_migration?
        migration_template 'db/migrate/create_tags.rb'
        sleep 1
        migration_template 'db/migrate/create_taggings.rb'
      end
    end
    
    class << self
      def orm_has_migration?
        Rails::Generators.options[:rails][:orm] == :active_record
      end

      def next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
    end    
  end
end