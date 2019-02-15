defmodule TRM do
  @moduledoc """
  Documentation for TRM.
  """

  @doc """

  """
  def closure_algorithm do

    graph = []
    map_set = MapSet.new()
    graph = graph ++ creates_graph()
    IO.inspect graph, label: "The initial graph is: " #debugging

    create_adjacent_matrix(graph, map_set)

    result = []
    result = result ++ find_nodes(graph)
    IO.inspect result, label: "The result is: " #debugging
    result
  end

  # add your initial graph here
  def creates_graph do
    [{1,2},{2,3}]
  end

  @doc """

  """
  def create_adjacent_matrix(graph, map_set) do
    Enum.map(graph, fn x -> {MapSet.put(map_set,x)} end)
  end

  @doc """

  """
  def find_nodes(graph) do
    result = []
    result = result ++ [{1,1}, {2,2}, {3,3}, {4,4}, {5,5}]
    result = result ++ find_edges(graph)
    result
  end

  @doc """

  """
  def find_edges(graph) do
    matrix = %{}
    final = []
    # add {origin -> [destin]}
    Enum.map(graph, fn x -> {add_edge(matrix, x)} end)
    # update {origin -> [destin/origin -> destines]}
    Enum.map(matrix, fn x -> {group_edges(x, matrix)} end)
    # add all groups in result
    Enum.map(matrix, fn x -> {add_result(final,x, matrix)} end)
    final
  end

  @doc """

  """
  def add_edge(matrix, edge) do
    {origin, destin} = edge
    if matrix[origin] == nil do
      Map.put_new(matrix, origin, [] ++ destin)
    else
      Map.get_and_update(matrix, origin, fn current_value -> {current_value, current_value ++ destin} end)
    end
  end

  @doc """

  """
  def group_edges(edge,matrix) do
    {origin, destin} = edge
    list = Map.get(matrix, origin)
    Enum.map(list, fn x -> {Map.get_and_update(matrix, origin, fn current_value -> {current_value, current_value ++ matrix[x]} end)} end)
  end

  @doc """

  """
  def add_result(result,x, matrix) do
    {origin, destin} = x
    edges = Map.get(matrix, origin)
    Enum.map(edges, fn x -> {result ++ [origin, x]} end)
  end
end
