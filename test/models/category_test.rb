require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
   @category = Category.new(name: "sports") 
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "category should have a name" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name sould be unique" do
    @category.save
    @category_second = Category.new(name: "sports") 
    assert_not @category_second.valid?
  end
  
  test "name is too long" do
    @category = Category.new(name: "a" * 26)
    assert_not @category.valid?
  end

  test "name is too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end

end