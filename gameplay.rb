require_relative 'dice.rb'
require_relative 'scorecard.rb'
require_relative 'categories.rb'

class Gameplay

  def initialize
    @scorecard = Scorecard.new
    @categories = Categories.new
    @round = 1
    @roll_number = 1
  end

  def start
    system "clear"
    puts "~*----*~*---*~ Welcome to Yahtzee!!!!!! ~*---*~*----*~"
    puts
    puts "[Enter] to continue."
    gets.chomp
    @dice = Dice.new
    roll_one
  end

  def roll_one
    system "clear"
    puts "Round #{@round}, Roll One:"
    puts
    @dice.display
    puts
    puts "Which would you like to re-roll?"
    puts "[1] for all"
    puts "[2] for none"
    puts "[3] to select"
    choice = gets.chomp.to_i
    if choice == 1
      @dice = Dice.new
      roll_two
    elsif choice == 2
      select_category
    elsif choice == 3
      reroll_procedure
      roll_two
    else
      roll_one
    end
  end
  
  def roll_two
    system "clear"
    puts "Round #{@round}, Roll Two:"
    puts
    @dice.display
    puts
    puts "Which would you like to re-roll?"
    puts "[1] for all"
    puts "[2] for none"
    puts "[3] to select"
    choice = gets.chomp.to_i
    if choice == 1
      @dice = Dice.new
    elsif choice == 2
      select_category
    elsif choice == 3
      reroll_procedure
    else
      roll_two
    end
    select_category
  end

  def next_roll
    if @roll_number == 1
      @roll_number += 1
      roll_two
    elsif @roll_number == 2
      select_category
    end
  end

  def next_round
    if @round == 13
      end_game
    else
      @round += 1
      @roll_number = 1
      system "clear"
      print "[Enter] to take your first roll for Round #{@round}"
      gets.chomp
      @dice = Dice.new
      roll_one
    end
  end

  def select_dice_to_reroll 
    accept = false
    until accept
      @dice_to_reroll = gets.chomp.gsub(/\s+/, "").split(',')
      @dice_to_reroll = @dice_to_reroll.select {|dice| dice.to_i >= 1 && dice.to_i <= 6}
      puts
      puts "Dice To Reroll:"
      @dice_to_reroll.each do |die|
        die = die.to_i
        index = die - 1
        puts "Dice #{die}: #{@dice.roll[index]}"
      end
      puts "[Enter] If this is correct"
      puts "To re-select dice to re-roll, type [1]"
      choice = gets.chomp.to_i
      if choice == 1
        system "clear"
        @dice.display
        puts
        reroll_procedure
      else
        accept = true
      end
    end
  end

  def reroll_procedure
    puts "Which dice would you like to re-roll? Type integers and separate with a comma."
    select_dice_to_reroll
    @dice_to_reroll.each do |die|
      die = die.to_i
      die -= 1
      @dice.reroll(die)
    end
    next_roll
  end

  def select_category
    system "clear"
    puts "Round #{@round}, Your Final Roll:"
    @dice.display
    puts
    puts "---- Categories ----"
    puts "[1] Ones (#{@scorecard.scorecard[:ones]})"
    puts "[2] Twos (#{@scorecard.scorecard[:twos]})"
    puts "[3] Threes (#{@scorecard.scorecard[:threes]})"
    puts "[4] Fours (#{@scorecard.scorecard[:fours]})"
    puts "[5] Fives (#{@scorecard.scorecard[:fives]})"
    puts "[6] Sixes (#{@scorecard.scorecard[:sixes]})"
    puts "[7] Three-of-a-Kind (#{@scorecard.scorecard[:three_of_a_kind]})"
    puts "[8] Four-of-a-Kind (#{@scorecard.scorecard[:four_of_a_kind]})"
    puts "[9] Full House (#{@scorecard.scorecard[:full_house]})"
    puts "[10] Small Straight (#{@scorecard.scorecard[:small_straight]})"
    puts "[11] Large Straight (#{@scorecard.scorecard[:large_straight]})"
    puts "[12] YAHTZEE (#{@scorecard.scorecard[:yahtzee]})"
    puts "[13] Chance (#{@scorecard.scorecard[:chance]})"
    puts
    if @scorecard.scorecard[:bonus]
      puts "Bonus: #{@scorecard.scorecard[:bonus]}"
    end
    if @scorecard.scorecard[:yahtzee_bonus]
      puts "Yahtzee Bonus: #{@scorecard.scorecard[:yahtzee_bonus]}"
    end
    puts
    print "Selection: "
    choice = gets.chomp.to_i
    if choice == 1
      if @scorecard.scorecard[:ones] != 0
        choose_again
      else
        @categories.ones(@scorecard, @dice.roll)
      end
    elsif choice == 2
      if @scorecard.scorecard[:twos] != 0
        choose_again
      else
        @categories.twos(@scorecard, @dice.roll)
      end
    elsif choice == 3
      if @scorecard.scorecard[:threes] != 0
        choose_again
      else
        @categories.threes(@scorecard, @dice.roll)
      end
    elsif choice == 4
      if @scorecard.scorecard[:fours] != 0
        choose_again
      else
        @categories.fours(@scorecard, @dice.roll)
      end
    elsif choice == 5
      if @scorecard.scorecard[:fives] != 0
        choose_again
      else
        @categories.fives(@scorecard, @dice.roll)
      end
    elsif choice == 6
      if @scorecard.scorecard[:sixes] != 0
        choose_again
      else
        @categories.sixes(@scorecard, @dice.roll)
      end
    elsif choice == 7
      if @scorecard.scorecard[:three_of_a_kind] != 0
        choose_again
      else
        @categories.three_of_a_kind(@scorecard, @dice.roll)
      end
    elsif choice == 8
      if @scorecard.scorecard[:four_of_a_kind] != 0
        choose_again
      else
        @categories.four_of_a_kind(@scorecard, @dice.roll)
      end
    elsif choice == 9
      if @scorecard.scorecard[:full_house] != 0
        choose_again
      else
        @categories.full_house(@scorecard, @dice.roll)
      end
    elsif choice == 10
      if @scorecard.scorecard[:small_straight] != 0
        choose_again
      else
        @categories.small_straight(@scorecard, @dice.roll)
      end
    elsif choice == 11
      if @scorecard.scorecard[:large_straight] != 0
        choose_again
      else
        @categories.large_straight(@scorecard, @dice.roll)
      end
    elsif choice == 12
      # if YAHTZEE open, get 50 or "X", if already "X", choose again
      if @scorecard.scorecard[:yahtzee] == 0
        @categories.yahtzee(@scorecard, @dice.roll)
      elsif @scorecard.scorecard[:yahtzee] == "X"
        choose_again
      else
        # if valid 2nd YAHTZEE and bonus is open, get bonus, otherwise choose again
        if @dice.roll.uniq.length == 1 && @scorecard.scorecard[:yahtzee] == 50 && !@scorecard.scorecard[:yahtzee_bonus]
          @categories.yahtzee(@scorecard, @dice.roll)
        else
          choose_again
        end
      end
    elsif choice == 13
      if @scorecard.scorecard[:chance] != 0
        choose_again
      else
        @categories.chance(@scorecard, @dice.roll)
      end
    else
      select_category
    end
    @categories.bonus(@scorecard)
    puts
    system "clear"
    puts "Scorecard:"
    puts
    @scorecard.display_scorecard
    puts
    puts "[Enter] to continue."
    gets.chomp
    next_round
  end

  def choose_again
    system "clear"
    puts "Category taken, choose another category."
    puts "[Enter] to continue"
    gets.chomp
    select_category
  end

  def end_game
    system "clear"
    puts "Game Over!"
    puts "Your score was: #{@scorecard.grand_total}"
    puts "Great job!"
    puts
    puts "[Enter] to end the game"
    puts "[1] to play again"
    choice = gets.chomp.to_i
    if choice == 1
      @scorecard = Scorecard.new
      @round = 1
      self.start
    else
      return
    end
  end
  
end