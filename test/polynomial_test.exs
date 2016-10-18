defmodule PolynomialTest do
  use ExUnit.Case, async: true

  import Numeracy.Polynomial

  test "can add polynomials" do
    assert add([2, 3], [1, 2.5, -4]) == [3, 5.5, -4]
  end

  test "can return coefficient for a specified degree" do
    assert coefficient_of_degree([2, 3], 0) == 2
    assert coefficient_of_degree([2, 3], 3) == 0
  end

  test "can compute degree of polynomial" do
    assert degree([1, 2]) == 1
  end

  test "can evaluate value at a point" do
    assert value_at([2, 0, 2], -1) == 4
    assert value_at([3], 2) == 3
    assert value_at([1, -1, 1], 3) == 7
  end

  test "can determine if a value is a root" do
    assert is_root([2, -3, 1], 2)
    refute is_root([1, 1.5], 6)
  end

  test "can deflate a polynomial if a value is a root" do
    assert deflate([2, -3, 1], 2) == {:ok, [-1, 1]}
  end

  test "does not deflate a polynomial if the value is not a root" do
    assert deflate([2, -3, 1], -3) == {:error, [2, -3, 1]}
  end
end
