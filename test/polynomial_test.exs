defmodule PolynomialTest do
  use ExUnit.Case, async: true

  import Numeracy.Polynomial

  test "can add polynomials" do
    assert add([2, 3], [1, 2.5, -4]) == [3, 5.5, -4]
  end
end