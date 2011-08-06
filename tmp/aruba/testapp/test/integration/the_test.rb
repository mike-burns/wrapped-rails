require 'test_helper'
class TheTest < ActionController::IntegrationTest
  def test_the_app
    User.create!(:first_name => 'Roy', :middle_name => 'Grace', :last_name => 'Biv')
    User.create!(:first_name => 'The', :last_name => 'Pope')
    get users_path
    assert page.has_content?("Roy G. Biv")
    assert page.has_content?("The Pope")
  end
end