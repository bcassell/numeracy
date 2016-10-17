defmodule Numeracy.Polynomial do
  @moduledoc """
  Operations on polynomial
  """

  @typedoc """
  A representation of a polynomial, where the list is the coefficients of the polynomial,
  starting with the constant term
  """
  @type polynomial :: list(number)

  @spec add(polynomial, polynomial) :: polynomial
  def add(first, second) do
    first_length = Enum.count(first)
    second_length = Enum.count(second)
    summed = for {a, b} <- Enum.zip(first, second), do: a + b
    summed ++ Enum.drop(first, second_length) ++ Enum.drop(second, first_length)
  end
end