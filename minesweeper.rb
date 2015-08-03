require 'byebug'

class Tile
  attr_accessor :is_bomb, :status

  NEIGHBOR_DIRECTIONS = [[-1, -1],
                        [-1, 0],
                        [+1, -1],
                        [0, -1],
                        [0, +1],
                        [-1, +1],
                        [+1, 0],
                        [+1, +1]]

  #status can be hidden, revealed, flagged

  def initialize(is_bomb)
    @is_bomb = is_bomb
    @status = :hidden
    # @neighbors = []
  end


  def reveal
    self.status = :revealed
  end

  def self.neighbors(pos, board)
    result = []
    row, col = pos
    NEIGHBOR_DIRECTIONS.each do |coord|
      shift_row, shift_col = coord
      neighbor_row, neighbor_col = row+shift_row, col+shift_col
      if board.in_bounds?([neighbor_row, neighbor_col])
        result << board[neighbor_row, neighbor_col]
      end
    end
    result
  end

  def neighbor_bomb_count
  end

  def is_bomb?
    is_bomb
  end

  def to_s
    case status
    when :hidden
      "*"
    when :revealed
      is_bomb? ? "B" : "_"
    when :flagged
      "F"
    end
  end

end

class Board
  BOARD_DIM = 9
  BOMBS_NUM = 10

  attr_accessor :board

  def initialize
    board = Array.new(BOARD_DIM ** 2) {Tile.new(false) }
    # debugger
    BOMBS_NUM.times { |i| board[i].is_bomb = true }
    board.shuffle!
    @board = board.each_slice(BOARD_DIM).to_a
  end

  def [](x, y)
    board[x][y]
  end

  def render
    board.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      puts "\n"
    end
    puts "\n\n"
  end

  def in_bounds?(pos)
    pos.all? { |idx| idx.between?(0, BOARD_DIM-1) }
  end
end

class Game
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.render
  b[0,0].reveal
  b.render
  p Tile.neighbors([0, 0], b)
end
