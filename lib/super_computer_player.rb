require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board, mark)
    move = winning_move(current_node) || non_losing_move(current_node)
    
    raise "There must always be a non-losing node." if move.nil?
    move
  end

  def winning_move(current_node)
    mark = current_node.next_mover_mark
    current_node.children.each do |child_node|
      return child_node.prev_move_pos if child_node.winning_node?(mark)
    end
    nil
  end

  def non_losing_move(current_node)
    mark = current_node.next_mover_mark
    current_node.children.each do |child_node|
      return child_node.prev_move_pos unless child_node.losing_node?(mark)
    end
    nil
  end
end



if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
