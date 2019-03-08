use Bitwise

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
    chain = "aAAa"
    terminal = CHAINREC.has_terminals(chain, non_terminals, 0, String.length(chain))
    IO.puts(terminal)
  end
end
