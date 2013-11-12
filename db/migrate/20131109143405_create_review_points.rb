class CreateReviewPoints < ActiveRecord::Migration
  def change
    create_table :review_points do |t|
      t.integer :review_count, :default => 0
      t.float :review_average, :default => 0.0
      t.integer :race_horse_point_id

      t.timestamps
    end
  end
end
