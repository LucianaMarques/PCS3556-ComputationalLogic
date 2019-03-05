defmodule TRM do
  @moduledoc """
  Documentation for TRM.
  """

  @doc """
    Main function of the program
  """
  def closure_algorithm do

    graph = []
    graph = graph ++ creates_graph()
    IO.inspect graph, label: "The initial graph is: " #debugging
    result = []
    result = result ++ find_nodes(graph)
    IO.inspect result, label: "The result is: " #debugging
    result
  end

  @doc """
   add your initial graph here
  """
  def creates_graph do
    [{1,2},{2,3}]
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
    Goes through Graph and find possible edges
  """
  def find_edges(graph) do
    IO.inspect [], label: "Find edges: "
    matrix = %{}
    final = []
    # add {origin -> [destin]}
    Enum.map(graph, fn x -> {add_edge(matrix, x)} end)
    # update {origin -> [destin/origin -> destines]}
    Enum.map(matrix, fn x -> {group_edges(x, matrix)} end)
    # add all groups in result
    Enum.map(matrix, fn x -> {add_result(final,x, matrix)} end)
    final
    IO.inspect final, label: "Final is: " #debugging
  end

  @doc """
    add edges from graph
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
    group edges accordingly to the connections. For example, for (1,2), (2,3):
    1 --> {2,3}
    2 --> {3}
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
