defmodule TRMTest do
  use ExUnit.Case
  doctest TRM

  test "creates graph" do
    assert TRM.creates_graph()
  end

  test "closure algorithm" do
    assert TRM.closure_algorithm()
  end

  # test "created adjacent matrix" do
  #   assert graph = TRM.creates_graph()
  #   assert TRM.create_adjacent_matrix(graph)
  # end
end
