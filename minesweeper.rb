class Tile
  attr_accessor :is_bomb, :status, :neighbors

  #status can be hidden, revealed, flagged

  def initialize(is_bomb)
    @is_bomb = is_bomb
    @status = :hidden
    @neighbors = []
  end
  
end

class Board
  BOARD_DIM = 9
  BOMBS_NUM = BOARD_DIM

  attr_accessor :board

  def initialize
    board = Array.new(BOARD_DIM ** 2, Tile.new(false))
    BOMBS_NUM.times do |i|
      board[i].is_bomb = true
    end
    board.shuffle!
    @board = board.each_slice(BOARD_DIM)
  end
end
