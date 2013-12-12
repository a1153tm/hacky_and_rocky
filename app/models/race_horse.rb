class RaceHorse < ActiveRecord::Base
  
  belongs_to :race
  belongs_to :book
  has_many :race_horse_points
  has_many  :vote_item
  belongs_to :horse_color, foreign_key: :horse_no

  validates :horse_no, :odds, :book_id, presence: true
  validates :odds, numericality: {greater_than_or_equal_to: 0.01, less_than_or_equal_to: 1000.0}
end
