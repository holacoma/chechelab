module SpinWords
  class Solver
    class << self
      def call(sentence)
        new(sentence).call
      end
    end

    def initialize(sentence)
      @sentence = sentence.to_s
    end

    def call
      words = sentence.split
      words.map! { |word| transform(word) }
      words.join(" ")
    end

    private

    attr_reader :sentence

    def transform(word)
      return word unless word.length >= 5

      word.reverse
    end
  end
end
