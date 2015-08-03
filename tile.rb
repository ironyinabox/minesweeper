require 'byebug'
require_relative 'board.rb'

class Tile
  attr_accessor :is_bomb, :status, :pos, :board, :neighbor_bomb_count

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

  def self.neighbors_coords(pos, board)
    result = []
    row, col = pos
    NEIGHBOR_DIRECTIONS.each do |coord|
      shift_row, shift_col = coord
      neighbor_row, neighbor_col = row+shift_row, col+shift_col
      if board.in_bounds?([neighbor_row, neighbor_col])
        result << [neighbor_row, neighbor_col]
      end
    end
    result
  end

  def neighbor_bomb_count
    @neighbor_bomb_count
  end

  def is_bomb?
    is_bomb
  end

  def to_s
    case status
    when :hidden
      "*"
    when :revealed
      is_bomb? ? "B" : "#{neighbor_bomb_count}"
    when :flagged
      "F"
    end
  end

end
