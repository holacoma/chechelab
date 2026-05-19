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
    raise NotImplementedError
  end
end
