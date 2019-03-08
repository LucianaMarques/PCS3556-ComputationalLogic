defmodule CHAINRECTest do
  use ExUnit.Case
  doctest CHAINREC

  @doc """
  This test is to given a certain list of terminals, check if a chain has at least one terminal
  """
  test "checks terminal existence" do
    non_terminals = MapSet.new()
    MapSet.put(non_terminals, "A")
    MapSet.put(non_terminals, "B")
    terminal = CHAINREC.has_terminals("aAAa", non_terminals, 0, 3)
    IO.puts(terminal)
  end
end
