require 'test_helper'

class RaceHorsePointTest < ActiveSupport::TestCase

  setup do
    # monkey patch for RankingPoint
    RankingPoint.class_eval do
      alias :org_calc_point :calc_point
      attr_accessor :called
      def calc_point
        @called = true
      end
    end
    # monkey patch for RankingPoint
    ReviewPoint.class_eval do
      alias :org_calc_point :calc_point
      attr_accessor :called
      def calc_point
        @called = true
      end
    end
    # setup test class
    @point = RaceHorsePoint.new
    @point.race_horse = RaceHorse.new
  end

  teardown do
    # Revert monkey patch
    RankingPoint.class_eval do
      alias :calc_point :org_calc_point
    end
    # Revert monkey patch
    ReviewPoint.class_eval do
      alias :calc_point :org_calc_point
    end
  end

  test "should value of calc point equals value of RankingPoint" do
    ranking = RankingPoint.new(:point => 120)
    review = ReviewPoint.new(:review_count => 5, :review_average => 3.145)
    @point.ranking_point = ranking
    @point.review_point = review
    assert_equal (120 + 5 * 3.145 * 100).to_i, @point.point
  end

  test "should invoke calc_point of RankingPoint" do
    @point.calc_point()
    assert @point.ranking_point.called
  end

  test "should pass race_horse" do
    @point.calc_point()
    assert_equal @point.race_horse, @point.ranking_point.race_horse
  end

  test "should sortable with point" do
    points = []
    3.times do |i|
      ranking = RankingPoint.new(:point => 10 - i)
      review = ReviewPoint.new(:review_count => 0, :review_average => 0.0)
      point = RaceHorsePoint.new
      point.ranking_point = ranking
      point.review_point = review
      points << point
    end
    assert_equal 8, (points.sort)[0].point
    assert_equal 10, (points.sort)[2].point
  end
end

