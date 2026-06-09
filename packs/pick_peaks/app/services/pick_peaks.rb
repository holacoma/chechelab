module PickPeaks
  module_function

  def pick_peaks(array)
    pos = []
    peaks = []

    deduplicated = array.each.with_index
                        .chunk_while { |(a, _), (b, _)| a == b }
                        .map(&:first)

    # each element is [value, index] after with_index
    deduplicated.each_cons(3) do |(a, _), (b, i), (c, _)|
      if a < b && b > c
        pos << i
        peaks << b
      end
    end
    { "pos" => pos, "peaks" => peaks }
  end

  def pick_peaks_v2(array)
    pos = []
    peaks = []
    array.each_cons(2)
         .with_index(1)
         .each do |(a, b), i|
      if a < b
        array[i..].each do |current|
          break if current > b

          if current < b
            pos << i
            peaks << b
            break
          end
        end
      end
    end

    { "pos" => pos, "peaks" => peaks }
  end
end
