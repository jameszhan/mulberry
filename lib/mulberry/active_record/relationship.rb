module Mulberry
  module Relationship
    extend ActiveSupport::Concern  
    
    included do
      has_and_belongs_to_many :followers, inverse_of: :followees, class_name: user_class_name#, foreign_key: "followee_id",  association_foreign_key: "follower_id", join_table: "followees_followers" 
      has_and_belongs_to_many :followees, inverse_of: :followers, class_name: user_class_name#, foreign_key: "follower_id",  association_foreign_key: "followee_id", join_table: "followees_followers"
    end
  
  end
end