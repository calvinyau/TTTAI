require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    current_node.children.each do |child_node|
      return child_node.prev_move_pos if child_node.winning_node?(mark)
    end
    current_node.children.each do |child_node|
      return child_node.prev_move_pos unless child_node.losing_node?(mark)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
