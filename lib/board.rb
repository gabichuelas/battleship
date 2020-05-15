class Board

  def initialize
  end

  def cells
    { "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    cells.any? do |cell_name, cell|
      coordinate == cell_name
    end
  end

  def valid_placement?(ship, coordinates)

    # turns given coordinates into array of integers
    columns = coordinates.map { |c| c[1].to_i }
    # turns given coordinates into array of letter.ordinal_values
    rows = coordinates.map { |c| c[0].ord }
    # turns coordinates into array of letter strings
    coordinate_letters = coordinates.map { |c| c[0] }

    # our checks!
    horizontal_check = (1..4).each_cons(ship.length).any?(columns)
    # vertical check
    letters_ord = ("A".."D").to_a.map { |a| a.ord }
    vertical_check = letters_ord.each_cons(ship.length).any?(rows)

    # if horizontal_check || vertical_check && ship.length == coordinates.length
    #   true
    # else
    #   false
    # end
    # require "pry"; binding.pry
    if ship.length == coordinates.length
      if horizontal_check && coordinate_letters.all?(coordinate_letters[0])
        true
      elsif vertical_check && !coordinate_letters.all?(coordinate_letters[0]) && columns.all?(columns[0])
        true
      else
        false 
      end
    else
      false
    end


    # cell_keys = cells.keys
    # ["A1", "A2", ...]

    # cell_key_nums = cells.keys.map { |key| key.to_i }
    # [1, 2, ...]


    # the following works if it's horizontal consecutiveness
    # but not vertical
    # if cell_keys.each_cons(ship.length).any?(coordinates) &&
    #   ship.length == coordinates.length
    #   true
    # else
    #   false
    # end
    # if we check for (1,2,3) && (A1, A

    # if we check for same # && consecutive cells according to ord = vertical check
  end

end
