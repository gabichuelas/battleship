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
    refute @cell.empty?
  end

  def test_it_has_not_been_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    assert_equal false, @cell.fired_upon?
  end

  def test_has_been_fired_upon_and_loses_1_health
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    @cell.fire_upon

    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end

  def test_cell_can_be_rendered
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
  end

  def test_fired_upon_and_shot_missed
    cell_1 = Cell.new("B4")
    cell_1.fire_upon
    assert_equal "M", cell_1.render
  end

  def test_cell_rendering_with_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_cell_rendering_with_hit
    # we created a new cell
    cell_2 = Cell.new("C3")
    cell_2.fire_upon
    assert_equal "M", cell_2.render
    assert_equal true, cell_2.fired_upon?

    # let's put the ship on the cell_2
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
    # even though the cell was fired upon previously
    # before placing the ship, we had to reset
    # fired_upon? == false again because otherwise it
    # would render the cell as "H", even if we
    # hadn't fired on the cell again AFTER the ship
    # was placed.
    assert_equal false, cell_2.fired_upon?

    # let's fire on the cell now, AFTER we placed a ship
    cell_2.fire_upon
    assert_equal true, cell_2.fired_upon?
    assert_equal "H", cell_2.render

    assert_equal false, cruiser.sunk?
    # cruiser hasn't sunk because we only hit one of the
    # 3 cells it occupies
  end

  def test_it_is_sunk_when_hit_3_times
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    assert_equal true, cell_2.fired_upon?
    # fired_upon? also takes away 1 health,
    # just like cruiser.hit does
    assert_equal 2, cell_2.ship.health
    assert_equal "H", cell_2.render
    assert_equal false, cruiser.sunk?
    # just takes two more cruiser.hit to sink the ship
    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
