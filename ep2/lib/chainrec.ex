use Bitwise

defmodule CHAINREC do
  @moduledoc """
  Documentation for CHAINREC.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CHAINREC.hello()
      :world

  """
  def hello do
    :world
  end

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
    # get terminals and the initial symbol
    T = elem(grammar, 0)
    N = elem(grammar, 1)
    Rules = elem(grammar, 2) # MapSet of grammar rules
    Init_sym = elem(grammar, 3)

    # Chains list, originally with Init_sym
    chains = [Init_sym]

    # Given Init_sym and grammar, create possible chains
    chains = add_chains(chains, max_size, grammar)

    # Returns the final list of possible chains
    chains

  end

  @doc """
  Receives a rule such as A -> a and returns all possible chains with max_size
  rule -> tuple of strings
  max_size -> int
  """
  def add_chains(chains, max_size, grammar) do
    # Checks for new possible chains iteratively
    # When generated chain exceeds max_size, exclude it from chains list
    c = [] # create new list to be returned in map function
    Enum.map(chains, fn chain -> c = [ c | add_new_chains(chain, grammar, max_size)] end)

    # Search for non terminals on chains with
    # size less of bigger than max_size
    if (check_non_terminals(c, non_terminals, max_size)) do
      add_chains(chains, max_size, grammar)
    end

    # Return created list
    c
  end

  @doc """
  Checks all chains for size and presence of non terminals
  Uses bitwise to get the result
  """
  def check_non_terminals(chains, non_terminals, max_size) do
    # Found is 1
    found = 1

    # Searched in every element from every chain
    Enum.map(chains, fn chain -> found = found &&& has_terminals(chain, non_terminals, 0) end)

    # Returns the result in found
    found
  end

  @doc """
  Checks a chain for non-terminal presence
  """
  def has_terminals(chain, non_terminals, position) do
    if (List.keymember?(non_terminals, chain, position)) do
      1 &&& has_terminals(chain, non_terminals, position+1)
    else
      0
    end
  end

  @doc """
  Checks a chain for non-terminal presence
  """
  def has_terminals(chain, non_terminals, position) when position == String.length(chain)-1 do
    if (List.keymember?(non_terminals, chain, position)) do
      1
    else
      0
    end
  end

  @doc """
  Function to add a new member to chains recursively
  """
  def add_new_chains(chain, grammar, max_size, non_terminals) do
    # get last chain
    # last_chain = last(chains)

    # add an extra element to the end of the list
    # and add the result to the general list of chains
    # chains = [chains | [last_chain | element]]

    # call it recursively (max_size) times
    # add_new_chain(element, max_size - 1, chains)

    # creates an empty chain list
    chain = []

    # for every element in chain, verify if it's a non terminal
    Enum.map(chain, fn element -> chain = [chain | add_new_chains(element, grammar, non_terminals)] end)
  end

  @doc """
  Checks if an element is a non-terminal
  """
  def check_nonterminal(element, non_terminals, grammar) do
    # if element is non-terminal
    if MapSet.member?(non_terminals, head) do
      true
    # if it's not a non-terminal
    else
      false
    end
  end

  @doc """
  When max_size is reached
  """
  def add_new_chain(rule, max_size, chains) when max_size == 1 do
    # get last chain
    last_chain = last(chains)

    # add an extra element to the end of the list
    # and add the result to the general list of chains
    chains = [chains | [last_chain | element]]

    # return chains
    chains
  end

  @doc """
  Check if a chain is valid given a certain grammar
  """
  def recognition(tape, grammar, max_size) do
    # generates possible chains given grammar
    chains = gen_chain(grammar,max_size)

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
