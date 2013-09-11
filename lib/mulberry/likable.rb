module Mulberry  
  module Likable
    extend ::ActiveSupport::Concern

    included do
      class_eval do
        has_many :likes, :as => :likable, :dependent => :destroy
      end
    end

    def likes_sum
      likes.sum(:value)
    end

    def users_who_liked
      likes.find(:all, :include => [:user]).map(&:user) 
    end

    def liked_by_user?(user = nil)
      user = current_user unless user
      user && self.likes.first(:conditions => {:user_id => user})
    end

    def vote_by(user, value)
      likes.create(:user => user, :value => value)
    end

    def like_by(user)
      vote_by(user, 1)
    end

    def unlike_by(user)
      like = likes.first(:conditions => {:user_id => user})
      like.delete if like
    end

    def dislike_by(user)
      vote_by(user, -1)
    end

    module ClassMethods
      def find_likes_by_user(user)
        likable_class = ActiveRecord::Base.send(:class_of_active_record_descendant, self)
        Like.find(:all,
          :conditions => ["user_id = ? and likable_type = ?", user.id, likable_class.to_s],
          :order => "created_at DESC"
        )    
      end

      def find_likables_by_user(user)
        likable_class = ActiveRecord::Base.send(:class_of_active_record_descendant, self)
        Like.where(:user_id => user, :likable_type => likable_class.to_s)
          .order("created_at DESC")
          .map(&:likable)
      end   
    end

  end
end