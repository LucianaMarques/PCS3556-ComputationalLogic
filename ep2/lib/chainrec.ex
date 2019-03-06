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
  def rec_parse(set_list) when set_list = nil do
    IO.puts("end of list")
  end
end