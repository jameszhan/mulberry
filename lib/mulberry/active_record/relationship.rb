module Mulberry
  module Relationship
    extend ActiveSupport::Concern
    include Utils  
    
    included do
      has_and_belongs_to_many :followers, class_name: user_class_name, foreign_key: "followee_id", association_foreign_key: "follower_id", join_table: "followees_followers" 
      has_and_belongs_to_many :followees, class_name: user_class_name, foreign_key: "follower_id", association_foreign_key: "followee_id", join_table: "followees_followers"
    end
  
    def follow(user)
      followees << user
    end
    
    def unfollow(user)
      followees.delete(user)
    end
    
    def follow?(user)
      followees.where(follower_id: user).any?
    end  

    def followed_by?(user)
      followers.where(followee_id: user).any?
    end
    
  end
end