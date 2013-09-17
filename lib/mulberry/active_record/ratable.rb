module Mulberry
  module Ratable
    extend ActiveSupport::Concern
    include Utils
  
    included do
      has_many :ratings, dependent: :destroy, as: :ratable, class_name: "Mulberry::Rating"
      has_many :rates, source: :rate, through: :ratings, class_name: "Mulberry::Rate"
      scope :rated_by, ->(rater){ joins(:ratings)
        .where(ratings: {rater_id: rater[:id], rater_type: rater[:type], ratable_type: class_of_active_record_descendant(self)})
        .order("created_at DESC") 
      }
    end
    
    ##
    # @blog.rate!(1.0, @user)
    # @blog.rate!(5.0, id: "127.0.0.1", type: "IP")
    def rate!(val, rater)
      review!(val, nil, rater)
    end
    
    ##
    # @blog.review!(1.0, "Bad!", @user)
    # @blog.review!(5.0, "Good!", id: "127.0.0.1", type: "IP")
    def review!(val, review_text, rater)
      rate = Rate.find_or_create_by!(score: val)
      rating = ratings.find_or_initialize_by(rater_id: rater[:id], rater_type: rater[:type])
      rating.rate = rate
      rating.review_text = review_text
      rating.save
    end
    
    def rate
      ratings.joins(:rate).average(:score).to_f
    end
    
    def rated_by?(rater)
      ratings.where(rater_id: rater[:id], rater_type: rater[:type]).any?
    end
    
  end
end

