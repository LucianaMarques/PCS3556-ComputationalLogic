defmodule TRMTest do
  use ExUnit.Case
  doctest TRM

  test "creates graph" do
    assert TRM.creates_graph()
  end

  test "closure algorithm" do
    assert TRM.closure_algorithm()
  end

end
