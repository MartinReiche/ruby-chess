# Stores a player with given name and assignes it an ID
class Player
  #returns the name of the player
  attr_reader :name
  #returns the sign of the player
  attr_reader :color
  #returns the ID of the player
  attr_reader :id
  @@colors = ['white','black']
  #creates a new player with ID ans sign
  def initialize(id,name="")
    @id = id
    @color = @@colors[@id-1]
    name.empty? ? (@name = "Player #{@id}") : (@name = name)
  end
  def name=(name)
    @name = name
  end
end

