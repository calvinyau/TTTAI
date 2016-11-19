require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return false if board.winner.nil? || board.winner == evaluator
      return true
    end

    #possibly backwards
    if next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if board.over?
      return true if board.winner == evaluator
      return false
    end

    #possibly backwards
    if next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    all_children = []
    board.rows.each_with_index do |row, r_index|
      row.each_with_index do |tile, c_index|
        if tile.nil?
          # possible problem
          child_board = board.dup
          pos = [r_index, c_index]
          child_board[pos] = next_mover_mark
          child_mover_mark = next_mover_mark == :x ? :o : :x
          child_node = TicTacToeNode.new(child_board, child_mover_mark, pos)
          all_children << child_node
        end
      end
    end
    all_children
  end
end
