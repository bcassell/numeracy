defmodule PrecisionTest do
  use ExUnit.Case
  use GenServer
  doctest Numeracy

  import Numeracy.Precision

  setup do
    {:ok, pid} = GenServer.start_link(Numeracy.Precision, %{})
    {:ok, [pid: pid]}
  end

  test "can compute radix", context do
    assert GenServer.call(context[:pid], :radix) == 2
  end

  test "can compute machine precision", context do
    assert GenServer.call(context[:pid], :machine_precision) == 1.1102230246251565e-16
  end

  test "can compute negative machine precision", context do
    assert GenServer.call(context[:pid], :negative_machine_precision) == 1.1102230246251565e-16
  end
end
