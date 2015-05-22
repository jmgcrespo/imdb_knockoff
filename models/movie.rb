class Movie < ActiveRecord::Base
  validates :name, presence: true
  validates :rating, inclusion: (1..5), allow_blank: true 
end
