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
    skip
    assert @game.main_menu
  end

  def test_has_ships
    assert_equal Hash.new, @game.comp_ships
    assert_equal Hash.new, @game.player_ships

    @game.generate_ships
    assert_equal 2, @game.comp_ships.count
    assert_equal 2, @game.player_ships.count
    assert_instance_of Ship, @game.player_ships['Cruiser']
  end


  def test_can_pick_random_coordinates
    # skip
    @game.generate_ships

    assert_equal 3, @game.randomize_coordinates(@game.comp_ships['Cruiser']).count
  end

  def test_can_place_computer_ships
    skip
  end



end
