defmodule PrecisionTest do
  use ExUnit.Case, async: true

  import Numeracy.Precision

  test "can compute radix" do
    assert compute_radix() == 2
  end

  test "can compute machine precision" do
    radix = 2
    assert compute_machine_precision(radix) == 1.1102230246251565e-16
  end

  test "can compute negative machine precision" do
    radix = 2
    assert compute_negative_machine_precision(radix) == 1.1102230246251565e-16
  end
end
