class Game
  attr_reader :board, :player, :comp_ships, :player_ships
  def initialize(player)
    @board = Board.new
    @player = player
    @comp_ships = Hash.new
    @player_ships = Hash.new
    # @comp_cruiser = Ship.new("Cruiser", 3)
    # @comp_sub = Ship.new("Submarine", 2)
    # @player_cruiser = Ship.new("Cruiser", 3)
    # @player_sub = Ship.new("Submarine", 2)
  end

  def main_menu
    puts "Welcome to BATTLESHIP\n
    Enter p to play. Enter q to quit."
    option = gets.chomp!
    if option == "p"
      "start game"
    elsif option == "q"
      "quit game"
    else
      "Invalid Input!"
    end
  end

  def add_comp_ship(ship)
    # could I use a splat operator to
    # add more than 1 ship at once?
    @comp_ships[ship.name] = ship
  end

  def add_player_ship(ship)
    # could I use a splat operator to
    # add more than 1 ship at once?
    @player_ships[ship.name] = ship
  end

  def generate_ships
    # generate a cruiser
    cruiser = Ship.new('Cruiser', 3)
    # generate a sub
    sub = Ship.new('Submarine', 2)
    # add 1 of each to comp_ships
    add_comp_ship(cruiser)
    add_comp_ship(sub)
    # add 1 of each to player_ships
    add_player_ship(cruiser)
    add_player_ship(sub)
  end

  def randomize_coordinates(ship)
    coordinates = []
    until @board.valid_placement?(ship, coordinates)
      coordinates = @board.cells.keys.sample(ship.length)
    end
    coordinates
  end

  def computer_ships_placement
    generate_ships
    comp_ships.each do |name, ship|
      coordinates = randomize_coordinates(ship)
      @board.place(ship, coordinates)
    end
  end

  def player_ship_placement
    puts "I have laid out my ships on the grid.\n
    You now need to lay out your two ships.\n
    The Cruiser is three units long and the Submarine is two units long."

    puts "Enter the squares for the Cruiser (3 spaces):"
    puts "For example: You can enter A1 A2 A3 - separate each coordinate with a space"
    puts "> "
    cruiser_squares = gets.chomp
    # if user enters invalid sequence(s), extra prompts~
    # new board showing user-placed Cruiser

    puts "Enter the squares for the Submarine (2 spaces):"
    print "> "
    sub_squares = gets.chomp
    # if user enters invalid sequence(s), extra prompts~
    # new board showing user-placed Submarine
  end

  def end_game
    if option == "q"
      puts "Your loss."
    end
  end

end
