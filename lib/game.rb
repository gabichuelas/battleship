class Game
  attr_reader :comp_board, :comp_ships, :player, :player_board, :player_ships
  def initialize(player)
    @comp_board = Board.new
    @comp_ships = Hash.new

    @player = player
    @player_board = Board.new
    @player_ships = Hash.new
  end

  def main_menu
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    print "> "

    option = gets.downcase.chomp!
    until option.match(/p/) || option.match(/q/)
      puts "Enter p to play. Enter q to quit."
      print "> "
      option = gets.downcase.chomp!
    end

    if option.match(/p/)
      game_setup
    else
      puts "You've quit the game."
    end
  end

  def game_setup
    computer_ships_placement

    # Player ship placement:
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render

    puts "Enter the squares for the Cruiser (3 spaces):\nFor example: You can enter A1 A2 A3 - separate each coordinate with a space"
    print "> "

    player_places_ship(@player_ships['Cruiser'])
    puts @player_board.render(true)

    puts "Enter the squares for the Submarine (2 spaces):"
    print "> "

    player_places_ship(@player_ships['Submarine'])
    puts @player_board.render(true)

    game_play
  end

  def game_play
    turn
    until game_end?
      turn
    end
    display_both_boards
    if comp_ships_sunk?
      puts "You win, I guess :("
    elsif player_ships_sunk?
      puts "I won, sucker!"
    end

    main_menu
  end

  def turn
    display_both_boards
    player_fires
    comp_fires
  end

  def game_end?
    comp_ships_sunk? || player_ships_sunk?
  end

  def comp_ships_sunk?
    @comp_ships.all? do |ship_name, ship|
      ship.sunk?
    end
  end

  def player_ships_sunk?
    @player_ships.all? do |ship_name, ship|
      ship.sunk?
    end
  end

  def display_both_boards
    puts "=============COMPUTER BOARD============="
    puts @comp_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_fires
    puts "Enter the coordinate for your shot:"
    print "> "
    coordinate = gets.upcase.chomp!
    until @comp_board.valid_coordinate?(coordinate) && @comp_board.cells[coordinate].fired_upon? == false
      puts "Please enter a valid coordinate:"
      print "> "
      coordinate = gets.upcase.chomp!
    end
    @comp_board.cells[coordinate].fire_upon

    result = ""
    if @comp_board.cells[coordinate].render == "M"
      result = "miss"
      puts "Your shot on #{coordinate} was a #{result}."
    elsif @comp_board.cells[coordinate].render == "H"
      result = "hit"
      puts "Your shot on #{coordinate} #{result} a ship."
    elsif @comp_board.cells[coordinate].render == "X"
      result = "sunk"
      puts "Your shot on #{coordinate} #{result} a ship."
    end
  end

  def comp_fires
    coordinate = @player_board.cells.keys.sample
    #validate that coordinate is fired_upon? == false
    until @player_board.cells[coordinate].fired_upon? == false
      coordinate = @player_board.cells.keys.sample
    end
    @player_board.cells[coordinate].fire_upon

    result = ""
    if @player_board.cells[coordinate].render == "M"
      result = "miss"
      puts "My shot on #{coordinate} was a #{result}."
    elsif @player_board.cells[coordinate].render == "H"
      result = "hit"
      puts "My shot on #{coordinate} #{result} your ship."
    elsif @player_board.cells[coordinate].render == "X"
      result = "sunk"
      puts "My shot on #{coordinate} #{result} your ship."
    end
  end

  def player_places_ship(ship)
    player_input = gets.upcase.chomp!
    coordinates = player_input.split(' ')
    until @player_board.valid_placement?(ship, coordinates)
      puts "Those are invalid coordinates. Please try again:"
      print "> "
      player_input = gets.upcase.chomp!
      coordinates = player_input.split(' ')
    end

    @player_board.place(ship, coordinates)
  end

  def add_comp_ship(ship)
    # could we use a splat operator to
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
    cruiser1 = Ship.new('Cruiser', 3)
    cruiser2 = Ship.new('Cruiser', 3)
    # generate a sub
    sub1 = Ship.new('Submarine', 2)
    sub2 = Ship.new('Submarine', 2)
    # add 1 of each to comp_ships
    add_comp_ship(cruiser1)
    add_comp_ship(sub1)
    # add 1 of each to player_ships
    add_player_ship(cruiser2)
    add_player_ship(sub2)
  end

  def random_coordinates(ship)
    coordinates = []
    until @comp_board.valid_placement?(ship, coordinates)
      coordinates = @comp_board.cells.keys.sample(ship.length)
    end
    coordinates
  end

  def computer_ships_placement
    generate_ships
    comp_ships.each do |name, ship|
      coordinates = random_coordinates(ship)
      @comp_board.place(ship, coordinates)
    end
  end

end
