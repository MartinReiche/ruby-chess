# Stores a player with given name and assignes it an ID
class Player
  #returns the name of the player
  attr_reader :name
  #returns the sign of the player
  attr_reader :color
  #returns the ID of the player
  attr_reader :id
  @@players = 0
  @@colors = ['white','black']
  #creates a new player with ID ans sign
  def initialize(name="")
    @@players += 1
    @id = @@players
    @color = @@colors[@id-1]
    name.empty? ? (@name = "Player #{@player_id}") : (@name = name)
  end
end

