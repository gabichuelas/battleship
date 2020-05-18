class Game





  puts "Welcome to BATTLESHIP
  Enter p to play. Enter q to quit."

  print "> "
  option = $stdin.gets.chomp

  if option == "p"
    puts "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long."

#      1 2 3 4
#    A . . . .
#    B . . . .
#    C . . . .
#    D . . . .

    puts "Enter the squares for the Cruiser (3 spaces):"
    print "> "


    #new board showing user-placed Cruiser


    puts "Enter the squares for the Submarine (2 spaces):"
    print "> "

    #if user enters invalid sequence(s), extra prompts~


    #new board showing user-placed Submarine




  end

  if option == "q"
    puts "Your loss."
  end
