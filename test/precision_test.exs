defmodule PrecisionTest do
  use ExUnit.Case, async: true

  import Numeracy.Precision

  test "can compute radix" do
    assert radix() == 2
  end

  test "can compute machine precision" do
    radix = 2
    assert machine_precision(radix) == 1.1102230246251565e-16
  end

  test "can compute negative machine precision" do
    radix = 2
    assert negative_machine_precision(radix) == 1.1102230246251565e-16
  end

  test "can compute smallest number" do
    radix = 2
    negative_machine_precision = 1.1102230246251565e-16
    assert smallest_number(radix, negative_machine_precision) == 5.0e-324
  end
end
