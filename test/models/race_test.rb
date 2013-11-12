require 'test_helper'
require 'date'

class RaceTest < ActiveSupport::TestCase

  setup do
    # monkey patch for R RaceProgress
    RaceProgress.class_eval do
      alias :org_calc_order :calc_order
      attr_accessor :order
      def calc_order
        @order = Random.new.rand(1..10)
      end
    end
    # setup test class
    @race = Race.new(name: 'テストレース', start_date: DateTime.parse('2013-10-23'),
      end_date: DateTime.parse('2013-10-23'), genre_id: 1)
    10.times do |i|
      @race.race_horses << RaceHorse.new(horse_no: i, odds: 1.0, book_id: i)
    end
    @race.save!()
    @the_date = DateTime.parse('2013-10-23').to_date
  end

  teardown do
    # Revert monkey patch
    RaceProgress.class_eval do
      alias :calc_order :org_calc_order
    end
  end

  test "should destroy old progresses and over all" do
    @race.race_progresses << RaceProgress.new(record_date: @the_date)
    @race.race_progresses << RaceProgress.new(record_date: @the_date)
    prog_ids = []
    @race.race_progresses.each do |prog|
      prog_ids << prog.id
      assert RaceProgress.find(prog.id)
    end
    @race.create_progress(@the_date)
    prog_ids.each do |id|
      assert !RaceProgress.find_by_id(id)
    end
  end

  test "should be saved and calucrated order by create_progress" do
    assert @race.race_progresses.empty?

    @race.create_progress(@the_date)
    _prog =  @race.race_progresses[0]
    assert (1..10).include?(_prog.order)
    puts "prog.order = #{_prog.order}"
    _race = Race.find(@race.id)
    assert_equal 1, _race.race_progresses.size
    _prog = (_race.race_progresses.to_a)[0]
    assert RaceProgress.find_by_id(_prog.id)
    puts "_prog.id = #{_prog.id}, _prog.record_date = #{_prog.record_date}"

    _race.create_progress(@the_date + 1)
    _prog =  _race.race_progresses[1]
    assert (1..10).include?(_prog.order)
    puts "prog.order = #{_prog.order}"
    _race = Race.find(@race.id)
    assert_equal 2, _race.race_progresses.size
    _prog = (_race.race_progresses.to_a)[1]
    assert RaceProgress.find_by_id(_prog.id)
    puts "_prog.id = #{_prog.id}, _prog.record_date = #{_prog.record_date}"
  end

  test "should get progress by date" do
    3.times do |i|
      @race.create_progress(@the_date + i)
    end
    _race = Race.find(@race.id)
    assert_equal 3, _race.race_progresses.size
    3.times do |i|
      assert @the_date + i, _race.race_progresses.sort[i].record_date
      assert _race.progress(@the_date + i)
    end
  end

  test "should get last progress" do
    3.times do |i|
      @race.create_progress(@the_date + i)
    end
    _race = Race.find(@race.id)
    assert_equal 3, _race.race_progresses.size
    assert_equal @the_date + 2, _race.progress(:last).record_date
  end
end
