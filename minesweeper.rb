class Tile
  attr_accessor :is_bomb, :status, :neighbors

  #status can be hidden, revealed, flagged

  def initialize(is_bomb)
    @is_bomb = is_bomb
    @status = :hidden
    @neighbors = []
  end


  def reveal
  end

  def neighbors
  end

  def neighbor_bomb_count
  end

  def is_bomb?
    is_bomb
  end

end

class Board
  BOARD_DIM = 9
  BOMBS_NUM = BOARD_DIM

  attr_accessor :board

  def initialize
    board = Array.new(BOARD_DIM ** 2, Tile.new(false))
    BOMBS_NUM.times { |i| board[i].is_bomb? = true }
    board.shuffle!
    @board = board.each_slice(BOARD_DIM)
  end
end

class Game
end
