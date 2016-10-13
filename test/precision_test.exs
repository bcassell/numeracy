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

  test "can compute largest number" do
    radix = 2
    negative_machine_precision = 1.1102230246251565e-16
    assert largest_number(radix, negative_machine_precision) == 1.7976931348623155e308
  end

  test "can compute default precision" do
    machine_precision = 1.1102230246251565e-16
    assert default_precision(machine_precision) == :math.sqrt(machine_precision)
  end

  test "when numbers are within a specified precision, they are considered equal" do
    assert equal(1.05, 1.1, 0.1) == true
  end

  test "when numbers are not within a specified precision, they are not considered equal" do
    assert equal(1, 2, 0.1) == false
  end

  test "when precision is not specified, equal uses the default_precision" do
    machine_precision = 1.1102230246251565e-16
    assert equal(1, 1 + default_precision(machine_precision)) == true
    assert equal(1, 1 + default_precision(machine_precision) + machine_precision) == false
  end
end
