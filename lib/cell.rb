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
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship.class == Ship
      @fired_upon = true
      @ship.hit
    else
    end
  end


  def render()
    "."
    #if/elsif/else/end
  end
#optional parameters
end
