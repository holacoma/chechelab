module SpinWords
  module_function

  def call(sentence)
    words = sentence.to_s.split
    words.map! { |word| transform(word) }
    words.join(" ")
  end

  def transform(word)
    return word unless word.length >= 5

    word.reverse
  end
  private_class_method :transform
end
