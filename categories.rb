require_relative "scorecard.rb"

class Categories

  def ones(scorecard, dice)
    score = dice.count {|die| die == 1}
    if scorecard.scorecard[:ones] == 0 && score > 0
      scorecard.scorecard[:ones] = score
    else
      scorecard.scorecard[:ones] = "X"
    end
  end

  def twos(scorecard, dice)
    score = dice.count {|die| die == 2} * 2
    if scorecard.scorecard[:twos] == 0 && score > 0
      scorecard.scorecard[:twos] = score
    else
      scorecard.scorecard[:twos] = "X"
    end
  end

  def threes(scorecard, dice)
    score = dice.count {|die| die == 3} * 3
    if scorecard.scorecard[:threes] == 0 && score > 0
      scorecard.scorecard[:threes] = score
    else
      scorecard.scorecard[:threes] = "X"
    end  
  end

  def fours(scorecard, dice)
    score = dice.count {|die| die == 4} * 4
    if scorecard.scorecard[:fours] == 0 && score > 0
      scorecard.scorecard[:fours] = score
    else
      scorecard.scorecard[:fours] = "X"
    end  
  end

  def fives(scorecard, dice)
    score = dice.count {|die| die == 5} * 5
    if scorecard.scorecard[:fives] == 0 && score > 0
      scorecard.scorecard[:fives] = score
    else
      scorecard.scorecard[:fives] = "X"
    end
  end


  def sixes(scorecard, dice)
    score = dice.count {|die| die == 6} * 6
    if scorecard.scorecard[:sixes] == 0 && score > 0
      scorecard.scorecard[:sixes] = score
    else
      scorecard.scorecard[:sixes] = "X"
    end
  end

  def bonus(scorecard)
    if scorecard.part_one_total >= 63
      scorecard.bonus = 35
    end
  end

  def three_of_a_kind(scorecard, dice)
    valid_number = dice.detect {|die| (dice.count(die) == 3)}
    score = dice.reduce(:+)
    if scorecard.scorecard[:three_of_a_kind] == 0 && valid_number
      scorecard.scorecard[:three_of_a_kind] = score
    else
      scorecard.scorecard[:three_of_a_kind] = "X"
    end
  end

  def four_of_a_kind(scorecard, dice)
    valid_number = dice.detect {|die| (dice.count(die) == 4)}
    potential_score = dice.reduce(:+)
    if scorecard.scorecard[:four_of_a_kind] == 0 && valid_number
      scorecard.scorecard[:four_of_a_kind] = score
    else
      scorecard.scorecard[:four_of_a_kind] = "X"
    end
  end

  def full_house(scorecard, dice)
    dependency1 = dice.uniq.length == 2
    dependency2 = dice.count(dice[0]) == 2 || dice.count(dice[0]) == 3
    valid = true if (dependency1 && dependency2)
    if scorecard.scorecard[:full_house] == 0 && valid
      scorecard.scorecard[:full_house] = 25
    else
      scorecard.scorecard[:full_house] = "X"
    end
  end

  def small_straight(scorecard, dice)
    dice = dice.sort
    mini_straight1 = dice[1] - 1 == dice[0]
    mini_straight2 = dice[2] - 1 == dice[1]
    mini_straight3 = dice[3] - 1 == dice[2]
    mini_straight4 = dice[4] - 1 == dice[3]
    scenario1 = mini_straight1 && mini_straight2 && mini_straight3
    scenario2 = mini_straight2 && mini_straight3 && mini_straight4
    if scenario1 || scenario2
      valid = true
    else
      valid = false
    end
    if scorecard.scorecard[:small_straight] == 0 && valid
      scorecard.scorecard[:small_straight] = 30
    else
      scorecard.scorecard[:small_straight] = "X"
    end
  end

  def large_straight(scorecard, dice)
    dice = dice.sort
    mini_straight1 = dice[1] - 1 == dice[0]
    mini_straight2 = dice[2] - 1 == dice[1]
    mini_straight3 = dice[3] - 1 == dice[2]
    mini_straight4 = dice[4] - 1 == dice[3]
    if mini_straight1 && mini_straight2 && mini_straight3 && mini_straight4
      valid = true
    else
      valid = false
    end
    if scorecard.scorecard[:large_straight] == 0 && valid
      scorecard.scorecard[:large_straight] = 40
    else
      scorecard.scorecard[:large_straight] = "X"
    end
  end

  def yahtzee(scorecard, dice)
    valid = dice.uniq.length == 1
    if scorecard.scorecard[:yahtzee] == 0 && valid
      scorecard.scorecard[:yahtzee] = 50
    else
      scorecard.scorecard[:yahtzee] = "X"
    end    
  end

  def chance(scorecard, dice)
    score = dice.reduce(:+)
    unless scorecard.scorecard[:chance] != 0
      scorecard.scorecard[:chance] = score
    end
  end

end