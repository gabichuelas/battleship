class Game
  attr_reader :board, :player
  def initialize(player)
    @board = Board.new
    @player = player
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_sub = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
  end

  def turn
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

  def computer_ship_placement

    @board.place(ship, coordinates)
    # choose random coordinates, first for cruiser
    # then for submarine
    # adhere to placement rules
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
