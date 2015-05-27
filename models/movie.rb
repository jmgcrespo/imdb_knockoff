class Movie < ActiveRecord::Base
  validates :name, presence: true
  validates :rating, inclusion: (1..5), allow_blank: true

  def self.rating_range
    (1..5)
  end
end
