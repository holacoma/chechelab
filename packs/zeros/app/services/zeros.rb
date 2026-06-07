module Zeros
  module_function

  def call(n)
    zeros(n)
  end

  def zeros(n)
    return 0 if n.zero?

    kmax = Math.log(n, 5).ceil
    (1...kmax).sum { |k| n / 5 ** k }
  end
end
