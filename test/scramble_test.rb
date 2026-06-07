require "test_helper"

class ScrambleTest < ActiveSupport::TestCase
  include Scramble

  def setup_fixtures(*); end
  def teardown_fixtures(*); end

  context "Example tests" do
    should "pass basic examples" do
      assert_equal true,  scramble("rkqodlw",           "world")
      assert_equal true,  scramble("cedewaraaossoqqyt", "codewars")
      assert_equal false, scramble("katas",             "steak")
      assert_equal true,  scramble("scriptjava",        "javascript")
      assert_equal true,  scramble("scriptingjava",     "javascript")
    end

    should "fail when s2 needs more of a letter than s1 has" do
      assert_equal false, scramble("a",   "aa")
      assert_equal false, scramble("aab", "aaa")
    end

    should "pass example performance test" do
      s1 = "abcdefghijklmnopqrstuvwxyz" * 100_000
      s2 = "zyxcba" * 90_000
      assert_equal true, scramble(s1, s2)
    end
  end
end
