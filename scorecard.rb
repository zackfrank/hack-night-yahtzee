class Scorecard

  def initialize
    @scorecard = {
      ones: 0,
      twos: 0,
      threes: 0,
      fours: 0,
      fives: 0,
      sixes: 0,
      three_of_a_kind: 0,
      four_of_a_kind: 0,
      full_house: 0,
      small_straight: 0,
      large_straight: 0,
      yahtzee: 0,
      chance: 0
    }
    @bonus = 0
    @yahtzee_bonus = 0
  end

  def scorecard
    @scorecard
  end

  def bonus
    @bonus
  end

  def yahtzee_bonus
    @yahtzee_bonus
  end

  def display_scorecard
    @scorecard.each do |category, value|
      if category == :three_of_a_kind
        category = "Three-of-a-kind"
      elsif category == :four_of_a_kind
        category = "Four-of-a-kind"
      else 
        category = category.to_s.gsub(/_/, ' ')
      end
      puts "#{category.capitalize}: #{value}"
    end
  end

  def is_full
    all_scores = @scorecard.values
    all_scores.any?(0) ? false : true
  end

  def part_one_total
    total = 0
    lower_half = [@scorecard[:ones], @scorecard[:twos], @scorecard[:threes], @scorecard[:fours], @scorecard[:fives], @scorecard[:sixes]]
    lower_half.each do |value|
      unless value == "X"
        total += value
      end
    end
    total
  end

  def grand_total
    all_valid_scores = @scorecard.values.select {|value| value != "X"}
    subtotal = all_valid_scores.reduce(:+)
    subtotal + @bonus + @yahtzee_bonus
  end

end