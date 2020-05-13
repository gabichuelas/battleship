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
    assert_equal 16, @board.cells.count
    # this next line asserts that the class type of
    # the value that corresponds to the key "AI"
    # is a Cell object.
    assert_instance_of Cell, @board.cells["AI"].class
  end

  def test_it_has_a_valid_coordinate
    assert @board.valid_coordinate?("AI")
    assert @board.valid_coordinate?("D4")

    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate("A22")
  end
  
end
