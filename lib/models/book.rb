class Book < ActiveRecord::Base
 has_many :race_horses
 belongs_to :genre
end
