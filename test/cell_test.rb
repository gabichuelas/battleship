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

  def test_ship_loses_1_health_when_fired_upon
    cruiser = Ship.new("Cruiser", 3)
    @cell.place_ship(cruiser)
    @cell.fire_upon

    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end

  def test_can_be_rendered
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
  end

  def test_render_fired_upon_and_missed
    cell_1 = Cell.new("B4")
    cell_1.fire_upon
    assert_equal "M", cell_1.render
    assert_equal true, cell_1.fired_upon?
  end

  def test_render_with_and_without_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_render_fired_upon_and_hit
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    assert_equal true, cell_2.fired_upon?
    assert_equal "H", cell_2.render

    assert_equal false, cruiser.sunk?
  end

  def test_it_is_sunk_when_hit_3_times
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    assert_equal true, cell_2.fired_upon?
    assert_equal 2, cell_2.ship.health
    assert_equal "H", cell_2.render
    assert_equal false, cruiser.sunk?

    # just takes two more cruiser.hit to sink the ship
    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
  end

  def test_renders_with_sunken_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    cruiser.hit
    cruiser.hit

    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
