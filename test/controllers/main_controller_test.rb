require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  context "spin_words" do
    examples = [
      ["Hey fellow warriors", "Hey wollef sroirraw"],
      ["This is a test", "This is a test"],
      ["This is another test", "This is rehtona test"],
      ["warriors", "sroirraw"],
      ["hey", "hey"],
      ["Hello world", "olleH dlrow"]
    ]

    should_for "returns the expected transformation", examples do |sentence, expected|
      post spin_words_url, params: { sentence: sentence }
      assert_response :success
      assert_equal expected, response.parsed_body["result"]
    end
  end
end
