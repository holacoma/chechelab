module Scramble
  module_function

  def scramble(s1, s2)
    available = s1.downcase.chars.tally
    needed = s2.downcase.chars.tally

    needed.all? { |letter, amount| (available[letter] || 0) >= amount }
  end
end
