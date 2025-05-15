require 'set'

def knight_possible(curr = [0,0])
  moves = [
    [curr[0] + 1, curr[1] + 2],
    [curr[0] + 2, curr[1] + 1],
    [curr[0] + 2, curr[1] - 1],
    [curr[0] + 1, curr[1] - 2],
    [curr[0] - 1, curr[1] - 2],
    [curr[0] - 2, curr[1] - 1],
    [curr[0] - 2, curr[1] + 1],
    [curr[0] - 1, curr[1] + 2]
  ]

  moves.select { |x, y| x.between?(0, 7) && y.between?(0, 7) }
end

def knight_moves(start = [0, 0], fin = [7, 7])
  queue = [[start, [start]]]
  visited = Set.new

  until queue.empty?
    curr, path = queue.shift
    if curr == fin
      yield(path) if block_given?
      return path
    end

    knight_possible(curr).each do |move|
      unless visited.include?(move)
        visited.add(move)
        queue << [move, path + [move]]
      end
    end
  end
end

# This block would be better suited inside of the function, but I wanted to play with yield more.
knight_moves([3,3],[4,3]) do |moves|
  if moves.length - 1 == 1
    puts "You made it in 1 move! Here's your path:"
  else
    puts "You made it in #{moves.length - 1} moves! Here's your path:"
  end
  moves.each { |move| p move }
end