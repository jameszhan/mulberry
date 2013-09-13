module Mulberry
  module Catalogable
    extend ActiveSupport::Concern
  
    included do
      has_many :catalogs, as: :catalogable, dependent: :destroy, class_name: "Mulberry::Catalog"
    end
    
  end
end

