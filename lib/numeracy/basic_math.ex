defmodule Numeracy.BasicMath do
  @moduledoc """
  Functional implementations of basic math operations to improve function composition
  """

  @doc """
  Add two numbers
  """
  @spec add(number, number) :: number
  def add(a, b), do: a + b

  @doc """
  Divide two numbers
  """
  @spec divide(number, number) :: float
  def divide(a, b) when b != 0, do: a / b

  @doc """
  Multiply two numbers
  """
  @spec multiply(number, number) :: number
  def multiply(a, b), do: a * b

  @doc """
  Subtract b from a
  """
  @spec subtract(number, number) :: number
  def subtract(a, b), do: a - b

  @doc """
  Evalute if a <= b
  """
  @spec lte(number, number) :: boolean
  def lte(a, b), do: a <= b

  @doc """
  Evalute if a < b
  """
  @spec lt(number, number) :: boolean
  def lt(a, b), do: a < b

  @doc """
  Evalute if a >= b
  """
  @spec gte(number, number) :: boolean
  def gte(a, b), do: a >= b

  @doc """
  Evalute if a > b
  """
  @spec gt(number, number) :: boolean
  def gt(a, b), do: a > b
end
