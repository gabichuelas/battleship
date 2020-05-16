class Game





  puts "Welcome to BATTLESHIP
  Enter p to play. Enter q to quit."

  print "> "
  option = $stdin.gets.chomp

  if option == "p"
    puts "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long."

      1 2 3 4
    A . . . .
    B . . . .
    C . . . .
    D . . . .

    "Enter the squares for the Cruiser (3 spaces):"
    print "> "
