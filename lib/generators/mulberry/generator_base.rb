require 'rails/generators'
require 'rails/generators/migration'

module Mulberry
  class GeneratorBase < Rails::Generators::Base
    include Rails::Generators::Migration       
    
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
      
      def source_root
        File.expand_path('../templates', __FILE__)
      end
    end    
  end
end