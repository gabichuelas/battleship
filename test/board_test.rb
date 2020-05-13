require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new()
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

  def test_it_has_a_valid_coordinate
    skip
    # checks if a coordinate is on the board or not
    assert @board.valid_coordinate?("AI")
    assert @board.valid_coordinate?("D4")

    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate("A22")
  end

  def test_valid_placement_by_length
    skip
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    # write statement that checks if ship placement
    # array of coordinates is equal in number to
    # length of ship.

    # The following should be false because there are
    # only 2 coordinates in the array (AI, A2) but
    # cruisers have a length of 3.
    # Same with submarine
    refute @board.valid_placement?(cruiser, ["A1", "A2"])
    refute @board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_valid_placement_by_consecutive_cell_coordinates
    refute @board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(submarine, ["A1", "C1"])
    refute @board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_valid_placement_coordinates_not_diagonal
    refute @board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_valid_ship_placement
    assert @board.valid_placement?(submarine, ["A1", "A2"])
    assert @board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end




end
