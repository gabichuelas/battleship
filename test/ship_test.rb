require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new('Cruiser', 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_a_name
    skip
    assert_equal 'Cruiser', @cruiser.name
  end

  def test_it_has_a_length
    skip
    assert_equal 3, @cruiser.length
  end

  def test_it_has_health_equal_to_length
    skip
    assert_equal 3, @cruiser.health
  end

  def test_it_is_not_sunk_by_default
    skip
    refute @cruiser.sunk?
  end

  def test_when_hit_loses_1_health
    skip
    @cruiser.hit
    assert_equal 2, @cruiser.health

    @cruiser.hit
    assert_equal 1, @cruiser.health
  end

  def test_it_is_sunk_when_health_is_0
    skip
    @cruiser.hit
    @cruiser.hit
    refute @cruiser.sunk?

    @cruiser.hit
    assert_equal nil, @cruiser.hit
    assert @cruiser.sunk?
  end
end
