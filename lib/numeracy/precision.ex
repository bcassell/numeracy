defmodule Numeracy.Precision do
  @moduledoc """
  Algorithms for computing different measures of precision
  """

  import Numeracy.BasicMath

  @scales [1.25, 2, 2.5, 4, 5, 7.5, 8, 10]
  @semi_integer_scales [2, 2.5, 4, 5, 7.5, 8, 10]
  @integer_scales [2, 4, 5, 8, 10]

  @doc """
  Radix - the base that your computer is in
  """
  @spec radix :: integer
  def radix do
    a = 1.0
    a = compute_radix_helper(a, 0.0)
    b = 1.0
    compute_radix(a, b, 0)
  end

  @spec compute_radix_helper(float, float) :: float
  defp compute_radix_helper(a, tmp2) when tmp2 - 1.0 == 0.0, do: a
  defp compute_radix_helper(a, _) do
    a = a + a
    tmp1 = a + 1.0
    tmp2 = tmp1 - a
    compute_radix_helper(a, tmp2)
  end

  @spec compute_radix(float, float, integer) :: integer
  defp compute_radix(_, _, radix) when radix != 0, do: radix
  defp compute_radix(a, b, _) do
    b = b + b
    tmp = a + b
    compute_radix(a, b, round(tmp - a))
  end

  @doc """
  Machine precision - the smallest increment between two successive floating point numbers
  """
  @spec machine_precision(integer) :: float
  def machine_precision(radix) do
    inverse_radix = 1.0 / radix
    machine_precision = 1.0
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  @spec machine_precision :: float
  def machine_precision, do: machine_precision(radix())

  @spec compute_machine_precision(float, float, float) :: float
  defp compute_machine_precision(machine_precision, _, acc) when acc - 1.0 == 0.0, do: machine_precision

  defp compute_machine_precision(machine_precision, inverse_radix, _) do
    machine_precision = machine_precision * inverse_radix
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  @doc """
  Negative machine precision - the smallest decrement between two successive floating point numbers
  """
  @spec negative_machine_precision(integer) :: float
  def negative_machine_precision(radix) do
    inverse_radix = 1.0 / radix
    machine_precision = 1.0
    acc = 1.0 - machine_precision
    compute_negative_machine_precision(machine_precision, inverse_radix, acc)
  end

  @spec compute_negative_machine_precision(float, float, float) :: float
  defp compute_negative_machine_precision(machine_precision, inverse_radix, _) do
    machine_precision = machine_precision * inverse_radix
    acc = 1.0 - machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  @doc """
  Smallest number - the smallest representable positive number
  """
  @spec smallest_number(integer, float) :: float
  def smallest_number(radix, negative_machine_precision) do
    inverse_radix = 1.0 / radix
    full_mantissa_number = 1.0 - radix * negative_machine_precision
    compute_smallest_number(full_mantissa_number, inverse_radix)
  end

  @spec compute_smallest_number(float, float) :: float
  defp compute_smallest_number(full_mantissa_number, inverse_radix) when full_mantissa_number * inverse_radix == 0.0 do
    full_mantissa_number
  end

  defp compute_smallest_number(full_mantissa_number, inverse_radix) do
    compute_smallest_number(full_mantissa_number * inverse_radix, inverse_radix)
  end

  @doc """
  Largest number - the largest representable positive number
  """
  @spec largest_number(integer, float) :: float
  def largest_number(radix, negative_machine_precision) do
    full_mantissa_number = 1.0 - radix * negative_machine_precision
    compute_largest_number(full_mantissa_number, radix)
  end

  @spec largest_number :: float
  def largest_number do
    radix = radix()
    largest_number(radix, negative_machine_precision(radix))
  end

  @spec compute_largest_number(float, integer) :: float
  defp compute_largest_number(full_mantissa_number, radix) do
    try do
      compute_largest_number(full_mantissa_number * radix, radix)
    rescue
      ArithmeticError ->
        full_mantissa_number
    end
  end

  @doc """
  Largest exponential argument - raising a number > 1 to a power greater than this will exceed bounds
  """
  @spec largest_exponential_argument(float) :: float
  def largest_exponential_argument(largest_number), do: :math.log(largest_number)

  @spec largest_exponential_argument :: float
  def largest_exponential_argument, do: largest_exponential_argument(largest_number())

  @doc """
  Default precision - the relative precision that can be expected of a generic mathematical computation
  """
  @spec default_precision(float) :: float
  def default_precision(machine_precision), do: :math.sqrt(machine_precision)

  @spec default_precision :: float
  def default_precision, do: default_precision(machine_precision())

  @doc """
  Determine if numbers are within a given precision
  """
  @spec equal(number, number, float) :: boolean
  def equal(a, b, precision) do
    norm = max(abs(a), abs(b))
    norm < precision || abs(a - b) < precision * norm
  end

  @doc """
  Determine if numbers are within the default precision
  """
  @spec equal(number, number) :: boolean
  def equal(a, b) do
    precision = default_precision()
    equal(a, b, precision)
  end

  @doc """
  Perform float rounding to a specified precision
  """
  @spec round_to(number, float) :: float
  def round_to(value, scale) when scale > 0 and scale < 1 do
    round(value / scale) * scale
  end
end
