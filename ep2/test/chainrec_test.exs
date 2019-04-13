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
  get the rule's prefix
  """
  test "get rule prefix" do
    rule = "aA"
    terminals = MapSet.new |> MapSet.put("A") |> MapSet.put("B")
    assert CHAINREC.get_add_elements(rule, terminals, "") == "a"
  end

  @doc """
  generates the rule's sub chains until max
  """
  test "generate sub chains" do
    rules_map = Map.new |> Map.put("A","aA") |> Map.put("B","bB")
    terminals = MapSet.new |> MapSet.put("A") |> MapSet.put("B")
    max = 3
    rule = "aA"
    add = CHAINREC.get_add_elements(rule, terminals, "")
    assert CHAINREC.get_subchain(max, [], add, rules_map) == ["a", "aa", "aaa"]
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
