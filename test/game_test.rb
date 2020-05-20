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

  def test_it_has_comp_and_player_boards
    assert_instance_of Board, @game.comp_board
    assert_instance_of Board, @game.player_board
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

    cells = @game.random_coordinates(@game.comp_ships['Cruiser'])

    assert_equal 3, cells.count
  end

  def test_can_place_computer_ships
    skip
    @game.computer_ships_placement
    # can't test this bc output changes
    # every time, but I verified it in pry
    # by puts -ing the following line
    @game.comp_board.render
    @game.comp_board.render(true)
  end



end
