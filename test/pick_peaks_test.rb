require "test_helper"

class PickPeaksTest < ActiveSupport::TestCase
  include PickPeaks

  def setup_fixtures(*); end
  def teardown_fixtures(*); end

  context "Basic tests" do
    should "find peaks in a basic array" do
      assert_equal({ "pos" => [3, 7], "peaks" => [6, 3] }, pick_peaks([1, 2, 3, 6, 4, 1, 2, 3, 2, 1]))
    end

    should "ignore peaks on the edge of the array" do
      assert_equal({ "pos" => [3, 7], "peaks" => [6, 3] }, pick_peaks([3, 2, 3, 6, 4, 1, 2, 3, 2, 1, 2, 3]))
    end

    should "return position of the first element of a plateau-peak" do
      assert_equal({ "pos" => [3, 7, 10], "peaks" => [6, 3, 2] }, pick_peaks([3, 2, 3, 6, 4, 1, 2, 3, 2, 1, 2, 2, 2, 1]))
    end

    should "detect plateau-peak correctly when it appears mid-array" do
      assert_equal({ "pos" => [2, 4], "peaks" => [3, 2] }, pick_peaks([2, 1, 3, 1, 2, 2, 2, 2, 1]))
    end

    should "ignore plateau at the end of the array" do
      assert_equal({ "pos" => [2], "peaks" => [3] }, pick_peaks([2, 1, 3, 1, 2, 2, 2, 2]))
    end

    should "ignore ascending edge even when a peak exists before it" do
      assert_equal({ "pos" => [2], "peaks" => [3] }, pick_peaks([2, 1, 3, 2, 2, 2, 2, 5, 6]))
    end

    should "detect a peak followed by a descending plateau" do
      assert_equal({ "pos" => [2], "peaks" => [3] }, pick_peaks([2, 1, 3, 2, 2, 2, 2, 1]))
    end

    should "find multiple peaks including a plateau-peak" do
      assert_equal(
        { "pos" => [2, 7, 14, 20], "peaks" => [5, 6, 5, 5] },
        pick_peaks([1, 2, 5, 4, 3, 2, 3, 6, 4, 1, 2, 3, 3, 4, 5, 3, 2, 1, 2, 3, 5, 5, 4, 3])
      )
    end

    should "return empty arrays for an empty input" do
      assert_equal({ "pos" => [], "peaks" => [] }, pick_peaks([]))
    end

    should "return empty arrays when there are no peaks" do
      assert_equal({ "pos" => [], "peaks" => [] }, pick_peaks([1, 1, 1, 1]))
    end
  end
end
