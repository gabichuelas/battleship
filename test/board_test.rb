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
    skip
    assert_equal 16, @board.cells.count
    # this next line asserts that the class type of
    # the value that corresponds to the key "AI"
    # is a Cell object.
    assert_instance_of Cell, @board.cells["AI"].class
  end

  # TEST VALID COORDINATES

  def test_it_has_a_valid_coordinate
    skip
    # checks if a coordinate is on the board or not
    assert @board.valid_coordinate?("AI")
    assert @board.valid_coordinate?("D4")

    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate("A22")
  end

  # TEST VALID PLACEMENTS

  def test_valid_placement_by_length
    skip
    # write statement that checks if ship placement
    # array of coordinates is equal in number to
    # length of ship.

    # The following should be false because there are
    # only 2 coordinates in the array (AI, A2) but
    # cruisers have a length of 3.
    # Same with submarine
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_valid_placement_by_consecutive_cell_coordinates
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_valid_placement_coordinates_not_diagonal
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_ship_placement
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  # TEST PLACING SHIPS

  def test_can_have_a_ship_placed_on_it
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_instance_of Cell, cell_1
    assert_instance_of Cell, cell_2
    assert_instance_of Cell, cell_3

    assert_instance_of Ship, cell_1.ship
    assert_instance_of Ship, cell_2.ship
    assert_instance_of Ship, cell_3.ship

    # assert_same checks for equivalent
    # objects ID, not equivalent states
    assert_same cell_3.ship, cell_2.ship
  end

  # TEST OVERLAPPING SHIPS

  def test_overlapping_ships_are_not_possible
    @board.place(@cruiser, ["A1", "A2", "A3"])
    refute @board.valid_placement?(@submarine, ["A1", "B1"])
    # The following should be false because the cruiser
    # Ship is already taking up the A1 cell.
  end

  def test_it_has_default_rendered_state
    # board is rendered with no shots fired by default
    assert_equal
    "  1 2 3 4 \n" +
    "A . . . . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . \n" ,
    @board.render
  end

  def test_it_renders_with_a_ship
    # board is rendered after a ship has been placed
    # this is designated by the optional argument (true)
    assert_equal
    "  1 2 3 4 \n" +
    "A S S S . \n" +
    "B . . . . \n" +
    "C . . . . \n" +
    "D . . . . \n" ,
    @board.render(true)
  end

  # ADD MORE RENDERING TESTS HERE
  # include board rendering with Hits, Misses,
  # and Sunken Ships. Two examples:

  # "  1 2 3 4 \n" +
  # "A H . . . \n" +
  # "B . . . M \n" +
  # "C X . . . \n" +
  # "D X . . . \n"

  # "  1 2 3 4 \n" +
  # "A H S S . \n" +
  # "B . . . M \n" +
  # "C X . . . \n" +
  # "D X . . . \n"

end
