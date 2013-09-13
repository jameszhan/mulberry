module Mulberry
  module Followable
    extend ActiveSupport::Concern
  
    included do
      has_and_belongs_to_many :followers, class_name: "User", foreign_key: "followee_id", join_table: "followees_followers", association_foreign_key: "follower_id"
      has_and_belongs_to_many :followees, class_name: "User", foreign_key: "follower_id", join_table: "followees_followers", association_foreign_key: "followee_id"  
    end
    
  end
end
