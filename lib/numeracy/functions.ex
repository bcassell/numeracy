defmodule Numeracy.Functions do
  @moduledoc """
  Operations on functions, such as derivation
  """

  @doc """
  Compute the numerical derivative of a given function at a specified value
  """
  @spec derivative_at((number -> number), number, number) :: float
  def derivative_at(func, value, relative_precision \\ 0.000001) do
    x1 = x_plus_epsilon(value, relative_precision)
    x2 = 2 * value - x1
    (func.(x1) - func.(x2)) / (x1 - x2)
  end

  @spec x_plus_epsilon(number, number) :: number
  defp x_plus_epsilon(value, relative_precision) when value == 0, do: relative_precision
  defp x_plus_epsilon(value, relative_precision), do: value * (1 + relative_precision)
end
