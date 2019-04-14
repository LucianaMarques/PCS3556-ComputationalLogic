defmodule LANGRECOG do
  @moduledoc """
  Documentation for LANGRECOG.
  """

  @doc """
  checks for long rules and apply the correspondent transformation
  def long_rule(grammar,non-terminals) do
    non-terminals-list = MapSet.to_list(non-terminals)

    # End of analysing the non-terminals
    if (List.first(non-terminals) == nil) do
      grammar
    else
      # get current rule
      current_rule = List.first(non-terminals-list)

      # get the list of possible rules for current_rule
      possible_rules = grammar[current_rule]

      # update possible rule
      {new_rule, new_terminal_and_rule} = get_long_rules(possible_rules, non-terminals, 0, grammar)
    end
  end
  """

  @doc """
  check for long rules
  """
  def get_long_rules(possible_rules, non_term, last_letter, rules, current_term, result) do
    current = List.first(possible_rules)
    # IO.puts(current)
    if (current != nil) do
      size = String.length(current)
      new_possible_rules = List.delete_at(possible_rules,0)
      if (size<3) do
        # IO.puts("found small rule")
        result2 = List.flatten(result++[current])
        get_long_rules(new_possible_rules,non_term,last_letter,rules,current_term,result2)
      else
        # IO.puts("found long string")
        new_non_term = random_letter(last_letter, non_term)
        non_term2 = MapSet.put(non_term, new_non_term)
        {first, last} = String.split_at(current,1)
        # do it for the rest of the possible rules
        result2 = List.flatten(result++[first<>new_non_term])
        new_rule_map = Map.put(rules,new_non_term, [last])
        get_long_rules(new_possible_rules,non_term2,last_letter+1,new_rule_map,current_term,result2)
      end
    else
    update_rules1 = Map.delete(rules,current_term)
    update_rules = Map.put(update_rules1,current_term,result)
    {result,non_term,update_rules}
    end
  end

  def random_letter(last_letter, non_terminals) do
    cond do
      last_letter == 0 ->
        if (MapSet.member?(non_terminals,"A") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "A"
        end
      last_letter == 1 ->
        if (MapSet.member?(non_terminals,"B") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "B"
        end
      last_letter == 2 ->
        if (MapSet.member?(non_terminals,"C") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "C"
        end
      last_letter == 3 ->
        if (MapSet.member?(non_terminals,"D") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "D"
        end
      last_letter == 4 ->
        if (MapSet.member?(non_terminals,"E") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "E"
        end
      last_letter == 5 ->
        if (MapSet.member?(non_terminals,"F") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "F"
        end
      last_letter == 6 ->
        if (MapSet.member?(non_terminals,"G") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "G"
        end
      last_letter == 7 ->
        if (MapSet.member?(non_terminals,"H") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "H"
        end
      last_letter == 8 ->
        if (MapSet.member?(non_terminals,"I") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "I"
        end
      last_letter == 9 ->
        if (MapSet.member?(non_terminals,"J") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "J"
        end
      last_letter == 10 ->
        if (MapSet.member?(non_terminals,"K") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "K"
        end
      last_letter == 11 ->
        if (MapSet.member?(non_terminals,"L") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "L"
        end
      last_letter == 12 ->
        if (MapSet.member?(non_terminals,"M") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "M"
        end
      last_letter == 13 ->
        if (MapSet.member?(non_terminals,"N") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "N"
        end
      last_letter == 14 ->
        if (MapSet.member?(non_terminals,"O") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "O"
        end
      last_letter == 15 ->
        if (MapSet.member?(non_terminals,"P") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "P"
        end
      last_letter == 16 ->
        if (MapSet.member?(non_terminals,"Q") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "Q"
        end
      last_letter == 17 ->
        if (MapSet.member?(non_terminals,"R") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "R"
        end
      last_letter == 18 ->
        if (MapSet.member?(non_terminals,"S") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "S"
        end
      last_letter == 19 ->
        if (MapSet.member?(non_terminals,"T") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "T"
        end
      last_letter == 20 ->
        if (MapSet.member?(non_terminals,"U") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "U"
        end
      last_letter == 21 ->
        if (MapSet.member?(non_terminals,"V") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "V"
        end
      last_letter == 22 ->
        if (MapSet.member?(non_terminals,"W") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "W"
        end
      last_letter == 23 ->
        if (MapSet.member?(non_terminals,"X") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "X"
        end
      last_letter == 24 ->
        if (MapSet.member?(non_terminals,"Y") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "Y"
        end
      last_letter == 25 ->
        if (MapSet.member?(non_terminals,"Z") == true) do
          random_letter(last_letter + 1, non_terminals)
        else
          "Z"
        end
    end
  end
end
