module Mulberry  
  module Likable
    extend ::ActiveSupport::Concern
    include Utils

    included do
      has_many :likes, as: :likable, dependent: :destroy, class_name: "Mulberry::Like"
      scope :liked_by, ->(user){ joins(:likes)
        .where(likes: {user_id: user, likable_type: class_of_active_record_descendant(self)})
        .order("created_at DESC") 
      } 
    end

    def likes_value
      likes.sum(:value)
    end

    def users_who_liked
      likes.map(&:user) 
    end

    def liked_by?(user)
      likes.where(user_id: user).any?
    end
    
    def like!(user)
      vote(user, 1)
    end
    
    def dislike!(user)
      vote(user, -1)
    end

    def unlike!(user)
      likes.where(user_id: user).first.try(:delete)
    end
    
    # upsert
    def vote(user, value)
      like = likes.find_or_initialize_by(:user => user)
      like.value += value
      like.save!
    end
        
  end
end