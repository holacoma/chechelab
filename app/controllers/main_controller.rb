class MainController < ApplicationController
  def index
  end

  def spin_words
    sentence = params[:sentence].to_s
    result = solve(sentence)
    render json: { result: result }
  end

  private

  def solve(sentence)
    words = sentence.split
    words.map! do |word|
      word.reverse! if word.length >= 5
      word
    end
    words.join(" ")
  end
end
