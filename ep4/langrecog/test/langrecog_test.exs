defmodule LANGRECOGTest do
  use ExUnit.Case
  doctest LANGRECOG

  test "long rules" do
    grammar = Map.new |> Map.put("S",["SS","(S)","e"])
    non_terminals = MapSet.new |> MapSet.put("S")
    target_map = MapSet.new |> MapSet.put("A") |> MapSet.put("S")
    target_grammar = Map.new |> Map.put("S",["SS","(A","e"]) |> Map.put("A",["S)"])
    assert LANGRECOG.get_long_rules(["SS","(S)","e"], non_terminals, 0, grammar,"S",[]) == {["SS","(A","e"],target_map, target_grammar}
  end

  test "get new grammar" do
    grammar = Map.new |> Map.put("S",["SS","(S)","e"])
    non_terms = MapSet.new |> MapSet.put("S")
    target_grammar = Map.new |> Map.put("S",["SS","(A","e"]) |> Map.put("A",["S)"])
    {result,non_term,update_rules} = LANGRECOG.long_rule(grammar,non_terms)
    assert update_rules == target_grammar
  end

end
