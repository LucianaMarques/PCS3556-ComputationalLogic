defmodule TRM do
  @moduledoc """
  Documentation for TRM.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TRM.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """

  """
  def closure_algorithm do
    # add your initial graph here
    graph = []
    graph = graph ++ creates_graph()
    IO.inspect graph, label: "The initial graph is: " #debugging

    #matrix = create_adjacent_matrix(graph)
    #matrix = add_main_diagonal(matrix)
    #result = find_nodes(matrix)
  end

  def creates_graph do
    [{1,2},{2,3}]
  end

  @doc """

  """
  def create_adjacent_matrix(graph) do

  end

  @doc """

  """
  def add_main_diagonal(matrix) do

  end

  @doc """

  """
  def find_nodes(matrix) do

  end
end
