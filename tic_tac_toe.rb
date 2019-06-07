# Write a failing test for a method that will take an argument as an array like [‘x’, nil, ‘o’] 
# and return a string like X |   | O . Then make the test pass.
# Change your test to use an array of 9 elements and return a full tic tac toe board. 
# Then make the test pass. Refactor as you see fit.
# Do red/green/refactor for failure cases like incorrect array length and invalid characters.

class TicTacToeRow
  attr_accessor :row

  def initialize(row)
    @row = row
  end

  def to_s
    @row.map do |element|
      " #{element.nil? ? ' ' : element.upcase} "
    end.join('|')
  end
end

class TicTacToeBoard
  attr_accessor :positions

  def initialize(positions)
    @positions = positions
  end

  def rows
    row_arrays = @positions.each_slice(3).to_a
    row_arrays.map do |row|
      TicTacToeRow.new(row).to_s
    end
  end

  def winner
    winning_arrangements = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    winner = nil

    while winner == nil
      winning_arrangements.each do |winning_arrangement|
        if @positions[winning_arrangement[0]] == @positions[winning_arrangement[1]] && @positions[winning_arrangement[1]] == @positions[winning_arrangement[2]] 
          winner = @positions[winning_arrangement[0]]
        end
      end
    end
    winner
  end
end

RSpec.describe TicTacToeRow do
  describe '#to_s' do
    it 'takes a three element array and returns a string' do
      arr = ['x', nil, 'o']
      expect(TicTacToeRow.new(arr).to_s).to eq (' X |   | O ')
    end
  end
end

RSpec.describe TicTacToeBoard do
  describe '#rows' do
    it 'takes a position board and makes rows' do
      positions = [
        'x', 'x', 'x',
        'o', 'o', 'x',
        'o', 'x', 'o'
      ]

      expect(TicTacToeBoard.new(positions).rows).to eq ([" X | X | X ", " O | O | X ", " O | X | O "])
    end
  end
  
  describe '#winner' do
    it 'returns a winner when a row connects' do
      positions = [
              'x', 'x', 'x',
              'x', nil, 'o',
              nil, 'x', 'o'
            ]
      expect(TicTacToeBoard.new(positions).winner).to eq ('x')
    end

    it 'returns a winner when a column connects' do
      positions = [
              'o', 'x', 'o',
              'x', nil, 'o',
              nil, 'x', 'o'
            ]
      expect(TicTacToeBoard.new(positions).winner).to eq ('o')
    end

    it 'it determines a win when a left to right diagonal connects' do
      positions = [
              'o', 'x', 'o',
              'x', 'o', 'x',
              nil, 'x', 'o'
            ]
      expect(TicTacToeBoard.new(positions).winner).to eq ('o')
    end

    it 'it determines a win when a right to left diagonal connects' do
      positions = [
              'x', 'o', 'x',
              'o', 'x', 'o',
              'x', 'x', 'o'
            ]
      expect(TicTacToeBoard.new(positions).winner).to eq ('x')
    end
  end
end