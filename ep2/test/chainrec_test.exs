use Bitwise
#use MapSet

defmodule CHAINRECTest do
  use ExUnit.Case
  doctest CHAINREC

  test "recursive parse" do
    #CHAINREC.recursive_parse([1])
  end

  @doc """
  This test was done to learn how to use the MapSet structure.
  There were several problems with it, and an issue in gitub was oppened:
  https://github.com/elixir-lang/elixir/issues/8953
  """
  test "crate mapset" do
    terminals = MapSet.new |> MapSet.put("A")
    assert MapSet.member?(terminals, "A") == true
  end

  @doc """
  This test is to given a certain list of terminals, check if a chain has at least one terminal
  test "checks terminal existence" do
    non_terminals = MapSet.new()
    MapSet.put(non_terminals, String.graphemes("B"))
    MapSet.put(non_terminals, String.graphemes("A"))
    chain = "aAAaA"
    IO.puts(non_terminals)
    terminal = CHAINREC.has_terminals(String.graphemes(chain), non_terminals, 0, 3)
    IO.puts(terminal)
  end
  """

  @doc """
  This tests checks in a set of chains if at least one chain has at least one terminal
  test "checks terminal existence in at least one chain" do
    chains = MapSet.new()
    MapSet.put(chains, "aaBB")
    MapSet.put(chains, "AAa")
    MapSet.put(chains, "a")
    non_terminals = MapSet.new()
    MapSet.put(non_terminals, "A")
    MapSet.put(non_terminals, "B")
    # term_exists = CHAINREC.check_non_terminals(chains, non_terminals)
    # IO.puts(term_exists)
  end
  """
end
