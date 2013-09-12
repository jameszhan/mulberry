module Mulberry  
  module Likable
    extend ::ActiveSupport::Concern
    include Utils

    included do
      has_many :likes, :as => :likable, :dependent => :destroy
      scope :liked_by_user, ->(user){ joins(:likes)
        .where(likes: {user_id: user, likable_type: class_of_active_record_descendant(self)})
        .order("created_at DESC") 
      } 
    end

    def likes_sum
      likes.sum(:value)
    end

    def liked_users
      likes.include(:users).map(&:user) 
    end

    def liked_by?(user)
      likes.where(user_id: user).first
    end
    
    def like_by(user)
      vote_by(user, 1)
    end

    def unlike_by(user)
      likes.where(user_id: user).first.try(:delete)
    end

    def dislike_by(user)
      vote_by(user, -1)
    end
    
    def vote_by(user, value)
      likes.create(:user => user, :value => value)
    end
        
  end
end