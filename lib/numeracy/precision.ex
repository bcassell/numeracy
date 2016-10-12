defmodule Numeracy.Precision do

  def compute_radix() do
    a = 1.0
    a = compute_radix_a(a, 0)
    b = 1.0
    compute_radix(a, b, 0)
  end

  defp compute_radix_a(a, tmp2) when tmp2 - 1.0 == 0.0, do: a

  defp compute_radix_a(a, _) do
    a = a + a
    tmp1 = a + 1.0
    tmp2 = tmp1 - a
    compute_radix_a(a, tmp2)
  end

  defp compute_radix(_, _, radix) when radix != 0, do: radix

  defp compute_radix(a, b, _) do
    b = b + b
    tmp = a + b
    compute_radix(a, b, round(tmp - a))
  end

  def compute_machine_precision(radix) do
    inverse_radix = 1.0 / radix
    machine_precision = 1.0
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  def compute_machine_precision(machine_precision, _, acc) when acc - 1.0 == 0.0, do: machine_precision

  def compute_machine_precision(machine_precision, inverse_radix, _) do
    machine_precision = machine_precision * inverse_radix
    acc = 1.0 + machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end

  def compute_negative_machine_precision(radix) do
    inverse_radix = 1.0 / radix
    machine_precision = 1.0
    acc = 1.0 - machine_precision
    compute_negative_machine_precision(machine_precision, inverse_radix, acc)
  end

  def compute_negative_machine_precision(machine_precision, inverse_radix, _) do
    machine_precision = machine_precision * inverse_radix
    acc = 1.0 - machine_precision
    compute_machine_precision(machine_precision, inverse_radix, acc)
  end
end