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

    # valid number of coordinates
    valid_length = ship.length == coordinates.length
    # coordinate columns as integer
    columns = coordinates.map do |coordinate|
      coordinate[1].to_i end
    # coordinate rows as letter string
    rows = coordinates.map do |coordinate|
      coordinate[0] end

    # checking consecutiveness
    horizontally_cons = (1..4).each_cons(ship.length).any?(columns)

    vertically_cons = ("A".."D").each_cons(ship.length).any?(rows)

    same_row = rows.all?(rows[0])
    same_column = columns.all?(columns[0])

    # valid placement conditional tree
    if valid_length && horizontally_cons && same_row
      true
    elsif valid_length && vertically_cons && !same_row && same_column
      true
    else
      false
    end
  end

end
