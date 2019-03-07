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
  Generates chain with grammar and maximum size
  grammar  -> tuple
  max_size -> integer
  """
  def gen_chainn(grammar, max_size) do
    # get terminals and the initial symbol
    T = elem(grammar, 0)
    Rules = elem(grammar, 1)
    Init_sym = elem(grammar, 2)

    # Chains list, originally empty
    chains = {}

    # For every rule, create possible chains
    Enum.map(Rules, fn R -> chains = chain + gen_chain_rule(R, max_size) end)

  end

  @doc """
  Receives a rule such as A -> a and returns all possible chains with max_size
  rule -> tuple of strings
  max_size -> int
  """
  def gen_chain_rule(rule, max_size) do
    # list of possible chains
    chains = {}

    # gets the possible chain members in tail
    {head | tail} = rule

    #adds iteratively until the chain size is equal or bigger than max_size
    add_new_chain(tail, max_size, chains)

    chains
  end

  @doc """
  Function to add a new member to chains recursively
  """
  def add_new_chain(tail, max_size, chains) do
    # get last chain
    # add an extra element
    # add result to chains
    # call it recursively
    add_new_chain(tail, max_size - 1, chains)
  end


  @doc """
  When max_size is reached
  """
  def add_new_chain(rule, max_size, chains) when max_size == 1 do
    # get last chain
    # add an extra element
    # add result to chains and return it
  end

  @doc """
  Check if a chain is valid given a certain grammar
  """
  def recognition(tape, grammar, max_size) do
    # generates possible chains given grammar
    chains = gen_chain(grammar,max_size)

    # checks if tape is in chains
    if (MapSet.member?(chains, tape)) do
      IO.puts(true)
      true
    else
      IO.puts(false)
      false
    end
  end
end
