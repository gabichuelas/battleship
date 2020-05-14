class Cell

  attr_reader :coordinates,
              :ship,
              :fired_upon

  def initialize(coordinates)
    @coordinates = coordinates
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if @ship.class == Ship
      false
    else
      true
    end
  end

  def place_ship(ship)
    @ship = ship
    @fired_upon = false
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship.class == Ship
      @fired_upon = true
      @ship.hit
    else
      @fired_upon = true
    end
  end

  def render(show_ship = false)
    if @ship && @fired_upon
      "H"
    elsif @ship && @ship.sunk?
      "X"
    elsif @ship && show_ship
      "S"
    elsif @fired_upon
      "M"
    else
      "."
    end
  end

end
