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
  test to combine lists
  """
  test "combine subchains" do
    list = ["111","21"]
    rule_chains = ["4","5"]
    max = 3
    #assert CHAINREC.combine_lists(list,rule_chains,max,[]) == ["214","215"]
  end

  @doc """
  given a rule, get the possible subchains
  """
  test "rule subchains" do
    max = 3
    rules_map = Map.new |> Map.put("A","aA") |> Map.put("B","bB")
    terminals = MapSet.new |> MapSet.put("A") |> MapSet.put("B")
    terminal = "A"
    rule = rules_map[terminal]
    add = CHAINREC.get_add_elements(rule, terminals, "")
    CHAINREC.get_subchain(max, [], add, rules_map) == ["a","aa","aaa"]
  end

  @doc """
  test to combine possible subchains
  """
  test "get all subchains" do
    first_rule = "AB"
    rules_map = Map.new |> Map.put("A","aA") |> Map.put("B","bB")
    terminals = MapSet.new |> MapSet.put("A") |> MapSet.put("B")
    max = 3
    {terminal, new_first_rule} = String.split_at(first_rule,1)
    rule = rules_map[terminal]
    #IO.puts(rule)
    add = CHAINREC.get_add_elements(rule, terminals, "")
    #IO.puts(add)
    # gets the possible subchains
    rule_chains = CHAINREC.get_subchain(max, [], add, rules_map)
    element = "4"
    #assert CHAINREC.combine_subchains([], first_rule, rules_map, max, terminals) == ["a","b","ab","aab","abb"]
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
