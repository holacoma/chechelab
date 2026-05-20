class MainController < ApplicationController
  def index
  end

  def spin_words
    sentence = params[:sentence].to_s
    result = SpinWords::Solver.call(sentence)
    render json: { result: result }
  end
end
