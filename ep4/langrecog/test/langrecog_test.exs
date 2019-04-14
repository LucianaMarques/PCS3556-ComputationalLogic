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

  @doc """
  Check for e rules test
  """
  test "check for e rules" do
    grammar = Map.new |> Map.put("S",["SS","(A","e"]) |> Map.put("A",["S)"])
    rules_list = ["SS","(S)","e"]
    assert LANGRECOG.contains_e_rules(rules_list) == true
    element = "S"
    assert LANGRECOG.add_new_e_rules(element, rules_list, []) == ["(S)","SS","(",")"]
    target_grammar = Map.new |> Map.put("S",["SS","(A"]) |> Map.put("A",["S)"])
    assert LANGRECOG.get_e_rules(grammar) == target_grammar
  end
end
