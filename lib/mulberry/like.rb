module Mulberry
  class Like < ::ActiveRecord::Base
    belongs_to :user
    belongs_to :likable, :polymorphic => true

    attr_accessible :value, :user

    def self.find_likes_cast_by_user(user)
      find(:all,
        :conditions => ["user_id = ? ", user.id],
        :order => "created_at DESC"
      )
    end

  end  
end
