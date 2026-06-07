require "test_helper"

class ZerosTest < ActiveSupport::TestCase
  include Zeros

  def setup_fixtures(*); end
  def teardown_fixtures(*); end

  context "Sample Tests" do
    should "pass sample tests" do
      assert_equal 0, zeros(0), "Testing with n = 0"
    end

    should "pass with 6" do
      assert_equal 1, zeros(6), "Testing with n = 6"
    end

    should "pass with 30" do
      assert_equal 7, zeros(30), "Testing with n = 30"
    end

    should "pass with 33333" do
      assert_equal 8330, zeros(33333), "Testing with n = 33333"
    end
  end
end
