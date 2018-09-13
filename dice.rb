class Dice

  def initialize
    @roll = [
      rand(1..6),
      rand(1..6),
      rand(1..6),
      rand(1..6),
      rand(1..6)
    ]
  end

  def roll
    @roll
  end

  def reroll(index)
    @roll[index] = rand(1..6)
  end

  def display
    index = 0
    5.times do
      puts "Dice #{index + 1}: #{@roll[index]}"
      index += 1
    end
  end

end