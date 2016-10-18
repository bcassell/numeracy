defmodule Numeracy.Polynomial do
  @moduledoc """
  Operations on polynomial
  """

  import Numeracy.Precision

  @typedoc """
  A representation of a polynomial, where the list is the coefficients of the polynomial,
  starting with the constant term
  """
  @type polynomial :: list(number)

  @doc """
  Add two polynomials
  """
  @spec add(polynomial, polynomial) :: polynomial
  def add(first, second) do
    first_length = Enum.count(first)
    second_length = Enum.count(second)
    summed = for {a, b} <- Enum.zip(first, second), do: a + b
    summed ++ Enum.drop(first, second_length) ++ Enum.drop(second, first_length)
  end

  @doc """
  Return the coefficient for the specified degree, returning 0 for undefined degrees
  """
  @spec coefficient_of_degree(polynomial, non_neg_integer) :: number
  def coefficient_of_degree(polynomial, degree), do: Enum.at(polynomial, degree, 0)

  @doc """
  Given a root of the polynomial, deflates it and returns the result as part of tuple indicating success.
  If it is not a root, return tuple indicating error and the original polynomial.
  """
  @spec deflate(polynomial, number) :: {:error, polynomial} | {:ok, polynomial}
  def deflate(polynomial, root) do
    if is_root(polynomial, root) do
      degree = degree(polynomial)
      {:ok, deflate(polynomial, [], root, coefficient_of_degree(polynomial, degree), degree - 1)}
    else
      {:error, polynomial}
    end
  end

  @spec deflate(polynomial, polynomial, number, number, integer) :: polynomial
  defp deflate(_, result, _, remainder, degree) when degree < 0, do: result
  defp deflate(target, result, root, remainder, degree) do
    deflate(target, [remainder | result], root, remainder * root + coefficient_of_degree(target, degree), degree - 1)
  end

  @doc """
  Determines whether the given value is a root of the polynomial, to within a specified precision
  """
  @spec is_root(polynomial, number, float) :: boolean
  def is_root(polynomial, root, precision \\ 0.000001) when precision > 0 and precision < 1 do
    polynomial
      |> value_at(root)
      |> equal(0, precision)
  end

  @doc """
  Returns the degree of the polynomial
  """
  @spec degree(polynomial) :: non_neg_integer
  def degree(polynomial), do: Enum.count(polynomial) - 1

  @doc """
  Evaluates the polynomial at a specified value
  """
  @spec value_at(polynomial, number) :: number
  def value_at(polynomial, value) do
    degree = degree(polynomial)
    evaluate(polynomial, value, degree, coefficient_of_degree(polynomial, degree))
  end

  @spec evaluate(polynomial, number, integer, number) :: number
  defp evaluate(_, _, degree, answer) when degree == 0, do: answer
  defp evaluate(polynomial, value, degree, answer) when degree > 0 do
    evaluate(polynomial, value, degree - 1, answer * value + coefficient_of_degree(polynomial, degree - 1))
  end
end
