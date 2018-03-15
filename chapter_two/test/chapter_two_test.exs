defmodule ChapterTwoTest do
  use ExUnit.Case
  doctest ChapterTwo

  test "sums a list of numbers" do
    assert ChapterTwo.sum([3, 4, 5], 0) == 12
  end

  test "sums a list of numbers using Enum.reduce" do
    assert ChapterTwo.sum_using_enum([3, 4, 5]) == 12
  end

  test "flattens a list of nested lists" do
    assert ChapterTwo.flatten([1,[[2],3]]) == [1, 2, 3]
  end

  test "flatten reverse and square a list with nested lists" do
    assert ChapterTwo.transform([[1], [[2], 3]]) == [9, 4, 1]
  end

  test "flatten reverse and square a list with nested lists using pipe" do
    assert ChapterTwo.transform_with_pipe([[1], [[2], 3]]) == [9, 4, 1]
  end
end
