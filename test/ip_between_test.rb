require "test_helper"

class IpBetweenTest < ActiveSupport::TestCase
  include IpBetween

  def setup_fixtures(*); end
  def teardown_fixtures(*); end

  context "Example tests" do
    should "pass basic examples" do
      assert_equal 50,  ips_between("10.0.0.0",  "10.0.0.50")
      assert_equal 256, ips_between("10.0.0.0",  "10.0.1.0")
      assert_equal 246, ips_between("20.0.0.10", "20.0.1.0")
    end

    should "handle same last octet" do
      assert_equal 1, ips_between("10.0.0.0", "10.0.0.1")
    end

    should "handle large range" do
      assert_equal 16_777_216, ips_between("10.0.0.0", "11.0.0.0")
    end
  end
end
