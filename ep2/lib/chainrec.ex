use Bitwise

defmodule CHAINREC do
  @moduledoc """
  Documentation for CHAINREC.
  """

  @doc """
  parse a recursively a list and prints one of its elements
  """
  def recursive_parse(list) do
    if (List.first(list) == nil) do
      IO.puts("End of List")
    else
      IO.puts(List.first(list))
      list2 = List.delete_at(list,0)
      recursive_parse(list2)
    end
  end

  @doc """
  function to get subchains accordingly to a rule
  max -> int (maximum subchain size)
  list -> list of String (list of already computed subchains)
  add -> string (rule prefix got with get_add_elements())
  rules_map -> Map<string,string> (map of terminals to their respective rules)
  """
  def get_subchain(max, list, add, rules_map) do
    # if list is empty, add the first subchain as the simple prefix
    if (List.first(list) == nil) do
      list2 = List.flatten([add])
      get_subchain(max,list2,add,rules_map)
    else
      # get last computed subchain
      current = List.last(list)
      # if not empty, get the size of the last computed subchain
      # if size is equal to max, nothing to add anymore
      if (String.length(current) == max) do
        List.flatten(list)
      else
        # if not equal to max, then add the prefix
        element = current<>add
        # if the result is a string of size bigger than max,
        # just return the previous list
        if (String.length(element) > max) do
          List.flatten(list)
        else
          # if not, append the result to the list
          list2 = List.flatten(list++[element])
          # and keep searching
          get_subchain(max,list2,add,rules_map)
        end
      end
    end
  end

  @doc """
  Given a list of terminals and a rule, get the elements to be added
  rule -> string
  T -> MapSet
  add -> final generated string
  """
  def get_add_elements(rule, terminals, add) do
    {current,rule2} = String.split_at(rule,1)
    if (MapSet.member?(terminals, current)) do
      add
    else
      add2 = add<>current
      get_add_elements(rule2,terminals,add2)
    end
  end

  @doc """
  Generates all possible chains given grammar and maximum size
  list -> List
  first_rule -> String
  rules_map -> Map
  max -> int
  terminals -> MapSet
  """
  def combine_subchains(list, first_rule, rules_map, max, terminals) do
    # if end of the first rule, just return the list created
    if (String.first(first_rule) == nil) do
      List.flatten(list)
    else
      # gets the current rule and updates firs_rule
      {terminal, new_first_rule} = String.split_at(first_rule,1)
      rule = rules_map[terminal]

      # gets the rule's prefix
      add = get_add_elements(rule, terminals, "")

      # gets the possible subchains
      rule_chains = get_subchain(max, [], add, rules_map)

      # if no previous computed subchain, just add the rule's subchains
      if (List.first(list) == nil) do
        list2 = List.flatten(list++[rule_chains])
        combine_subchains(list2,new_first_rule,rules_map,max,terminals)
      else
        # combine the rule's subchains with the already computed ones
        list2 = combine_lists(list,rule_chains,max,[])
        combine_subchains(list2,new_first_rule,rules_map,max,terminals)
      end
    end
  end

  @doc """
  A function that combines elements in list with rule_chains and stores it in result
  If a possible combination's size is bigger than max, then it's not added
  list -> List of String
  rule_chains -> Map
  max -> int
  result -> List of String
  """
  def combine_lists(list,rule_chains,max,result) do
    # When list is empty, just return the computed combinations
    if (List.first(list) == nil) do
      List.flatten(result)
    else
      # Get the current element being added
      element = List.first(list)
      # Add the element to all in rule_chains, checking their size is (<= max)
      list2 = List.flatten(Enum.map(rule_chains, fn x -> if(String.length(element<>x) <= max) do element<>x end end))
      list4 = Enum.reject(list2, &is_nil/1)
      # Updates the list that holds the combining elements
      list3 = List.delete_at(list,0)
      # Keep going until 'list' is empty
      combine_lists(list3,rule_chains,max,List.flatten(result++list4))
    end
  end
end
