require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

# create a unique die 
# create a points_array that holds all points for each step
# Devide a set of same random numbers by 3. If remainder is 0 and the die was a 1 then set each 3 to 1000 points otherwise set it to 500. 
# If there is a remainder - if die is 1 then multiply it by 100 if its 5 multiply by 50
# Reduce points_array to a single value by accumulating all values in it
# Work backwards from return points_array
def score(dice)
  # You need to write this method
  if dice.length == 0
    return 0
  end
  points_array = []
  counter = 0
  sorted_dice = dice.sort
  uniq_dice = sorted_dice.uniq
  uniq_quantity = []
  counter = 0
  uniq_item = 0
  die_points = 0
  last_die = 0
  sorted_dice.each  do |die|
    # check length if its 1 then return 
    if uniq_item == 0
      uniq_item = die
    end
    if die == uniq_item
      counter +=1
    else
      uniq_quantity.push(counter)
      counter = 1
    end
  end
  # another_array = array.map { |item| item + 10 }
  sorted_dice.each do |die|
    if last_die == die
      counter += 1
    else
      if last_die == 1
        die_points = 100
      elsif last_die == 5
        die_points = 50
      else
        last_die = die
        counter = 1
      end
    end
    if counter == 3
      
    end
    if die == 1
      counter += 1
      if (counter % 3 > 0)
        die_points = 100
      else
        die_points = 1000
      end 
    else
      die_points = 0
    end
  end
  puts "#{dice}"
  ones = sorted_dice.select { |n| n == 1 }
  fives = sorted_dice.select { |n| n == 5 }
  others = sorted_dice.select { |n| n != 1 || n != 5 }
  def calc(arr, type=nil)
    total = arr.length
    score = 0 
    remainder = total % 3
    single = type == 1 ? 100 : 50
    if total >= 3 
      score = type == 1 ? 1000 : 500
    end
    score += remainder * single
    return score
  end
  if ones.length > 0
    points_array.push(calc(ones, 1))
  elsif fives.length > 0
    points_array.push(calc(fives, 5))
  elsif others.legth > 0
    points_array.push(calc(others, sorted_dice))
  else
    return 0
  end
  return points_array.reduce(0, :+)
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
