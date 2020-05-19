require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new("Amy")
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_a_board
    assert_instance_of Board, @game.board
  end

  def test_has_a_menu
    assert @game.main_menu
  end

  def test_comp_can_place_ships
  end



end
