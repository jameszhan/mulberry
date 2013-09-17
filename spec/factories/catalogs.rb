FactoryGirl.define do
  factory :language, class: Mulberry::Catalog do    
    name "Luanguage"
  end 
  factory :ruby, class: Mulberry::Catalog do
    name "Ruby"
    #association :parent, :language
  end
  factory :rails, class: Mulberry::Catalog do
    name "Rails"
    #association :parent, :ruby
  end
  factory :java, class: Mulberry::Catalog do
    name "Java"
    #association :parent, :language
  end
  factory :jboss, class: Mulberry::Catalog do
    name "JBoss"
    #association :parent, :java
  end
  factory :rspec, class: Mulberry::Catalog do
    name "RSpec"
    #association :parent, :ruby
  end
end
