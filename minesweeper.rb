class Tile
  attr_accessor :is_bomb, :status, :neighbors

  #status can be hidden, revealed, flagged

  def initialize(is_bomb)
    @is_bomb = is_bomb
    @status = :hidden
    @neighbors = []
  end
end
