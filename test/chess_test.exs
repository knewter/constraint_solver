defmodule ChessEngine do
  @files [0, 1, 2, 3, 4, 5, 6, 7] # Columns
  @ranks [0, 1, 2, 3, 4, 5, 6, 7] # Rows

  def calculate_move({:white, :pawn, {piece_file, piece_rank}} = piece, pieces) do
    for rank <- @ranks,
        file <- @files,
        rank > piece_rank,
        rank <= piece_rank + 2,
        file == piece_file do
      {file, rank}
    end
  end
end

defmodule ConstraintSolver.ChessTest do
  use ExUnit.Case

  test "valid pawn moves on a blank board" do
    # Positions are in {file, rank} order, 0-indexed
    piece = {:white, :pawn, {3, 1}} # Corresponds to d2
    pieces = [piece]

    # The pawn can either move by 1 or 2 spaces in its first move
    expected_positions = [
      {3, 2},
      {3, 3}
    ]

    assert Enum.sort(expected_positions) == Enum.sort(ChessEngine.calculate_move(piece, pieces))
  end
end

# http://www.chesscorner.com/tutorial/basic/notation/notate.htm
