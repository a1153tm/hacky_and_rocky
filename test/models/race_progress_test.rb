require 'test_helper'
require 'date'

class RaceProgressTest < ActiveSupport::TestCase

  setup do
    # monkey patch for RaceHorsePoint
    RaceHorsePoint.class_eval do
      alias :org_calc_point :calc_point
      def calc_point
        rand = Random.new
        @point = rand.rand(1..10)
      end
      alias :org_point :point
      def point
        @point
      end
    end
    # setup test class
    @prog = RaceProgress.new
    @race = Race.new
    3.times do |i|
      horse = RaceHorse.new
      horse.book = Book.new(title: "title#{i}")
      @race.race_horses << horse
    end
    @prog.race = @race
  end

  teardown do
    RaceHorsePoint.class_eval do
      alias :calc_point :org_calc_point
      alias :point :org_point
    end
  end

  test "should calcurate points of all race horses" do
    @prog.calc_order()
    assert_equal 3, @prog.race_horse_points.size
    @prog.race_horse_points.each_with_index do |p,i|
      assert_equal @race.race_horses[i], p.race_horse
      assert p.point
    end
  end

  test "should sortable with record_date" do
    progs = []
    3.times do |i|
      record_date = DateTime.parse('2013-10-10') - i
      progs << RaceProgress.new(:record_date => record_date)
    end
    assert_equal DateTime.parse('2013-10-10'), (progs[0]).record_date
    assert_equal DateTime.parse('2013-10-08'), (progs[2]).record_date
    sorteds = progs.sort
    assert_equal DateTime.parse('2013-10-08'), (sorteds[0]).record_date
    assert_equal DateTime.parse('2013-10-10'), (sorteds[2]).record_date
  end

  test "return nil unless not calcurated" do
    #assert_equal nil, @prog.race_horses()
  end

  test "should be added order and point" do
    @prog.calc_order()
    horses = @prog.race_horses()
    assert_equal 3, horses.size
    @race.race_horses.each do |h|
      horses.include?(h)
    end
    points = @prog.race_horse_points
    sorteds = points.sort.reverse
    horses.each_with_index do |h,i|
      assert_equal i + 1, h.order
      assert_equal sorteds[i].point, h.point
    end
  end

end
