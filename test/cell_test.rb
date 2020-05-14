require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup

    @cell = Cell.new("B4")
  end

  def test_it_exists

    assert_instance_of Cell, @cell
  end

  def test_it_has_coordinates

    assert_equal "B4", @cell.coordinates
  end

  def test_it_does_not_have_a_ship

    assert_nil @cell.ship
  end

  def test_it_is_empty

    assert @cell.empty?
  end

  def test_it_has_a_new_ship

    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_instance_of Ship, @cell.ship
    refute @cell.empty?
  end

  def test_it_has_not_been_fired_upon

    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    refute @cell.fired_upon?
  end

  def test_has_been_fired_upon

    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    @cell.fire_upon

    assert_equal 2, @cell.ship.health
    assert @cell.fired_upon?
  end

  def test_cell_can_be_rendered

    cell_1 = Cell.new("B4")
    #refute @cell.fired_upon?
    assert_equal ".", cell_1.render
  end

  def test_fired_upon_and_shot_missed
    skip
    cell_1 = Cell.new("B4")
    cell_1.fire_upon
    assert_equal "M", cell_1.render
  end

  def test_cell_rendering_with_ship_hit
    skip
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)

    cell_2.fire_upon
    assert @cell.fired_upon?
    assert_equal "H", cell_2.render

    refute @cruiser.sunk?
  end

  def test_it_is_sunk_when_hit_3_times
    skip
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    @cruiser.hit
    @cruiser.hit
    refute @cruiser.sunk?
    @cruiser.hit
    assert @cruiser.sunk?
    assert_equal "X", cell_2.render
  end

end
