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
      user_class.class_eval do
        def like(likable)
          likable.vote(1, self)
        end
        
        def dislike(likable)
          likable.vote(-1, self)
        end

        def unlike(likable)
          likable.likes.where(user_id: self).first.try(:delete)
        end
        
        def like?(likable)
          likable.likes.find_or_initialize_by(user_id: self).value > 0
        end
        
        def dislike?(likable)
          likable.likes.find_or_initialize_by(user_id: self).value < 0
        end
                
      end
    end

    def likes_value
      likes.sum(:value)
    end

    def users_who_liked
      likes.map(&:user) 
    end
    
    # upsert
    def vote(value, user)
      like = likes.find_or_initialize_by(:user => user)
      like.value += value
      like.save!
    end
        
  end
end