defmodule FunctionsTest do
  use ExUnit.Case, async: true

  import Numeracy.Functions

  test "can compute numerical derivative of a univariate function" do
    assert derivative_at(&(&1 * &1), 3) == 6
    assert derivative_at(&(&1 * &1), 0) == 0
  end
end
