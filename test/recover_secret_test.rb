require "test_helper"

class RecoverSecretTest < ActiveSupport::TestCase
  include RecoverSecret

  def setup_fixtures(*); end
  def teardown_fixtures(*); end

  context "Basic tests" do
    should "recover 'whatisup' from its triplets" do
      triplets = [
        %w[t u p],
        %w[w h i],
        %w[t s u],
        %w[a t s],
        %w[h a p],
        %w[t i s],
        %w[w h s]
      ]
      assert_equal "whatisup", recover_secret(triplets)
    end

    should "recover a string from a single triplet" do
      assert_equal "abc", recover_secret([%w[a b c]])
    end

    should "recover a string from overlapping triplets" do
      triplets = [
        %w[a b c],
        %w[b c d],
        %w[c d e]
      ]
      assert_equal "abcde", recover_secret(triplets)
    end
  end
end
