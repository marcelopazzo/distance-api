require 'test_helper'

class NumericTest < ActiveSupport::TestCase
  test "should be true for integer" do
    assert "1".numeric?
  end

  test "should be true for zero" do
    assert "0".numeric?
  end

  test "should be true for negative numbers" do
    assert "-1".numeric?
  end

  test "should be true for decimals" do
    assert "1.2".numeric?
  end

  test "should be true for scientific notation" do
    assert "5.4e-29".numeric?
  end

  test "should also be true for this scientific notation" do
    assert "12e20".numeric?
  end

  test "should be false non numeric string" do
    assert_not "1a".numeric?
  end

  test "should be false for something like addresses" do
    assert_not "1.2.3.4".numeric?
  end
end