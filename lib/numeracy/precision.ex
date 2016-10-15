defmodule Numeracy.Precision do
  @moduledoc """
  Algorithms for computing different measures of precision
  """

  @doc """
  Radix - the base that your computer is in
  """
  def radix do
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

  @doc """
  Machine precision - the smallest increment between two successive floating point numbers
  """
  def machine_precision(radix) do
    inverse_radix = 1.0 / radix
    machine_precision = 1.0
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  def machine_precision, do: machine_precision(radix())

  defp compute_machine_precision(machine_precision, _, acc) when acc - 1.0 == 0.0, do: machine_precision

  defp compute_machine_precision(machine_precision, inverse_radix, _) do
    machine_precision = machine_precision * inverse_radix
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  @doc """
  Negative machine precision - the smallest decrement between two successive floating point numbers
  """
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

  @doc """
  Smallest number - the smallest representable positive number
  """
  def smallest_number(radix, negative_machine_precision) do
    inverse_radix = 1.0 / radix
    full_mantissa_number = 1.0 - radix * negative_machine_precision
    compute_smallest_number(full_mantissa_number, inverse_radix)
  end

  defp compute_smallest_number(full_mantissa_number, inverse_radix) when full_mantissa_number * inverse_radix == 0.0 do
    full_mantissa_number
  end

  defp compute_smallest_number(full_mantissa_number, inverse_radix) do
    compute_smallest_number(full_mantissa_number * inverse_radix, inverse_radix)
  end

  @doc """
  Largest number - the largest representable positive number
  """
  def largest_number(radix, negative_machine_precision) do
    full_mantissa_number = 1.0 - radix * negative_machine_precision
    compute_largest_number(full_mantissa_number, radix)
  end

  defp compute_largest_number(full_mantissa_number, radix) do
    try do
      compute_largest_number(full_mantissa_number * radix, radix)
    rescue
      ArithmeticError ->
        full_mantissa_number
    end
  end

  @doc """
  Default precision - the relative precision that can be expected of a generic mathematical computation
  """
  def default_precision(machine_precision), do: :math.sqrt(machine_precision)
  def default_precision, do: default_precision(machine_precision())

  @doc """
  Determine if numbers are within a given precision
  """
  def equal(a, b, precision) do
    norm = max(abs(a), abs(b))
    norm < precision || abs(a - b) < precision * norm
  end

  @doc """
  Determine if numbers are within the default precision
  """
  def equal(a, b) do
    precision = default_precision()
    equal(a, b, precision)
  end
end
