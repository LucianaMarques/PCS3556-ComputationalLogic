use Bitwise

defmodule CHAINREC do
  @moduledoc """
  Documentation for CHAINREC.
  """

  @doc """
  Parse a set recursively and returns one of its elements
  """
  def rec_parse(set_list) do
    IO.puts(set_list)
    [head| tail] = set_list
    head
    List.delete_at(set_list,0)
    rec_parse(set_list)
  end

  @doc """
  What to do once the list is empty
  """
  def rec_parse(set_list) when set_list == nil do
    IO.puts("end of list")
  end

  @doc """
  Generates all possible chains given grammar and maximum size
  grammar  -> tuple
  max_size -> integer
  """
  def gen_chains(grammar, max_size) do
    # grammar -> list
    # get terminals and the initial symbol
    T = elem(grammar, 0) # MapSet
    N = elem(grammar, 1) # MapSet
    Rules = elem(grammar, 2) # Map
    Init_sym = elem(grammar, 3) # String

    # Chains list, originally with Init_sym
    chains = MapSet.new() # MapSet of Strings
    MapSet.put(chains, Init_sym)

    # Given Init_sym and grammar, create possible chains
    all_chains = add_chains(chains, max_size, Rules, N)

    # Returns the final list of possible chains
    all_chains
  end

  @doc """
  chains -> MapSet
  max_size -> Int
  rules -> Map
  non_terminals -> MapSet

  Checks for new possible chains iteratively. When generated chain exceeds max_size,
  exclude it from chains list.
  Only Chains without non_terminals are valid.
  """
  def add_chains(chains, max_size, rules, non_terminals) do
    # Creates new chain MapSet
    new_chains = MapSet.new()

    Enum.each(chains, fn chain -> add_new_chains(chain, new_chains, rules, non_terminals, max_size) end)


    # Checks if at least one generated chain still has non-terminals
    # If yes, repeats the procedure
    if (check_non_terminals(new_chains, non_terminals)) do
      add_chains(chains, max_size, rules, non_terminals)
    end
  end

  @doc """
  Checks all chains for size and presence of non terminals
  Uses bitwise to get the result
  """
  def check_non_terminals(chains, non_terminals) do
    # Found is 1
    found = 1

    # Searched in every element from every chain
    Enum.map(chains, fn chain -> found &&& has_terminals(chain, non_terminals, 0, String.length(chain)) end)

    # Returns the result in found
    found
  end

  @doc """
  Checks a chain for non-terminal presence
  """
  def has_terminals(chain, non_terminals, position, chain_size) do
    if (MapSet.member?(non_terminals, chain)) do
      1 &&& has_terminals(chain, non_terminals, position+1, chain_size)
    else
      0
    end
  end

  @doc """
  Checks a chain for non-terminal presence
  chain -> String
  non_terminals -> MapSet
  position -> integer
  """
  def has_terminals(chain, non_terminals, position, chain_size) when position == chain_size-1 do
    if (MapSet.member?(non_terminals, chain)) do
      1
    else
      0
    end
  end

  @doc """
  Function to add a new member to new_chains MapSet

  chain         -> String
  new_chains    -> MapSet
  rules         -> Map
  non_terminals -> MapSet
  max_size      -> Int
  """
  def add_new_chains(chain, new_chains, rules, non_terminals, max_size) do
    base_chain = []
    Enum.each(chain, fn element -> base_chain ++ replace_non_terminals(element, base_chain, max_size, non_terminals, rules) end)
    creates_mapset(base_chain, new_chains, max_size)
  end

  @doc """
  Adds elements in base_chain to new_chains MapSet, checking if sice <= max_size
  """
  def creates_mapset(base_chain, new_chains, max_size) do
    Enum.each(base_chain, fn b_chain -> if (String.length(b_chain) <= max_size) do MapSet.put(new_chains, b_chain) end end)
  end

  @doc """
  If element is terminal, adds it to the base chains.
  If not, applies terminal's rule.
  """
  def replace_non_terminals(element, base_chain, max_size, non_terminals, rules) do
    if (MapSet.member?(non_terminals, element) == false) do
      Enum.map(base_chain, fn b_chain -> b_chain + element end)
    else
      items = Map.get(rules, element)
      new_chains = []
      Enum.each(items, fn item -> [new_chains || Enum.map(base_chain, fn b_chain -> b_chain + item end)] end)
      new_chains
    end
  end

  @doc """
  Check if a chain is valid given a certain grammar
  """
  def recognition(tape, grammar, max_size) do
    # generates possible chains given grammar
    chains = gen_chains(grammar,max_size)

    # checks if tape is in chains
    if (MapSet.member?(chains, tape)) do # tape can be generated by grammar
      IO.puts(true)
      true
    else
      IO.puts(false) # tape cannot be generated by grammar
      false
    end
  end
end
