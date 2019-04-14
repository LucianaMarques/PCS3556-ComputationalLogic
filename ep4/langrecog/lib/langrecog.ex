defmodule LANGRECOG do
  @moduledoc """
  Documentation for LANGRECOG.
  """

  @doc """
  checks for long rules and apply the correspondent transformation
  """
  def long_rule(grammar,non_terms) do
    k = Map.keys(grammar)
    key = List.first(k)
    get_long_rules(grammar[key], non_terms, 0, grammar, key, [])
  end

  @doc """
  check for long rules
  possible_rules -> list
  non_terms -> MapSet
  last_letter -> int
  rules -> Map
  current_term -> String
  result -> list
  """
  def get_long_rules(possible_rules, non_term, last_letter, rules, current_term, result) do
    # current rule being analysed
    current = List.first(possible_rules)
    # if not in the end of the list
    if (current != nil) do
      # lets see if we need to change anything
      size = String.length(current)
      new_possible_rules = List.delete_at(possible_rules,0)
      # in case not, just keep going
      if (size<3) do
        result2 = List.flatten(result++[current])
        get_long_rules(new_possible_rules,non_term,last_letter,rules,current_term,result2)
      # in case yes
      else
        # get the new letter for the non-terminal
        new_non_term = random_letter(last_letter, non_term)
        # put it into the MapSet
        non_term2 = MapSet.put(non_term, new_non_term)
        # split the current rule
        {first, last} = String.split_at(current,1)
        # update the resulting new rules created for the current non-terminal
        result2 = List.flatten(result++[first<>new_non_term])
        # add in the map the new non-term and the rule to it
        new_rule_map = Map.put(rules,new_non_term, [last])
        # keep doing this for the rest of the found rules of the current element
        get_long_rules(new_possible_rules,non_term2,last_letter+1,new_rule_map,current_term,result2)
      end
    else
    # after the end, just add the new rules for the curren term in the map
    update_rules1 = Map.delete(rules,current_term)
    update_rules = Map.put(update_rules1,current_term,result)
    {result,non_term,update_rules}
    end
  end

  @doc """
  Gets the rule map and returns the rule keys that contain an "e" rule
  rules -> Map of rules
  """
  def get_e_rules(rules) do
    # get all the map keys
    k = Map.keys(rules)
    contain_e_rules1 = check_for_e_rules(rules,k,[])
    contain_e_rules = e_rules(contain_e_rules1,k,[],rules)
    new_grammar = Map.new
    rules2 = change_rules(rules,contain_e_rules,new_grammar)
  end

  def e_rules(contain_e_rules,keys,result,rules) do
    y = MapSet.new(contain_e_rules)
    z = Enum.reject(keys, fn x -> MapSet.member?(y) end)
    check_for_e_rules(rules, z, [])
  end

  @doc """
  rules -> Map of Rules
  k -> List of String
  result -> List of String
  """
  def check_for_e_rules(rules, k, result) do
    if (List.first(k) == nil) do
      result
    else
      current = List.first(k)
      k2 = List.delete_at(k,0)
      if (contains_e_rules(rules[current]) == true) do
        result2 = List.flatten(result++[current])
        check_for_e_rules(rules, k2, result2)
      else
        check_for_e_rules(rules, k2, result)
      end
    end
  end

  @doc """
  rules_list -> List of String
  """
  def contains_e_rules(rules_list) do
    if (List.first(rules_list) == nil) do
      false
    else
      current = List.first(r@doc """
      rules_list -> List of String
      """
      def contains_e_rules(rules_list,element) do
        if (List.first(rules_list) == nil) do
          false
        else
          current = List.first(rules_list)
          if (current == "e") do
            true
          else
            rules_list2 = List.delete_at(rules_list,0)
            contains_e_rules(rules_list2)
          end
        end
      endules_list)
      if (current == "e") do
        true
      else
        rules_list2 = List.delete_at(rules_list,0)
        contains_e_rules(rules_list2)
      end
    end
  end

  @doc """
  rules_list -> List of String
  element -> String
  """
  def contains_e_rules(rules_list,element) do
    if (List.first(rules_list) == nil) do
      false
    else
      current = List.first(rules_list)
      if (current == "e") do
        true
      else
        rules_list2 = List.delete_at(rules_list,0)
        contains_e_rules(rules_list2)
      end
    end
  end

  @doc """
  key -> String
  key_rules -> List of String
  result -> List of String
  """
  def add_new_e_rules(key, key_rules, result) do
    if (List.first(key_rules) == nil) do
      result
    else
      current = List.first(key_rules)
      key_rules2 = List.delete_at(key_rules,0)
      if (String.contains?(current,key) == true) do
        splits = String.split(current,key)
        result2 = Enum.reject(splits, fn x -> x == "" end)
        result3 = Enum.reject(result2, fn x -> x == "e" end)
        if (length(result3) == 0) do
          result2 = List.flatten([current]++result)
          add_new_e_rules(key, key_rules2, result2)
        else
          result3 = List.flatten([current]++result++result2)
          add_new_e_rules(key, key_rules2, result3)
        end
      else
        cond do
          current == "e" ->
            add_new_e_rules(key, key_rules2, result)
          current != "e" ->
            result2 = result++[current]
            add_new_e_rules(key, key_rules2, result2)
        end
      end
    end
  end

  @doc """
  rules -> Map
  contain_e_rules -> List of String
  new_rules -> List of String
  """
  def change_rules(rules,contain_e_rules,new_rules) do
    if (List.first(contain_e_rules) == nil) do
      new_rules
    else
      current = List.first(contain_e_rules)
      contain_e_rules2 = List.delete_at(contain_e_rules,0)
      new_r = add_new_e_rules(current, rules[current], [])
      new_rules2 = Map.put(new_rules, current, new_r)
      change_rules(rules,contain_e_rules2,new_rules2)
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
