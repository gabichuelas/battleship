require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    skip
    @cell = Cell.new("B4")
  end

  def test_it_exists
    skip
    assert_instance_of Cell, cell
  end

  def test_it_has_coordinates
    skip
    assert_equal "B4", @cell.coordinate
  end

  def test_it_has_a_ship
    skip
    assert_equal nil, @cell.ship
  end

  def test_it_is_empty
    skip
    assert @cell.empty?
  end

  def test_it_has_a_new_ship
    skip
    assert_equal @cruiser, @cell.place_ship
  end

  def test_it_is_not_empty
    skip
    refute @cell.empty?
  end

  -------------------------------------------

  def test_it_has_not_been_fired_upon
    skip
    refute @cell.fired_upon?
  end

  def test_when_hit_loses_1_health
    @cruiser.hit
    assert_equal 2, @cell.ship.health
  end

  def test_it_has_been_fired_upon
    skip
    assert @cell.fired_upon?
  end

  --------------------------------------------

  def test_cell_has_not_been_fired_upon
    skip
    assert_equal ".", cell_1.render
  end

  def test_fired_upon_and_shot_missed
    skip
    assert_equal "M", cell_1.render
  end

  def test_it_has_a_new_cell
    skip
    assert_equal cell_2, Cell.new("C3")
  end

  def test_cell_has_a_ship
    skip
    assert_equal @cruiser, cell_2.place_ship
  end

  def test_new_cell_has_not_been_fired_upon
    skip
    assert_equal ".", cell_2.render
  end

  def test_new_cell_has_ship
    skip
    assert_equal "S", cell_2.render(true)
  end

  def test_new_cell_has_been_fired_upon
    skip
    assert @cell.fired_upon?
  end

  def test_ship_has_been_hit
    skip
    assert_equal "H", cell_2.render
  end

  def test_ship_has_not_been_sunk
    skip
    refute @cruiser.sunk?
  end

  def test_it_is_sunk_when_hit_3_times
    skip
    @cruiser.hit
    @cruiser.hit

    assert_equal 0, @cruiser.health
    assert @cruiser.sunk?
    assert_equal "X", cell_2.render
  end

end
