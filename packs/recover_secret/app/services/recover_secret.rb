module RecoverSecret
  module_function

  def recover_secret(triplets)
    array = []
    left = triplets.flatten.uniq.map{|char| [char, []]}.to_h
    
    triplets.each do |a, b, c|
      left[b] << a
      left[c] << b
      left[c] << a
    end

    while left.select{|k, v| v.empty?}.size == 1
      char = left.select{|k, v| v.empty?}.keys.first
      left.each { |k, v| v.delete(char) }
      array << char
      left.delete(char)
    end

    array.join
  end
end
