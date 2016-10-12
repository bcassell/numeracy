defmodule Numeracy.Precision do

  # Radix - the base that your computer is in
  def radix() do
    a = 1.0
    a = compute_radix_helper(a, 0)
    b = 1.0
    compute_radix(a, b, 0)
  end

  defp compute_radix_helper(a, tmp2) when tmp2 - 1.0 == 0.0, do: a
  defp compute_radix_helper(a, _) do
    a = a + a
    tmp1 = a + 1.0
    tmp2 = tmp1 - a
    compute_radix_helper(a, tmp2)
  end

  defp compute_radix(_, _, radix) when radix != 0, do: radix
  defp compute_radix(a, b, _) do
    b = b + b
    tmp = a + b
    compute_radix(a, b, round(tmp - a))
  end

  # Machine precision - the smallest increment between two successive floating point numbers
  def machine_precision(radix) do
    inverse_radix = 1.0 / radix
    machine_precision = 1.0
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  defp compute_machine_precision(machine_precision, _, acc) when acc - 1.0 == 0.0, do: machine_precision
  defp compute_machine_precision(machine_precision, inverse_radix, _) do
    machine_precision = machine_precision * inverse_radix
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  # Negative machine precision - the smallest decrement between two successive floating point numbers
  def negative_machine_precision(radix) do
    inverse_radix = 1.0 / radix
    machine_precision = 1.0
    acc = 1.0 - machine_precision
    compute_negative_machine_precision(machine_precision, inverse_radix, acc)
  end

  defp compute_negative_machine_precision(machine_precision, inverse_radix, _) do
    machine_precision = machine_precision * inverse_radix
    acc = 1.0 - machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  # Smallest number - the smallest representable positive number
  def smallest_number(radix, negative_machine_precision) do
    inverse_radix = 1.0/radix
    full_mantissa_number = 1.0 - radix * negative_machine_precision
    compute_smallest_number(full_mantissa_number, inverse_radix)
  end

  defp compute_smallest_number(full_mantissa_number, inverse_radix) when full_mantissa_number * inverse_radix == 0.0, do: full_mantissa_number
  defp compute_smallest_number(full_mantissa_number, inverse_radix), do: compute_smallest_number(full_mantissa_number * inverse_radix, inverse_radix)
end