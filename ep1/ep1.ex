defmodule Transitive_Reflexive_Closure_Module do
  @moduledoc """

  """
  def closure_algorithm do
    graph = [{1,2},{2,3}]
    matrix = create_adjacent_matrix(graph)
    matrix = add_main_diagonal(matrix)
    result = find_nodes(matrix)
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
