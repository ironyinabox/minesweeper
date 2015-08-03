require_relative 'board.rb'
require_relative 'tile.rb'
require 'yaml'
require 'byebug'

class Game
  attr_accessor :board

  def initialize(saved_game = nil)
    if saved_game.nil?
      @board = Board.new
    else
      yaml_saved_game = File.read(saved_game)
      @board = YAML.load(yaml_saved_game)
    end
  end

  def play
    system('clear')
    until over?
      board.render
      begin
        action, coordinate = prompt
      end until valid?(coordinate)
      if action == "R"
        board.reveal_tile(coordinate)
      elsif action == "F"
        board.flag_tile(coordinate)
      else
        save_game
        puts "SAVED GAME; have a nice day! : )"
        break
      end
      system('clear')
    end
    board.render
    if won?
      puts "CONGRATS YOU WIN"
    else
      puts "x.x"
    end
  end

  def prompt
    puts "F/R which coordinate? (ie F 0,0) or S 0,0 to save"
    action, coordinate = gets.chomp.split
    coordinate = coordinate.split(",").map(&:to_i)
    [action, coordinate]
  end

  def valid?(pos)
    board.in_bounds?(pos) && board[*pos].status == :hidden
  end

  def won?
    board.revealed_tiles_count == (Board::BOARD_DIM ** 2) - Board::BOMBS_NUM
  end

  def dead?
    board.bomb_revealed?
  end

  def over?
    won? || dead?
  end

  def save_game
    saved_game = board.to_yaml
    File.open("my-file.yml", "w") { |f| f.puts saved_game }
  end

  # def load_game
  #   self = YAML.load_file("my-file.yml")
  # end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new("my-file.yml")
  g.play

end
