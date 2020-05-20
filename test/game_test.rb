require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
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

  def test_has_a_menu
    @game.stubs(:gets).returns("q\n")

    assert_output(/You've quit the game./) { @game.main_menu }
  end

  def test_it_has_comp_and_player_boards
    assert_instance_of Board, @game.comp_board
    assert_instance_of Board, @game.player_board
  end

  def test_has_ships
    assert_equal Hash.new, @game.comp_ships
    assert_equal Hash.new, @game.player_ships

    @game.generate_ships
    assert_equal 2, @game.comp_ships.count
    assert_equal 2, @game.player_ships.count
    assert_instance_of Ship, @game.player_ships['Cruiser']
  end

  def test_can_pick_right_num_of_coordinates

    @game.generate_ships

    cells = @game.random_coordinates(@game.comp_ships['Cruiser'])

    assert_equal 3, cells.count
  end

  def test_comp_ships_can_sink
    @game.generate_ships
    @game.comp_ships['Cruiser'].hit
    @game.comp_ships['Cruiser'].hit
    @game.comp_ships['Cruiser'].hit
    @game.comp_ships['Submarine'].hit
    @game.comp_ships['Submarine'].hit
    assert_equal true, @game.comp_ships_sunk?
  end

  def test_player_ships_can_sink
    @game.generate_ships
    @game.player_ships['Cruiser'].hit
    @game.player_ships['Cruiser'].hit
    @game.player_ships['Cruiser'].hit
    @game.player_ships['Submarine'].hit
    @game.player_ships['Submarine'].hit
    assert_equal true, @game.player_ships_sunk?
  end






end
