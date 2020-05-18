require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new()
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_cells

    assert_equal 16, @board.cells.count
    # this next line asserts that the class type of
    # the value that corresponds to the key "A1"
    # is a Cell object.
    assert_instance_of Cell, @board.cells["A1"]
  end

  # TEST VALID COORDINATES

  def test_it_has_a_valid_coordinate

    # checks if a coordinate is on the board or not
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")

    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  # TEST VALID PLACEMENTS

  def test_valid_placement_by_length
    # skip
    # write statement that checks if ship placement
    # array of coordinates is equal in number to
    # length of ship.

    # The following should be false because there are
    # only 2 coordinates in the array (A1, A2) but
    # cruisers have a length of 3.
    # Same with submarine
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])

    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
  end

  def test_valid_placement_by_consecutive_cell_coordinates
    # skip
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_valid_placement_coordinates_not_diagonal
    # skip

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_ship_placement
    # skip

    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  # TEST PLACING SHIPS

  def test_can_have_a_ship_placed_on_it

    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_instance_of Cell, cell_1
    assert_instance_of Cell, cell_2
    assert_instance_of Cell, cell_3

    assert_instance_of Ship, @board.cells["A1"].ship
    assert_instance_of Ship, cell_2.ship
    assert_instance_of Ship, cell_3.ship

    assert_same cell_3.ship, cell_2.ship
  end

  # TEST OVERLAPPING SHIPS

  def test_overlapping_ships_are_not_possible
    # skip
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_it_has_default_rendered_state
    # skip
    # board is rendered with no shots fired by default
    assert_equal "  1 2 3 4\nA . . . .\nB . . . .\nC . . . .\nD . . . .\n" , @board.render
  end

  def test_it_renders_with_a_ship
    # skip
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4\nA S S S .\nB . . . .\nC . . . .\nD . . . .\n" , @board.render(true)
  end

  def test_it_renders_with_miss_and_hit

    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell1 = @board.cells["A1"]
    cell2 = @board.cells["A2"]
    cell3 = @board.cells["A3"]
    cell4 = @board.cells["A4"]

    cell2.fire_upon
    assert_equal "  1 2 3 4\nA . H . .\nB . . . .\nC . . . .\nD . . . .\n" , @board.render

    cell3.fire_upon
    assert_equal "  1 2 3 4\nA . H H .\nB . . . .\nC . . . .\nD . . . .\n" , @board.render

    cell4.fire_upon
    assert_equal "  1 2 3 4\nA . H H M\nB . . . .\nC . . . .\nD . . . .\n" , @board.render

    cell1.fire_upon
    # cruiser has been hit a third time and sunk
    assert_equal "  1 2 3 4\nA X X X M\nB . . . .\nC . . . .\nD . . . .\n" , @board.render
  end

end
