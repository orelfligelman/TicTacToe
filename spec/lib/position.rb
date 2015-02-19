class Position
	attr_accesspr :board, :turn
	DIM = 3
	SIZE = DIM * DIM
	def initialize(board = nil, turn = "x")
		@board = board || %w(-)*SIZE
		@turn = turn
	end
	def move(idx)
		position = Position.new(@board.dup, xturn("o", "x"))
		position.board(idx) = turn
		position
	end
	def xturn(x,o)
		turn == "x" ? x : o
	end
	def possible_moves
		@board.map_with_index { |p, i| i if  p == "-"}.compact
	end
	def win? (turn)
		rows = @board.each_slice(DIM).to_a
		rows.any? {|row| row.all? {|p| p == turn}   } ||
		rows.transpose.any? {|col| col.all? {|p| p == turn}   } ||
		rows.map_with_index.all? {|row,i| row[i]==turn}
		rows.map_with_index.all? {|row,i| row[DIM-1-i]==turn}
	end
	def minimax
		return 100 if win?("x")
		return -100 if win?("o")
		return 0 if possible_moves.empty?
	end
end
