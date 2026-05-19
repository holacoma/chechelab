require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  # spin_words: reverses words with 5 or more letters
  test "spin_words reverses long words" do
    post spin_words_url, params: { sentence: "Hey fellow warriors" }
    assert_response :success
    assert_equal "Hey wollef sroirraw", response.parsed_body["result"]
  end

  test "spin_words leaves short words untouched" do
    post spin_words_url, params: { sentence: "This is a test" }
    assert_response :success
    assert_equal "This is a test", response.parsed_body["result"]
  end

  test "spin_words handles mix of short and long words" do
    post spin_words_url, params: { sentence: "This is another test" }
    assert_response :success
    assert_equal "This is rehtona test", response.parsed_body["result"]
  end

  test "spin_words with a single long word" do
    post spin_words_url, params: { sentence: "warriors" }
    assert_response :success
    assert_equal "sroirraw", response.parsed_body["result"]
  end

  test "spin_words with a single short word" do
    post spin_words_url, params: { sentence: "hey" }
    assert_response :success
    assert_equal "hey", response.parsed_body["result"]
  end

  test "spin_words reverses exactly 5-letter words" do
    post spin_words_url, params: { sentence: "Hello world" }
    assert_response :success
    assert_equal "olleH dlrow", response.parsed_body["result"]
  end
end
