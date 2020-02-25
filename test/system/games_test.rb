require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end

  test "/new game page displays a random grid" do
    visit new_url
    assert test: "New Game"
    assert_selector "li", count: 10
  end

  test "returns word does not match if it does not exist in the grid" do
    visit new_url
    fill_in "answer", with: "alphabet"
    click_on "SUBMIT!"
    Capybara.exact = false
    assert_selector "p#results", text: /.*\'alphabet\' does not match the given letters.*/
  end

  test "returns word is not english if input is only one consonant" do
    visit new_url
    fill_in "answer", with: "k"
    click_on "SUBMIT!"
    Capybara.exact = false
    assert_selector "p#results", text: /.*\'k\' is not an English word.*/
  end

  test "returns congrats if word exists and is english" do
  end
end
